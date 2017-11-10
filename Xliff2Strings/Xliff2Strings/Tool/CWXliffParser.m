//
//  CWXliffParser.m
//  Xliff2Strings
//
//  Created by ChenWu on 2017/10/10.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import "CWXliffParser.h"


@interface CWXliffParser()<NSXMLParserDelegate>
{
    NSXMLParser* parser;
   
    //标记当前标签，以索引找到XML文件内容
    BOOL  startParse;
}
@property (nonatomic, copy) NSString *currentElement;
@property (nonatomic, strong) StringElement *stringNode;
@end
@implementation CWXliffParser

-(void)parseWithPath:(NSString*)path
{
//    NSString* xliffPath=[[NSBundle mainBundle] pathForResource:@"en" ofType:@"xliff"];
    
    // NSXMLParser   即SAX方式解析XML，它基于事件通知的模式，一边读取文档一边解析数据，不用等待文档全部读入以后再解析
    //  NSXMLParser*
    NSData* data=[NSData dataWithContentsOfFile:path];
    parser=[[NSXMLParser alloc] initWithData:data];
    parser.delegate=self;
    
    _stringKeyAry=[NSMutableArray array];
    [parser parse];
    startParse=false;
}

//几个代理方法的实现，是按逻辑上的顺序排列的，但实际调用过程中中间三个可能因为循环等问题乱掉顺序
//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidStartDocument...");
}
//准备节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    
    self.currentElement = elementName;
    
    if ([self.currentElement isEqualToString:@"file"]){
        NSString* original=attributeDict[@"original"];
        if ([original hasSuffix:@".strings"]) {
            startParse=YES;
        }
    }
    
    if(startParse)
    {
        if ([self.currentElement isEqualToString:@"trans-unit"]) {
            
            self.stringNode=[StringElement new];
        }
    }
}
//获取节点内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (startParse) {
        if ([self.currentElement isEqualToString:@"source"]){
            self.stringNode.source=string;
        }else if ([self.currentElement isEqualToString:@"note"]){
            self.stringNode.note=string;
        }
    }
}

//解析完一个节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    if (startParse) {
        if ([elementName isEqualToString:@"trans-unit"]) {
            [_stringKeyAry addObject:self.stringNode];
        }
        self.currentElement = nil;
    }
}

//解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
    if(_completeBlock)
    {
        _completeBlock();
    }
}
-(NSString*)parserResult
{
    NSString* rtnStr=@"";
    for (int i=0; i<_stringKeyAry.count; ++i) {
        StringElement* tmpElem=_stringKeyAry[i];
        NSString*  elemStr=[NSString stringWithFormat:@"\"%@\"=\"%@\";\n",tmpElem.source,tmpElem.note];
        rtnStr=[rtnStr stringByAppendingString:elemStr];
    }
    return rtnStr;
}
@end
