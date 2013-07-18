//
//  TWSValidator.h
//  Tweety
//
//  Created by Aleksandr Belov on 7/15/13.
//  Copyright (c) 2013 Aleksandr Belov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWSValidator : NSObject

+ (NSArray *) getArrayWithObject : (id) object;
+ (NSDictionary *) getDictionaryWithObject : (id) object;
+ (NSMutableDictionary *) getValidBankWithArray : (NSArray *) array;

@end
