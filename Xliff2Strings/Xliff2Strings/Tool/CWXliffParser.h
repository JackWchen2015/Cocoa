//
//  CWXliffParser.h
//  Xliff2Strings
//
//  Created by ChenWu on 2017/10/10.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringElement.h"


typedef void(^parseComplete)(void);
@interface CWXliffParser : NSObject
@property(nonatomic,strong) NSMutableArray<StringElement*>*   stringKeyAry;
@property(nonatomic,copy)parseComplete  completeBlock;

-(void)parseWithPath:(NSString*)path;

-(NSString*)parserResult;
@end
