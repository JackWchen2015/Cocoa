//
//  NSString+Unicode2UTF8.m
//  Xliff2Strings
//
//  Created by ChenWu on 2017/11/3.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import "NSString+Unicode2UTF8.h"

@implementation NSString (Unicode2UTF8)
-(NSString*)Unicode2UTF8;
{
    NSString* tepStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    
    NSString* tepStr2 = [self stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    
    NSString* tepStr3 = [[@"\""  stringByAppendingString:tepStr2]stringByAppendingString:@"\""];
    
    NSData* tepData = [tepStr3  dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* axiba = [NSPropertyListSerialization    propertyListWithData:tepData options:NSPropertyListMutableContainers
                      
                                                                   format:NULL error:NULL];
    
    return  [axiba   stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    
}
@end
