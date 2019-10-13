//
//  CollectionViewItem.m
//  OutlinviewTest
//
//  Created by Slimn Srarena on 4/24/17.
//  Copyright © 2017 VedaTech Ltd. All rights reserved.
//

#import "CollectionViewItem.h"

@interface CollectionViewItem ()

@end

@implementation CollectionViewItem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self.view setWantsLayer:YES];
    self.view.layer.borderWidth = 0.0;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor blackColor] set];
    if (self.selected) {
        [[NSColor blueColor] set];
    }
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
    if (representedObject == nil) {
        
    }
}



-(void)setSelected:(BOOL)selected {
    
    if (selected) {
        [self.view.layer setBorderWidth:1.0];
        NSLog(@"setSelected");
    } else {
        [self.view.layer setBorderWidth:0.0];
    }
}

@end
