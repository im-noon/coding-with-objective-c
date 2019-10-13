//
//  AppDelegate.m
//  AVPlayerDemo
//
//  Created by Slimn Srarena on 1/18/17.
//  Copyright © 2017 VedaTech Ltd. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    VTRegisterProfessionalVideoWorkflowVideoDecoders();
    MTRegisterProfessionalVideoWorkflowFormatReaders();
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
