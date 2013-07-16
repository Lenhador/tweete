//
//  TWSValidator.m
//  Tweety
//
//  Created by Aleksandr Belov on 7/15/13.
//  Copyright (c) 2013 Aleksandr Belov. All rights reserved.
//

#import "TWSValidator.h"

@implementation TWSValidator

+ (NSArray *) getArrayWithObject:(id)object {
    if([object isKindOfClass:[NSArray class]])
        return object;
    else
        return nil;
}
@end
