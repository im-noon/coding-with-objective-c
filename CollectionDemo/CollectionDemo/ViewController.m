//
//  ViewController.m
//  CollectionDemo
//
//  Created by Slimn Srarena on 1/30/17.
//  Copyright © 2017 Veda. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewItem.h"

@interface ViewController ()

@property (strong) NSMutableArray *arr;
@end

#define max_sample 5
@implementation ViewController

@synthesize collectionView;


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.

    NSImage *image = [NSImage imageNamed:@"test0.png"];
    self.arr = [[NSMutableArray alloc] init];

    for (int i = 0; i < 22; i++) {
        [self.arr addObject:image];
    }
    
    NSNib *theNib = [[NSNib alloc] initWithNibNamed:@"CollectionViewItem" bundle:nil];
    
    [self.collectionView registerNib:theNib forItemWithIdentifier:@"item"];

}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}


#pragma -mark NSCollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView {
    return  1;
}

-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.arr count];
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)inCollectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)inIndexPath {
    NSCollectionViewItem *theItem = [inCollectionView makeItemWithIdentifier:@"item" forIndexPath:inIndexPath];
    
    theItem.imageView.image = [self.arr objectAtIndex:inIndexPath.item];
    
    return theItem;
}


#pragma -mark NSCollectionViewDelegate

-(void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths {
    NSLog(@"selected : %@", indexPaths);
}

-(void)collectionView:(NSCollectionView *)collectionView didDeselectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths {
    
}

-(void)collectionView:(NSCollectionView *)collectionView didChangeItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths toHighlightState:(NSCollectionViewItemHighlightState)highlightState {
    
}

- (NSSize)collectionView:(NSCollectionView *)collectionView
                  layout:(NSCollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    float height = [self.collectionView bounds].size.height;
    
    float width = [self.collectionView bounds].size.width;
    
    int max_split = 5;
    
    float itemWidth = width/(max_split);
    
    float itemHeight = floorf((itemWidth*9)/16);
    
    NSLog(@"collection view size w/h = %f/%f  image w/h = %f/%f", width, height, itemWidth, itemHeight);

    NSSize itemSize = NSMakeSize(itemWidth, itemHeight);
    
    return itemSize;
}


@end
