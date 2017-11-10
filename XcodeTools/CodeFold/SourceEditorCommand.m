//
//  SourceEditorCommand.m
//  CodeFold
//
//  Created by ChenWu on 2017/11/6.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import "SourceEditorCommand.h"

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    
//    NSLog(@"%@",invocation.buffer.lines);
//    NSLog(@"%@",invocation.buffer.selections);
    
    //获取光标所在行  查找光标最近的 {} 把里面的 \n 去掉
    XCSourceTextRange *  lineSelectRange=[invocation.buffer.selections firstObject];
    NSInteger lineSelect=lineSelectRange.start.line;//0 开始
    
    NSInteger deleteStart=0;
        NSInteger deletEnd=0;
    
    for (NSInteger i=lineSelect; i>0; i--) {
        NSString*  lineStr=invocation.buffer.lines[i];
        if ([lineStr containsString:@"{"]) {
            deleteStart=i;
            break;
        }
        else
        {
//            lineStr=[lineStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//             [invocation.buffer.lines replaceObjectAtIndex:i withObject:lineStr];
        }
    }
    for (NSInteger i=lineSelect; i<=invocation.buffer.lines.count; i++) {
        NSString*  lineStr=invocation.buffer.lines[i];
        if ([lineStr containsString:@"}"]) {
            deletEnd=i;
            break;
        }
        else
        {
//            lineStr=[lineStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//            [invocation.buffer.lines replaceObjectAtIndex:i withObject:lineStr];
        }
    }
//    NSLog(@"%@",invocation.buffer.lines);
    [invocation.buffer.lines removeObjectsInRange:NSMakeRange(deleteStart, deletEnd-deleteStart+1)];
    completionHandler(nil);
}

@end
