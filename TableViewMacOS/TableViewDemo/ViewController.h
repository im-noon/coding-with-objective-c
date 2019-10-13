//
//  ViewController.h
//  TableViewDemo
//
//  Created by Slimn Srarena on 5/17/17.
//  Copyright © 2017 Slimn Srarena. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (strong) IBOutlet NSTableView *tableTest;

@end

