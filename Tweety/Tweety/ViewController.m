//
//  ViewController.m
//  Tweety
//
//  Created by Aleksandr Belov on 7/14/13.
//  Copyright (c) 2013 Aleksandr Belov. All rights reserved.
//

#import "ViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "TWSBankList.h"
#import "TWSValidator.h"
#import "GMapDataModel.h"

@interface ViewController ()
@property (nonatomic) ACAccount *twitterAccount;
@end

@implementation ViewController

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    GMapDataModel *map = [[GMapDataModel alloc] init];
    [map startUpdateLocation];
    // This notification is posted when the accounts managed by this account store changed in the database.
    // When you receive this notification, you should refetch all account objects.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(canTweetStatus) name:ACAccountStoreDidChangeNotification object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.easyTweetButton = nil;
    self.customTweetButton = nil;
    self.outputTextView = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    // Check to make sure our UI is set up appropriately, depending on if we can tweet or not.
    //[self twitterAccount];
    [self canTweetStatus];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (ACAccount *) twitterAccount {
    
    if(_twitterAccount == nil) {
        
        // Create an account store object.
        ACAccountStore *accountStore = [[ACAccountStore alloc] init];
        
        // Create an account type that ensures Twitter accounts are retrieved.
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
                if(granted) {
                    // Get the list of Twitter accounts.
                    NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
                    
                    // For the sake of brevity, we'll assume there is only one Twitter account present.
                    // You would ideally ask the user which account they want to tweet from, if there is more than one Twitter account present.
                    if ([accountsArray count] > 0) {
                        // Grab the initial Twitter account to tweet from.
                        _twitterAccount = [accountsArray lastObject];
                        SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"http://api.twitter.com/1.1/search/tweets.json"]  parameters:[NSDictionary dictionaryWithObject:TWEETY_SBERBANK forKey:@"q"]];
                        
                        // Set the account used to post the tweet.
                        [postRequest setAccount:_twitterAccount];
                        
                        // Perform the request created above and create a handler block to handle the response.
                        [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                            if(error) {
                                NSLog(@"%@", [error localizedDescription]);
                            }

                            NSString *output = [NSString stringWithFormat:@"HTTP response status: %i", [urlResponse statusCode]];
                            NSArray *result = [TWSValidator getArrayWithObject:[[[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil] valueForKey:@"statuses"] valueForKey:@"text"]];
                            
                            
                            [self performSelectorOnMainThread:@selector(displayText:) withObject:result[4] waitUntilDone:NO];
                        }];

                    }
                }
                else {
                    NSLog(@"Аккаунт не найден в хранилище");
                }
            }];
     
    }
    
    return _twitterAccount;
}
         
- (IBAction)sendEasyTweet:(id)sender {
    // Set up the built-in twitter composition view controller.
    SLComposeViewController *tweetViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    // Set the initial tweet text. See the framework for additional properties that can be set.
    [tweetViewController setInitialText:@"Hello. This is a tweet."];
    
    // Create the completion handler block.
    [tweetViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *output;
        
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                // The cancel button was tapped.
                output = @"Tweet cancelled.";
                break;
            case SLComposeViewControllerResultDone:
                // The tweet was sent.
                output = @"Tweet done.";
                break;
            default:
                break;
        }
        
        [self performSelectorOnMainThread:@selector(displayText:) withObject:output waitUntilDone:NO];
        
        // Dismiss the tweet composition view controller.
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    // Present the tweet composition view controller modally.
    [self presentViewController:tweetViewController animated:YES completion:nil];
}


- (IBAction)sendCustomTweet:(id)sender {
	
                
				// Create a request, which in this example, posts a tweet to the user's timeline.
				// This example uses version 1 of the Twitter API.
				// This may need to be changed to whichever version is currently appropriate.
                
                SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"http://api.twitter.com/1.1/search/tweets.json"]  parameters:[NSDictionary dictionaryWithObject:TWEETY_SBERBANK forKey:@"q"]];
                
				// Set the account used to post the tweet.
				[postRequest setAccount:self.twitterAccount];
                
				// Perform the request created above and create a handler block to handle the response.
				[postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    if(error) {
                        NSLog(@"%@", [error localizedDescription]);
                    }
                    NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil]);
					NSString *output = [NSString stringWithFormat:@"HTTP response status: %i", [urlResponse statusCode]];
					[self performSelectorOnMainThread:@selector(displayText:) withObject:output waitUntilDone:NO];
				}];
}


- (IBAction)getPublicTimeline:(id)sender {
	// Create a request, which in this example, grabs the public timeline.
	// This example uses version 1 of the Twitter API.
	// This may need to be changed to whichever version is currently appropriate.
    SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                requestMethod:SLRequestMethodGET
                                                          URL:[NSURL URLWithString:@"http://api.twitter.com/1.1/statuses/public_timeline.json"] parameters:nil];
    
	// Perform the request created above and create a handler block to handle the response.
	[postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
		NSString *output;
        
		if ([urlResponse statusCode] == 200) {
			// Parse the responseData, which we asked to be in JSON format for this request, into an NSDictionary using NSJSONSerialization.
			NSError *jsonParsingError = nil;
			NSDictionary *publicTimeline = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonParsingError];
			output = [NSString stringWithFormat:@"HTTP response status: %i\nPublic timeline:\n%@", [urlResponse statusCode], publicTimeline];
		}
		else {
			output = [NSString stringWithFormat:@"HTTP response status: %i\n", [urlResponse statusCode]];
		}
        
		[self performSelectorOnMainThread:@selector(displayText:) withObject:output waitUntilDone:NO];
	}];
}


- (void)displayText:(NSString *)text {
	self.outputTextView.text = text;
}


// This method checks if we are able to tweet from the application.
// We set the UI appropriately if Twitter is available and if a Twitter account is present.
// This is called when the app loads initially and if the ACAccountStore changes while the app is being used.
- (void)canTweetStatus {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        self.easyTweetButton.enabled = YES;
        self.easyTweetButton.alpha = 1.0f;
        self.customTweetButton.enabled = YES;
        self.customTweetButton.alpha = 1.0f;
    } else {
        self.easyTweetButton.enabled = NO;
        self.easyTweetButton.alpha = 0.5f;
        self.customTweetButton.enabled = NO;
        self.customTweetButton.alpha = 0.5f;
    }
}


@end