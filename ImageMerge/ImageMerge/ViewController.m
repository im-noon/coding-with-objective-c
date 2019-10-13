//
//  ViewController.m
//  ImageMerge
//
//  Created by Slimn Srarena on 5/19/17.
//  Copyright © 2017 Slimn Srarena. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize  testImage;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    NSImage *image1 = [NSImage imageNamed:@"img1.png"];
    NSImage *image2 = [NSImage imageNamed:@"img2.png"];
    
    NSImage *mergeImage = [self mergeImages:image1 :image2];
    [self.testImage setImage:mergeImage];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (NSImage *) mergeImages:(NSImage *)leftImage
                         :(NSImage *)rightImage {
    
    
    NSSize newSize = NSMakeSize(leftImage.size.width + rightImage.size.width, leftImage.size.height);
    
    NSSize overlaySize = NSMakeSize(newSize.width/2, newSize.height);
    //change the size according to your requirements
    
    NSImage *newImage = [[NSImage alloc] initWithSize:newSize];
    
    [newImage lockFocus];
    
    [leftImage drawInRect:NSMakeRect(0, 0, leftImage.size.width, leftImage.size.height)];
    [rightImage drawInRect:NSMakeRect(newSize.width-overlaySize.width, 0, overlaySize.width, overlaySize.height)];
    //set the position as required
    
    [newImage unlockFocus];
    
    return newImage;
}

@end
