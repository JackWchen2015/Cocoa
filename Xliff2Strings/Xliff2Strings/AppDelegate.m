//
//  AppDelegate.m
//  Xliff2Strings
//
//  Created by ChenWu on 2017/10/10.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import "AppDelegate.h"
#import "MainWindowController.h"
@interface AppDelegate ()
{
    MainWindowController* rootWinCtl;
}
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
    if (flag) {
        return NO;
    }
    else
    {
        NSStoryboard* story=[NSStoryboard storyboardWithName:@"Main" bundle:nil];
        rootWinCtl = [story instantiateInitialController];
        [rootWinCtl.window makeKeyAndOrderFront:self];
        return YES;
    }
}
- (IBAction)openMainWindow:(id)sender {
    if (rootWinCtl) {
         [rootWinCtl.window makeKeyAndOrderFront:self];
    }
    else
    {
        NSStoryboard* story=[NSStoryboard storyboardWithName:@"Main" bundle:nil];
        rootWinCtl = [story instantiateInitialController];
        [rootWinCtl.window makeKeyAndOrderFront:self];
    }
}
@end
