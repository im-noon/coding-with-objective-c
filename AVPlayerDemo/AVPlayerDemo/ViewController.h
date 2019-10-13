//
//  ViewController.h
//  AVPlayerDemo
//
//  Created by Slimn Srarena on 1/18/17.
//  Copyright © 2017 VedaTech Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVKit/AVKit.h>

@interface ViewController : NSViewController

@property (strong) IBOutlet AVPlayerView *playerVIew;

- (IBAction)actionExportMovie:(id)sender;

@end

