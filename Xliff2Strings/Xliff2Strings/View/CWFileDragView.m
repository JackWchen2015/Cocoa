//
//  CWFileDragView.m
//  Xliff2Strings
//
//  Created by ChenWu on 2017/10/10.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import "CWFileDragView.h"
#import "ResultWindowController.h"
#import "CWXliffParser.h"
#import "NSString+Unicode2UTF8.h"


typedef NS_ENUM(NSInteger,DragInStatue)
{
    DragInStatueNo,
    DragInStatueIn,
    DragInStatueEro,
};
@implementation CWFileDragView
{
    DragInStatue isDragIn;
    NSString *outPutString ;
    ResultWindowController *rwc;
    CWXliffParser*  parser;
}

- (void)awakeFromNib {
    [self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
    outPutString = @"";
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.

    switch (isDragIn) {
        case DragInStatueNo:{
            [[NSColor whiteColor] setFill];
            NSRectFill(dirtyRect);
        }
            break;
        case DragInStatueIn:{
            NSColor* color = [NSColor colorWithRed:220.0 / 255 green:220.0 / 255 blue:220.0 / 255 alpha:1.0];
            [color set];
            NSBezierPath* thePath = [NSBezierPath bezierPath];
            [thePath appendBezierPathWithRoundedRect:dirtyRect xRadius:8.0 yRadius:8.0];
            [thePath fill];
        }
            break;
        case DragInStatueEro:
        {
            NSColor* color = [NSColor redColor];
            [color set];
            NSBezierPath* thePath = [NSBezierPath bezierPath];
            [thePath appendBezierPathWithRoundedRect:dirtyRect xRadius:8.0 yRadius:8.0];
            [thePath fill];
        }
        default:
            break;
    }
}
#pragma mark - Destination Operations

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
     NSArray* filePaths = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
    [filePaths enumerateObjectsUsingBlock:^(NSString*  _Nonnull path, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[path pathExtension]isEqualToString:@"xliff"]) {
            isDragIn=DragInStatueIn;
            *stop=YES;
             [self parseXliffWithPath:path];
        }
        else
        {
             isDragIn=DragInStatueEro;
        }
    }];
    
    [self setNeedsDisplay:YES];
    return NSDragOperationCopy;
}

- (void)draggingExited:(id<NSDraggingInfo>)sender
{
    isDragIn = DragInStatueNo;
    [self setNeedsDisplay:YES];
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender
{
    isDragIn = DragInStatueNo;
    [self setNeedsDisplay:YES];
    return YES;
}

//- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
//{
//    if ([sender draggingSource] != self)
//    {
//        NSArray* filePaths = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
//        NSLog(@"hahaha %@",filePaths);
//
//        //目标文件格式过滤  false 弹窗返回
//        for (NSString *path in filePaths) {
//            //            [self handleFile:path];
////            [self parserXcodeProject:path];
//            [self parseXliffWithPath:path];
//        }
//    }
//
//    return YES;
//}

-(void)parseXliffWithPath:(NSString*)path
{
     parser=[[CWXliffParser alloc] init];
    __weak typeof(self) weakSelf=self;
    parser.completeBlock=^()
    {
        [weakSelf showResult];
    };
    [parser  parseWithPath:path];
}

-(void)showResult
{
    rwc = [[ResultWindowController alloc]initWithWindowNibName:@"ResultWindowController"];
    [rwc.window makeKeyAndOrderFront:nil];
    outPutString=[parser parserResult];
    NSTextView* myTextView =rwc.resultText;
    NSAttributedString* attr = [[NSAttributedString alloc] initWithString:[outPutString Unicode2UTF8]];
    [myTextView.textStorage appendAttributedString:attr];
}
@end
