//
//  ViewController.h
//  miniTool
//
//  Created by Slimn Srarena on 6/12/18.
//  Copyright © 2018 vaav. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSTextFieldDelegate>

@property (strong) IBOutlet NSTextField *textFieldX;
@property (strong) IBOutlet NSTextField *textFieldY;
@property (strong) IBOutlet NSTextField *textFieldZ;

@end

