//
//  ViewController.m
//  TableViewDemo
//
//  Created by Slimn Srarena on 5/17/17.
//  Copyright © 2017 Slimn Srarena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    
}

@property NSMutableArray *marrItem;

@end

@implementation ViewController

@synthesize tableTest;


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.marrItem = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i++) {
        
        NSString *data = [NSString stringWithFormat:@"Awesome Item : %d", i+1];
        [self.marrItem addObject:data];
    }
    
    [self.tableTest reloadData];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.marrItem count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    
    NSTableCellView *result = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    
    
    
    if (!(row % 4)) {
        result.textField.textColor = [NSColor redColor];
        [result.textField setFont:[NSFont boldSystemFontOfSize:13]];
        
        result.textField.stringValue = [self.marrItem objectAtIndex:row];

    }
    else {
        result.textField.textColor = [NSColor blueColor];
        result.textField.stringValue = [self.marrItem objectAtIndex:row];

    }
    return result;
}

/*
- (BOOL)tableView:(NSTableView *)tableView
       isGroupRow:(NSInteger)row {
    
    if (!(row % 4)) {
        NSLog(@" make group");
        return YES;
    }
    return NO;
}
*/

@end
