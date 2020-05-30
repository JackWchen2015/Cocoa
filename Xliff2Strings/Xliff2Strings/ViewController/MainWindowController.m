//
//  MainWindowController.m
//  Xliff2Strings
//
//  Created by ChenWu on 2017/11/13.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import "MainWindowController.h"

@interface MainWindowController ()

@end

@implementation MainWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [[self.window standardWindowButton:NSWindowZoomButton] setHidden:YES];
    self.window.styleMask=NSWindowStyleMaskTitled|NSWindowStyleMaskClosable|!NSWindowStyleMaskResizable|NSWindowStyleMaskMiniaturizable;
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
