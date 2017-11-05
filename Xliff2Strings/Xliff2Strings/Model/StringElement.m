//
//  StringElement.m
//  Xliff2Strings
//
//  Created by ChenWu on 2017/10/10.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import "StringElement.h"

@implementation StringElement

-(NSString*)debugDescription
{
    return [NSString stringWithFormat:@"\"%@\"=\"%@\";",
            _source,_note];
}
-(NSString*)description
{
    return [NSString stringWithFormat:@"%@=%@",
            _source,_note];
}
@end
