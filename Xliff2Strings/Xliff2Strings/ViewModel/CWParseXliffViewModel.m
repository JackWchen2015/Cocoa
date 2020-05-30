//
//  CWParseXliffViewModel.m
//  Xliff2Strings
//
//  Created by Jack Chen on 2020/5/30.
//  Copyright © 2020 iwown. All rights reserved.
//

#import "CWParseXliffViewModel.h"
#import "CWXliffParser.h"
#import "NSString+Unicode2UTF8.h"
@interface CWParseXliffViewModel()
{
    CWXliffParser*  parser;
}
@end
@implementation CWParseXliffViewModel

-(instancetype)init
{
    self=[super init];
    if (self) {
    }
    return self;
}

-(void)parseXliffWithPath:(NSString*)path
{
    parser=[[CWXliffParser alloc] init];
    __weak typeof(self) weakSelf=self;
    parser.completeBlock=^()
    {
        __strong typeof(weakSelf)  strongSelf=weakSelf;
        NSAttributedString* resultStr=[[NSAttributedString alloc] initWithString:[[parser parserResult] Unicode2UTF8]];
        strongSelf.completeBlcock(resultStr);
    };
    [parser  parseWithPath:path];
}
@end
