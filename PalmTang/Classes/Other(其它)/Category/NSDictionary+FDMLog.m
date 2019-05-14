//
//  NSDictionary+FDMLog.m
//  BuDeJie
//
//  Created by 柯南 on 2018/10/12.
//  Copyright © 2018 FDM. All rights reserved.
//

#import "NSDictionary+FDMLog.h"

@implementation NSDictionary (FDMLog)

#if DEBUG
- (NSString *)descriptionWithLocale:(nullable id)locale{
    
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
}
#endif

@end
