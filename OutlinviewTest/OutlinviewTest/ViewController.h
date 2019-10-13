//
//  ViewController.h
//  OutlinviewTest
//
//  Created by Slimn Srarena on 1/12/17.
//  Copyright © 2017 VedaTech Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSOutlineViewDelegate, NSOutlineViewDataSource , NSCollectionViewDelegate, NSCollectionViewDataSource> {
    
    NSSet<NSIndexPath *> *indexPathsOfItemsBeingDragged;
}


@end

