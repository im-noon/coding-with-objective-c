//
//  ViewController.m
//  miniTool
//
//  Created by Slimn Srarena on 6/12/18.
//  Copyright © 2018 vaav. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    double remainder;
    double division;
    NSCharacterSet *characterSet;
}

@end

@implementation ViewController

@synthesize textFieldX;
@synthesize textFieldY;
@synthesize textFieldZ;

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.textFieldX.delegate = self;
        self.textFieldY.delegate = self;
        self.textFieldZ.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    remainder = 0;
    division = 0;
    characterSet  = [NSCharacterSet characterSetWithCharactersInString:@"1234567890.,"];
    //characterSet = [characterSet invertedSet];
    
    self.textFieldX.stringValue = @"";
    self.textFieldY.stringValue = @"";
    self.textFieldZ.stringValue = @"";
    
}

- (BOOL)checkAlloedInput:(NSString *)checkString {
    BOOL allowed = YES;
    if (checkString.length == 1) {
        if (([checkString isEqual:@"."]) || ([checkString isEqual:@"."])) {
            allowed = NO;
        }
    }
    else {
        NSRange r = [checkString rangeOfCharacterFromSet:characterSet];
        if (r.location != NSNotFound) {
            allowed = NO;
        }
       
    }
    
     NSLog(@"allowed = %d", allowed);
    return allowed;
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)controlTextDidEndEditing:(NSNotification *)obj {
    NSTextField *textfield = [obj object];
    NSString *inputString = textfield.stringValue;
    NSLog(@"textfield = %@", inputString);
    if ([textfield isEqual:self.textFieldX]) {
        
        remainder = [inputString doubleValue];
    }
    else if ([textfield isEqual:self.textFieldY]) {
        division = [inputString doubleValue];
    }

    NSLog(@"remainder = %f", remainder);
    NSLog(@"division  = %f", division);
    if (division > 0) {
        double result = fmod(remainder, division);
        NSString *formatResult = [NSString stringWithFormat:@"%f", result];
        [self.textFieldZ setStringValue:formatResult];
    }
}

- (void)controlTextDidChange:(NSNotification *)obj {
    NSTextField *textfield = [obj object];
    if ([textfield isEqual:self.textFieldX]) {
        NSLog(@"textFieldX = %@", textFieldX.stringValue);
    }
    else if ([textfield isEqual:self.textFieldY]) {
        NSLog(@"textFieldY = %@", textFieldY.stringValue);
    }
    else if ([textfield isEqual:self.textFieldZ]) {
        NSLog(@"textFieldZ = %@", textFieldZ.stringValue);
    }
}

@end
