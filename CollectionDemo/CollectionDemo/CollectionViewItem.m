//
//  CollectionViewItem.m
//  CollectionDemo
//
//  Created by Slimn Srarena on 1/30/17.
//  Copyright © 2017 Veda. All rights reserved.
//

#import "CollectionViewItem.h"

@interface CollectionViewItem ()

@end

@implementation CollectionViewItem


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    [self.view setWantsLayer:YES];

}

- (void)drawRect:(NSRect)dirtyRect
{
    if (self.selected) {
        [[NSColor blueColor] set];
    }

}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    if (representedObject == nil) {
    
    }
}


-(void)setSelected:(BOOL)selected
{
    
    if (selected) {
        [self.view.layer setBorderWidth:5.0];
        NSLog(@"setSelected");
    } else {
        [self.view.layer setBorderWidth:0.0];
    }
}

@end

