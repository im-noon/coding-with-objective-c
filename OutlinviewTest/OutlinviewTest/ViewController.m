//
//  ViewController.m
//  OutlinviewTest
//
//  Created by Slimn Srarena on 1/12/17.
//  Copyright © 2017 VedaTech Ltd. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewItem.h"

@interface ViewController ()

@property (strong) NSMutableArray *dataArray;
@property (strong) NSMutableArray *collectionArray;

@property (strong) IBOutlet NSOutlineView *outlineView;
@property (strong) IBOutlet NSCollectionView *collectionView;


@property (assign) BOOL startDraggingMask;

@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.outlineView.delegate = self;
    self.outlineView.dataSource = self;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self setNextResponder:self.view];
    
    for (NSView *subview in self.view.subviews) {
        [subview setNextResponder:self];
    }
    
    self.startDraggingMask = NO;
    
    // Enable Drag and Drop
    NSArray *dragType = [NSArray arrayWithObject: @"public.text"];
    
    [self.outlineView       registerForDraggedTypes: dragType];
    [self.collectionView    registerForDraggedTypes: dragType];
    
    
    NSNib *storyboardItemNib    = [[NSNib alloc] initWithNibNamed:@"CollectionViewItem" bundle:nil];
    
    [self.collectionView registerNib:storyboardItemNib
                     forItemWithIdentifier:@"item"];
    
    self.dataArray = [[NSMutableArray alloc] init];
    self.collectionArray = [[NSMutableArray alloc] init];
    
    [self addData];
    [self.outlineView reloadData];
    
    //[self addCollection];
    [self.collectionView reloadData];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (void) addData{
    
    // Do any additional setup after loading the view.
    NSDictionary *tree1 = [NSDictionary dictionaryWithObjectsAndKeys:@"oak",@"type", @"Quercus alba",@"species",nil];
    NSDictionary *tree2 = [NSDictionary dictionaryWithObjectsAndKeys:@"elm",@"type", @"Ulmus glabra",@"species",nil];
    
    NSDictionary *flower1 = [NSDictionary dictionaryWithObjectsAndKeys:@"rose",@"type", @"Rosa rugosa",@"species",nil];
    NSDictionary *flower2 = [NSDictionary dictionaryWithObjectsAndKeys:@"tulip",@"type", @"Tulipa albanica",@"species",nil];
    NSDictionary *flower3 = [NSDictionary dictionaryWithObjectsAndKeys:@"primula",@"type", @"rimula hortensis",@"species",nil];
    
    NSArray *tree = [NSArray arrayWithObjects:tree1, tree2, nil];
    NSArray *flower = [NSArray arrayWithObjects:flower1, flower2, flower3, nil];
    
    NSDictionary *plant1 = [NSDictionary dictionaryWithObjectsAndKeys:@"tree",@"name", tree,@"plant",nil];
    NSDictionary *plant2 = [NSDictionary dictionaryWithObjectsAndKeys:@"flower",@"name", flower,@"plant",nil];
    
    
    [self.dataArray addObject:plant1];
    [self.dataArray addObject:plant2];
}

- (void) addCollection{
    
    NSImage *image = [NSImage imageNamed:@"flower.png"];
        
    for (int i = 0; i < 4; i++) {
        NSString *title = [NSString stringWithFormat:@"Flower %d", i];
        NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:image, @"image", title, @"title", nil];
        [self.collectionArray addObject: item];
        
    }
    
}


- (id)outlineView:(NSOutlineView *)outlineView
            child:(NSInteger)index
           ofItem:(id)item {

    if (item) { //item is nil when the outline view wants to inquire for root level
        if ([item isKindOfClass:[NSDictionary class]]) {

            return [[item objectForKey:@"plant"] objectAtIndex:index];
            
        }
    }
    else {
        return [self.dataArray objectAtIndex:index];
    }
    
    return nil;

}

- (BOOL)outlineView:(NSOutlineView *)outlineView
   isItemExpandable:(id)item {
    
    BOOL maskKey = NO;
    if ([item isKindOfClass:[NSDictionary class]]) {
        NSArray *key = [item allKeys];
        if (key) {

            for (id obj in key) {
                if ([(NSString *)obj isEqual:@"name"] || [(NSString *)obj isEqual:@"plant"]) {
                    maskKey = YES;
                }
                else {
                    maskKey = NO;
                }
            }
            if (maskKey) {
                return YES;
            }
        }
        return NO;
    }else {
        return NO;
    }
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView
  numberOfChildrenOfItem:(id)item {

    if (item) {
        if ([item isKindOfClass:[NSDictionary class]]) {
            return [[item objectForKey:@"plant"] count];
        }
    }else {
        return [self.dataArray count];
    }
    
    return 0;
}

- (NSRect)frameOfOutlineCellAtRow:(NSInteger)row {
    return NSZeroRect;
}

/*
- (NSRect)frameOfCellAtColumn:(NSInteger)column row:(NSInteger)row {
    NSRect superFrame = [super frameOfCellAtColumn:column row:row];
    
    
    if ((column == 0) { // && isGroupRow ) {
        return NSMakeRect(0, superFrame.origin.y, [self bounds].size.width, superFrame.size.height);
    }
    return superFrame;
}

*/

#define kOutlineCellWidth 11
#define kOutlineMinLeftMargin 6

- (NSRect)frameOfCellAtColumn:(NSInteger)column row:(NSInteger)row {
    NSRect superFrame = [self frameOfCellAtColumn:column row:row];
    if (column == 0) {
        // expand by kOutlineCellWidth to the left to cancel the indent
        CGFloat adjustment = kOutlineCellWidth;
        
        // ...but be extra defensive because we have no fucking clue what is going on here
        if (superFrame.origin.x - adjustment < kOutlineMinLeftMargin) {
            NSLog(@"%@ adjustment amount is incorrect: adjustment = %f, superFrame = %@, kOutlineMinLeftMargin = %f", NSStringFromClass([self class]), (float)adjustment, NSStringFromRect(superFrame), (float)kOutlineMinLeftMargin);
            adjustment = MAX(0, superFrame.origin.x - kOutlineMinLeftMargin);
        }
        
        return NSMakeRect(superFrame.origin.x - adjustment, superFrame.origin.y, superFrame.size.width + adjustment, superFrame.size.height);
    }
    return superFrame;
}


- (NSView *)outlineView:(NSOutlineView *)outlineView
     viewForTableColumn:(NSTableColumn *)tableColumn
                   item:(id)item {
    
    
    NSTableCellView *cellView = [outlineView makeViewWithIdentifier:tableColumn.identifier owner:self];

    if ([tableColumn.identifier isEqualToString:@"name"]) {
        NSString *name = item[@"name"];
        if (name) {
            cellView.textField.stringValue = name;
        } else {
            cellView.textField.stringValue = @"";
        }
        
    } else if ([tableColumn.identifier isEqualToString:@"type"]) {
        NSString *type = item[@"type"];
        //NSLog(@"%@", type);
        if (type) {
            cellView.textField.stringValue = type;
        } else {
            cellView.textField.stringValue = @"";
        }
        
        
    }
    else if ([tableColumn.identifier isEqualToString:@"species"]) {
        NSString *species = item[@"species"];
        if (species) {
            cellView.textField.stringValue = species;
        } else {
            cellView.textField.stringValue = @"";
        }
        
    }

    return cellView;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView
shouldEditTableColumn:(NSTableColumn *)tableColumn
               item:(id)item {
    if ([tableColumn.identifier isEqualToString:@"species"]) {
        return YES;
    } else {
        return NO;
    }
    
}


#pragma mark - Drag & Drop
- (id <NSPasteboardWriting>)outlineView:(NSOutlineView *)outlineView
                pasteboardWriterForItem:(id)item{
    // No dragging if <some condition isn't met>
    BOOL dragAllowed = YES;
    if (!dragAllowed)  {
        return nil;
    }
    
    NSLog(@"@outlineView pasteboardWriterForItem : %@", item);
    
    NSMutableArray *dragItem = [[NSMutableArray alloc] init];
    
    
    NSString *identifier = @"Hello Drag and Drop";
    [dragItem addObject:identifier];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dragItem];
    
    NSPasteboardItem *pBoard = [[NSPasteboardItem alloc] init];
    
    [pBoard setData:data forType:@"public.text"];
    //[pboardItem setString:identifier forType: @"public.text"];
    NSLog(@"past boar : %@", pBoard);
    
    //reset dragging mask
    self.startDraggingMask = NO;
    
    return pBoard;
}


- (NSDragOperation)outlineView:(NSOutlineView *)outlineView
                  validateDrop:(id < NSDraggingInfo >)info
                  proposedItem:(id)targetItem
            proposedChildIndex:(NSInteger)index{
    
    BOOL canDrag = index >= 0 && targetItem;
    
    if (canDrag) {
        return NSDragOperationMove;
    }else {
        return NSDragOperationNone;
    }
}

/*
- (BOOL)outlineView:(NSOutlineView *)outlineView acceptDrop:(id < NSDraggingInfo >)info item:(id)targetItem childIndex:(NSInteger)index{
    
    NSPasteboard *p = [info draggingPasteboard];
    NSString *title = [p stringForType:@"public.text"];
    NSTreeNode *sourceNode;
    
    for(NSTreeNode *b in [targetItem childNodes]){
        if ([[[b representedObject] title] isEqualToString:title]){
            sourceNode = b;
        }
    }
    
    if(!sourceNode){
        // Not found
        return NO;
    }
    
    NSUInteger indexArr[] = {0,index};
    NSIndexPath *toIndexPATH =[NSIndexPath indexPathWithIndexes:indexArr length:2];
    
    //[self.booksController moveNode:sourceNode toIndexPath:toIndexPATH];
    
    
    
    return YES;
}*/


#pragma -mark NSCollectionViewDataSource



-(BOOL)collectionView:(NSCollectionView *)collectionView canDragItemsAtIndexes:(NSIndexSet *)indexes withEvent:(NSEvent *)event {
    
    NSLog(@"drag event : %@", event);
    return YES;
    
}


-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collectionArray count];
}
- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)inIndexPath {
    
    NSCollectionViewItem *theItem = [collectionView makeItemWithIdentifier:@"item" forIndexPath:inIndexPath];
    
    @try {
        NSDictionary *itemDesc = [self.collectionArray objectAtIndex:inIndexPath.item];
        
        NSImage  *image          = nil;
        NSString *textTitle      = @"";
        
        if ([[itemDesc allKeys] count]) {
            
            image           = [itemDesc objectForKey:@"image"];
            textTitle       = [itemDesc objectForKey:@"title"];
        }
        
        
        theItem.imageView.image = image;
        theItem.textField.stringValue = textTitle;
        
    } @catch (NSException *exception) {
        NSLog(@"exception : %@", exception);
    }
    
    return theItem;
}


#pragma -mark NSCollectionViewDelegate
-(void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths {
    
    for (NSIndexPath *path in indexPaths) {
        
        if (path.section >= 0) {
            
            NSString *latestedIndex = [NSString stringWithFormat:@"%lu", [path item]];
            
            NSLog(@">> select +++ %@", latestedIndex);

        }
    }
    
}

-(void)collectionView:(NSCollectionView *)collectionView
didDeselectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths {
    
}

-(void)collectionView:(NSCollectionView *)collectionView
didChangeItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths
     toHighlightState:(NSCollectionViewItemHighlightState)highlightState {

}


#pragma -mark collection item size
- (NSSize)collectionView:(NSCollectionView *)collectionView
                  layout:(NSCollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    float itemWidth  = 100;
    float itemHeight = 100;
    
    NSSize itemSize = NSMakeSize(itemWidth, itemHeight);
    
    return itemSize;
}


#
- (void)collectionView:(NSCollectionView *)collectionView
       draggingSession:(NSDraggingSession *)session
      willBeginAtPoint:(NSPoint)screenPoint
  forItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths {

    NSLog(@"#                  willBeginAtPoint");

    indexPathsOfItemsBeingDragged = [indexPaths copy];
    
}

- (void)collectionView:(NSCollectionView *)collectionView
       draggingSession:(NSDraggingSession *)session
          endedAtPoint:(NSPoint)screenPoint
         dragOperation:(NSDragOperation)operation {
    
    NSLog(@"#                  endedAtPoint");

    indexPathsOfItemsBeingDragged = nil;

}

- (BOOL)collectionView:(NSCollectionView *)collectionView
            acceptDrop:(id<NSDraggingInfo>)draggingInfo
             indexPath:(NSIndexPath *)indexPath
         dropOperation:(NSCollectionViewDropOperation)dropOperation {
    
    BOOL result = NO;
    // Is our own imageCollectionView the dragging source?
    if (indexPathsOfItemsBeingDragged) {
        
        //existing items are being dragged within our imageCollectionView.
        [self performMoveItemFromIndex:indexPath];
        
        
    }
    
    return YES;
    
}
/*
- (BOOL)collectionView:(NSCollectionView *)collectionView
            acceptDrop:(id<NSDraggingInfo>)draggingInfo
                 index:(NSInteger)index
         dropOperation:(NSCollectionViewDropOperation)dropOperation {
    
    
    
    NSPasteboard *pBoard = [draggingInfo draggingPasteboard];
    NSData *indexData = [pBoard dataForType:@"public.text"];
    
    NSIndexSet *indexes = [NSKeyedUnarchiver unarchiveObjectWithData:indexData];
    NSInteger draggedCell = [indexes firstIndex];
    
    NSLog(@" +++364 : %@", indexes);
    
    // Now we know the Original Index (draggedCell) and the
    // index of destination (index). Simply swap them in the collection view array.
    return YES;
}
*/

- (NSDragOperation)collectionView:(NSCollectionView *)collectionView
                     validateDrop:(id<NSDraggingInfo>)draggingInfo
                proposedIndexPath:(NSIndexPath **)proposedDropIndexPath
                    dropOperation:(NSCollectionViewDropOperation *)proposedDropOperation {
    
    NSPasteboard *pBoard = [draggingInfo draggingPasteboard];
    
    NSArray *dropItem = nil;
    
    //NSString *pbString = [pBoard  stringForType:@"public.text"];
    NSArray *itemArr = [pBoard pasteboardItems];

    if( itemArr ){
        for (int i = 0; i < [itemArr count]; i++) {
            NSPasteboardItem *item = [itemArr objectAtIndex:i];
            if (itemArr) {
                NSArray *itemType = [item types];
                if( itemType ){
                    for (int j = 0; j < [itemType count]; j++) {
                        NSString *pbType = [itemType objectAtIndex:j];
                        if ([pbType  isEqual: @"public.text"]) {
                            NSData *dropData = [item dataForType:pbType];
                            if (dropData) {
                                dropItem = [NSKeyedUnarchiver unarchiveObjectWithData:dropData];
                            }
                        }
                    }
                }
            }
        }
    }

    if( dropItem ){
        
        if (!self.startDraggingMask) {
            
            NSLog(@" +++377 : %@", dropItem);
            for (int i = 0; i < [dropItem count]; i++) {
                [self updateCollectionView];
            }
            
            NSIndexPath *indexpath = *proposedDropIndexPath;
            NSInteger itemSection = [indexpath section];
            NSInteger item = [indexpath item];

            NSLog(@"itemSection : %lu", itemSection);
            NSLog(@"item        : %lu", item);
            
            self.startDraggingMask = YES;
        }
        else {
            return NSDragOperationCopy;
        }
    }
    
    
    return NSDragOperationNone;//NSDragOperationCopy;
}


- (void)performMoveItemFromIndex:(NSIndexPath *)indexPath {
    NSLog(@"#                  performMoveItemFromIndex");

    
    __block NSInteger toItemIndex = indexPath.item;
    
    [indexPathsOfItemsBeingDragged enumerateIndexPathsWithOptions:0 usingBlock:^(NSIndexPath *fromIndexPath, BOOL *stop) {
        
        NSInteger fromItemIndex = fromIndexPath.item;
        
        if (fromItemIndex > toItemIndex) {
            
            /*
             For each step: First, modify our model.
             */
            
            id fromCollectionArray    = [[self.collectionArray objectAtIndex:fromItemIndex] copy];

            [self.collectionArray removeObjectAtIndex:fromItemIndex];
            [self.collectionArray insertObject:fromCollectionArray atIndex:toItemIndex];

            ++toItemIndex;
        }
        
        
        
    }];
    
    __block NSInteger adjustedToItemIndex = indexPath.item - 1;
    [indexPathsOfItemsBeingDragged enumerateIndexPathsWithOptions:NSEnumerationReverse  usingBlock:^(NSIndexPath *fromIndexPath, BOOL *stop) {
        NSInteger fromItemIndex = [fromIndexPath item];
        if (fromItemIndex < adjustedToItemIndex) {
            
            
            id fromCollectionArray    = [[self.collectionArray objectAtIndex:fromItemIndex] copy];
            
            [self.collectionArray removeObjectAtIndex:fromItemIndex];
            [self.collectionArray insertObject:fromCollectionArray atIndex:toItemIndex];
            --adjustedToItemIndex;
        }
    }];

}



- (void)updateCollectionView{
    
    int itemIndex = (int)[self.collectionArray count];
    
    NSImage *image = [NSImage imageNamed:@"flower.png"];
    NSString *title = [NSString stringWithFormat:@"Flower %d", itemIndex];
    
    NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:image, @"image", title, @"title", nil];
    [self.collectionArray addObject: item];
    
    [self. collectionView reloadData];
    
}

//- (void)mouseDown:(NSEvent *)theEvent {
   // NSLog(@"mouse click event : %@", theEvent);
    /*
     if ([self.previewPlayer status] == AVPlayerStatusReadyToPlay) {
     if (self.sliderPlayerSeekTime.isHidden) {
     [self.sliderPlayerSeekTime  setHidden:NO];
     } else {
     [self.sliderPlayerSeekTime  setHidden:YES];
     }
     }
     */
    
    //NSPoint mouseDownPos = [theEvent locationInWindow];
    
//}

- (void)mouseMoved:(NSEvent *)theEvent {
    NSPoint eyeCenter = [self.view convertPoint:[theEvent locationInWindow] fromView:nil];
    NSRect  eyeBox = NSMakeRect((eyeCenter.x-10.0), (eyeCenter.y-10.0), 20.0, 20.0);
    [self.view setNeedsDisplayInRect:eyeBox];
    [self.view displayIfNeeded];
    NSLog(@"+++mouseUp");
}

- (void)mouseUp:(NSEvent *)event {
    NSLog(@"+++mouseUp");
}

@end
