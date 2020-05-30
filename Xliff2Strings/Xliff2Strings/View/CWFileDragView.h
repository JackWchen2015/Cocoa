//
//  CWFileDragView.h
//  Xliff2Strings
//
//  Created by ChenWu on 2017/10/10.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import <Cocoa/Cocoa.h>



typedef NS_ENUM(NSInteger,DragInStatue)
{
    DragInStatueNo,
    DragInStatueIn,
    DragInStatueEro,
};


@interface CWFileDragView : NSView


@property(nonatomic,assign)DragInStatue isDragIn;
@end
