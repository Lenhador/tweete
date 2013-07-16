//
//  ViewController.h
//  Tweety
//
//  Created by Aleksandr Belov on 7/14/13.
//  Copyright (c) 2013 Aleksandr Belov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *easyTweetButton;
@property (strong, nonatomic) IBOutlet UIButton *customTweetButton;
@property (strong, nonatomic) IBOutlet UITextView *outputTextView;

- (IBAction)sendEasyTweet:(id)sender;
- (IBAction)sendCustomTweet:(id)sender;
- (IBAction)getPublicTimeline:(id)sender;
- (void)displayText:(NSString *)text;
- (void)canTweetStatus;

@end
