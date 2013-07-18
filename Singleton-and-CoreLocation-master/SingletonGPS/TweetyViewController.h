//
//  ViewController.h
//  SingletonGPS
//
//  Created by Aleksandr Belov on 5/24/13.
//  Copyright (c) 2013 Lenhador. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollingNavigationViewController.h"

@interface TweetyViewController : ScrollingNavigationViewController <ScrollingNavigationDelegate>

@property (strong, nonatomic) IBOutlet UIButton *easyTweetButton;
@property (strong, nonatomic) IBOutlet UIButton *customTweetButton;
@property (strong, nonatomic) IBOutlet UITextView *outputTextView;

- (IBAction)sendEasyTweet:(id)sender;
- (IBAction)sendCustomTweet:(id)sender;
- (IBAction)getPublicTimeline:(id)sender;
- (void)displayText:(NSString *)text;
- (void)canTweetStatus;

@end
