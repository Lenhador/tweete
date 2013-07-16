//
//  ViewController.m
//  SingletonGPS
//
//  Created by Aleksandr Belov on 5/24/13.
//  Copyright (c) 2013 Lenhador. All rights reserved.
//

#import "FirstViewController.h"
#import "SingletonGPS.h"

@interface FirstViewController ()
@property SingletonGPS *singletonObj;
@end

@implementation FirstViewController
@synthesize showLocationLabel;
@synthesize singletonObj;

- (void)viewDidLoad
{
    [super viewDidLoad];    
    singletonObj = [SingletonGPS sharedInstanse];
    [singletonObj addObserver:self forKeyPath:@"location" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [showLocationLabel setText:[change objectForKey:@"new"]];
}
@end
