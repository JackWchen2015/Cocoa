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
    
}
@property(nonatomic,strong)MainWindowController* rootWinCtl;
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
    if (!flag) {
        [self.rootWinCtl.window makeKeyAndOrderFront:self];
    }
    return YES;
}


- (IBAction)openMainWindow:(id)sender {
   [self.rootWinCtl.window makeKeyAndOrderFront:self];
}

-(MainWindowController *)rootWinCtl
{
    if (!_rootWinCtl) {
        NSStoryboard* story=[NSStoryboard storyboardWithName:@"Main" bundle:nil];
        _rootWinCtl= [story instantiateInitialController];
    }
    return _rootWinCtl;
}
@end
