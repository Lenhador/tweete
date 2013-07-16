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
        return [NSArray array];
}

+ (NSDictionary *) getDictionaryWithObject:(id)object {
    if([object isKindOfClass:[NSDictionary class]])
        return object;
    else
        return [NSDictionary dictionary];
}

+ (NSDictionary *) getValidBankWithArray : (NSArray *) array  {
    
    NSDictionary *actualAddresses = [[NSDictionary alloc] init];
    NSMutableArray *adresses = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < array.count; i++) {
        
        NSString *bank = [NSString stringWithFormat:@"%@ %@", [array[i] valueForKey:@"name"], [array[i] valueForKey:@"name"]];
        if(adresses.count == 0) {
            NSRange range = [bank rangeOfString:@"СБЕРБАНК"];
            if(range.length > 0) {
                [actualAddresses setValue:bank forKey:@"sberbank"];
            }
            range = [bank rangeOfString:@"Банк Втб"];
            if(range.length > 0) {
                [actualAddresses setValue:bank forKey:@"vtb"];
            }
            range = [bank rangeOfString:@"Балтийский Банк"];
            if(range.length > 0) {
                [actualAddresses setValue:bank forKey:@"vtb"];
            }
        }
        else {
            if(![adresses[i] isEqualToString:bank]) {
                
                NSRange range = [bank rangeOfString:@"СБЕРБАНК"];
                if(range.length > 0) {
                    [actualAddresses setValue:bank forKey:@"sberbank"];
                }
                range = [bank rangeOfString:@"Банк Втб"];
                if(range.length > 0) {
                    [actualAddresses setValue:bank forKey:@"vtb"];
                }
                range = [bank rangeOfString:@"Балтийский Банк"];
                if(range.length > 0) {
                    [actualAddresses setValue:bank forKey:@"vtb"];
                }
                
                
            }
        }
        NSLog(@"%@", actualAddresses);
        
    }
    
    return actualAddresses;

}
@end
