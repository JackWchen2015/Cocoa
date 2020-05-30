//
//  ViewController.m
//  Xliff2Strings
//
//  Created by ChenWu on 2017/10/10.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
@interface ViewController()
{
  
}

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [RACObserve(self.FileDragView, isDragIn) subscribeNext:^(NSNumber*  _Nullable x) {
        switch (x.integerValue) {
            case DragInStatueEro:
                {
                    self.DragFileTipTxt.textColor=[NSColor redColor];
                }
                break;
            case DragInStatueNo:
            {
                self.DragFileTipTxt.textColor=[NSColor blackColor];
            }
                break;
            case DragInStatueIn:
            {
                self.DragFileTipTxt.textColor=[NSColor blueColor];
            }
                break;
            default:
                break;
        }
    }];
    
    // Do any additional setup after loading the view.
  
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



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}




@end
