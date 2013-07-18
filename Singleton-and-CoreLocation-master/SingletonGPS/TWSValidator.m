//
//  TWSValidator.m
//  Tweety
//
//  Created by Aleksandr Belov on 7/15/13.
//  Copyright (c) 2013 Aleksandr Belov. All rights reserved.
//

#import "TWSValidator.h"
#import "TWSBankList.h"

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
+ (NSString *) checkOnCoincidenceWithString : (NSString *) string {
    
    NSRange range;
    
    range = [string rangeOfString:SBERBANK];    
    if(range.length == SBERBANK.length)
        return SBERBANK;
    
    range = [string rangeOfString:VTB];
    if(range.length == VTB.length)
        return VTB;
    
    range = [string rangeOfString:ALFA_BANK];
    if(range.length == ALFA_BANK.length)
        return ALFA_BANK;
    
    range = [string rangeOfString:SVYAZNOY_BANK];
    if(range.length == SVYAZNOY_BANK.length)
        return SVYAZNOY_BANK;
    
    range = [string rangeOfString:TRUST_RU];
    if(range.length == TRUST_RU.length)
        return TRUST_RU;
    
    range = [string rangeOfString:BANK_SPB];
    if(range.length == BANK_SPB.length)
        return BANK_SPB;
    
    range = [string rangeOfString:HOMECREDIT_BANK];
    if(range.length == HOMECREDIT_BANK.length)
        return HOMECREDIT_BANK;
    
    range = [string rangeOfString:BALT_BANK];
    if(range.length == BANK_SPB.length)
        return BALT_BANK;
    
    range = [string rangeOfString:ROS_BANK];
    if(range.length == ROS_BANK.length)
        return ROS_BANK;
    
    range = [string rangeOfString:BALT_INVEST_BANK];
    if(range.length == BALT_INVEST_BANK.length)
        return BALT_INVEST_BANK;
    
    range = [string rangeOfString:OTP_BANK];
    if(range.length == OTP_BANK.length)
        return OTP_BANK;
    
    range = [string rangeOfString:CONTACT_BANK];
    if(range.length == CONTACT_BANK.length)
        return CONTACT_BANK;
    
    range = [string rangeOfString:UNI_CREDIT_BANK];
    if(range.length == UNI_CREDIT_BANK.length)
        return UNI_CREDIT_BANK;
    
    range = [string rangeOfString:URALSIB_BANK];
    if(range.length == URALSIB_BANK.length)
        return URALSIB_BANK;
    
    range = [string rangeOfString:AVANGARD_BANK];
    if(range.length == AVANGARD_BANK.length)
        return AVANGARD_BANK;
    
    range = [string rangeOfString:SOVETSKI_BANK];
    if(range.length == SOVETSKI_BANK.length)
        return SOVETSKI_BANK;
    
    range = [string rangeOfString:AK_BARS_BANK];
    if(range.length == AK_BARS_BANK.length)
        return AK_BARS_BANK;
    
    range = [string rangeOfString:FKB_BANK];
    if(range.length == FKB_BANK.length)
        return FKB_BANK;

    return nil;
}

+ (NSMutableDictionary *) getValidBankWithArray : (NSArray *) array  {
    
    NSMutableDictionary *actualAddresses = [[NSMutableDictionary alloc] init];
    NSMutableArray *adresses = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < array.count; i++) {
        
        NSString *name = [array[i] objectForKey:@"name"];
        NSString *vicinity = [array[i] objectForKey:@"vicinity"];
        
        NSString *bank = [NSString stringWithFormat:@"%@ %@", name, vicinity];
        
        NSString *key = [TWSValidator checkOnCoincidenceWithString:bank];

        if(key) {
            
            if(adresses.count == 0) {
                
                [actualAddresses setObject:bank forKey:key];
            }
            else {
                
                NSString *adressesItem = adresses[0];
                
                if(![adressesItem isEqualToString:bank]) {
                    
                    [actualAddresses setObject:bank forKey:key];
                }
                
                [adresses removeAllObjects];
            }
        }
        
        [adresses addObject:bank];

    }

    return actualAddresses;

}
@end
