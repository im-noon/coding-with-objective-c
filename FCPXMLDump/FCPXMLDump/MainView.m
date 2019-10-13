//
//  MainView.m
//  FCPXMLDump
//
//  Created by Slimn Srarena on 2/1/17.
//  Copyright © 2017 Veda. All rights reserved.
//

#import "MainView.h"
#import "NXFcpxmlUtility.h"

@interface MainView () {
    NXFcpxmlUtility *fcpcml;
}

@property (copy) NSString *strFile;

@end

@implementation MainView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Do any additional setup after loading the view.
        fcpcml = [[NXFcpxmlUtility alloc] init];
        _strFile = @"/Users/Slimn/Desktop/Work/Coremelt/sandbox/Test Suite Scribeomatic  01/01 Embedded Audio.fcpxml";
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [fcpcml getFcpxml:_strFile];
}

@end
