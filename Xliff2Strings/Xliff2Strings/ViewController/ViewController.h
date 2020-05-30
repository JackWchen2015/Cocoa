//
//  ViewController.h
//  Xliff2Strings
//
//  Created by ChenWu on 2017/10/10.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWFileDragView.h"

@interface ViewController : NSViewController

@property (weak) IBOutlet NSTextField *DragFileTipTxt;

@property (weak) IBOutlet CWFileDragView *FileDragView;

@end

