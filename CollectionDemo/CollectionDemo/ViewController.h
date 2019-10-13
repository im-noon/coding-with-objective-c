//
//  ViewController.h
//  CollectionDemo
//
//  Created by Slimn Srarena on 1/30/17.
//  Copyright © 2017 Veda. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ViewController : NSViewController <NSCollectionViewDelegate, NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout, NSDraggingDestination>

@property (weak) IBOutlet NSCollectionView *collectionView;

@end

