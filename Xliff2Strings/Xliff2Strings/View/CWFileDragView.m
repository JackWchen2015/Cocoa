//
//  CWFileDragView.m
//  Xliff2Strings
//
//  Created by ChenWu on 2017/10/10.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import "CWFileDragView.h"
#import "ResultWindowController.h"
#import "CWParseXliffViewModel.h"
#import <ReactiveObjC.h>




@interface CWFileDragView()
{
   CWParseXliffViewModel*  parseXliffVM;
}

@end




@implementation CWFileDragView
{
    ResultWindowController *rwc;
}


- (void)awakeFromNib {
    parseXliffVM=[CWParseXliffViewModel new];
    
    @weakify(self);
    parseXliffVM.completeBlcock = ^(NSAttributedString * _Nonnull resutlt) {
        @strongify(self);
        [self showResultWithStr:resutlt];
    };
    [self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
}

//- (void)drawRect:(NSRect)dirtyRect {
//    [super drawRect:dirtyRect];
//
//    // Drawing code here.
//
//    switch (self.isDragIn) {
//        case DragInStatueNo:{
//            [[NSColor whiteColor] setFill];
//            NSRectFill(dirtyRect);
//        }
//            break;
//        case DragInStatueIn:{
//            NSColor* color = [NSColor colorWithRed:220.0 / 255 green:220.0 / 255 blue:220.0 / 255 alpha:1.0];
//            [color set];
//            NSBezierPath* thePath = [NSBezierPath bezierPath];
//            [thePath appendBezierPathWithRoundedRect:dirtyRect xRadius:8.0 yRadius:8.0];
//            [thePath fill];
//        }
//            break;
//        case DragInStatueEro:
//        {
//            NSColor* color = [NSColor redColor];
//            [color set];
//            NSBezierPath* thePath = [NSBezierPath bezierPath];
//            [thePath appendBezierPathWithRoundedRect:dirtyRect xRadius:8.0 yRadius:8.0];
//            [thePath fill];
//        }
//        default:
//            break;
//    }
//}
#pragma mark - Destination Operations

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
     NSArray* filePaths = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
    [filePaths enumerateObjectsUsingBlock:^(NSString*  _Nonnull path, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[path pathExtension]isEqualToString:@"xliff"]) {
            self.isDragIn=DragInStatueIn;
            *stop=YES;
             [parseXliffVM parseXliffWithPath:path];
        }
        else
        {
             self.isDragIn=DragInStatueEro;
        }
    }];
    
//    [self setNeedsDisplay:YES];
    return NSDragOperationCopy;
}

- (void)draggingExited:(id<NSDraggingInfo>)sender
{
    self.isDragIn = DragInStatueNo;
//    [self setNeedsDisplay:YES];
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender
{
    self.isDragIn = DragInStatueNo;
//    [self setNeedsDisplay:YES];
    return YES;
}






-(void)showResultWithStr:(NSAttributedString*)resultStr
{
    rwc = [[ResultWindowController alloc]initWithWindowNibName:@"ResultWindowController"];
    [rwc.window makeKeyAndOrderFront:nil];
    NSTextView* myTextView =rwc.resultText;
     [myTextView.textStorage appendAttributedString:resultStr];
    
    
}

@end
