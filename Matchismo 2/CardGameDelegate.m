//
//  CardGameDelegate.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/9/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "CardGameDelegate.h"
#import "CardViewer.h"

@implementation CardGameDelegate

- (instancetype)initWithGame:(Game *)game {
    self = [super init];
    
    if (self) {
        self.game = game;
        self.viewsToBeAnimated = [NSMutableArray new];
    }
    
    return self;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [indexPath item];
    
    [self.game selectCard:index];
   
    CardViewer* viewer = (CardViewer*)[collectionView cellForItemAtIndexPath:indexPath];
    [viewer setNeedsDisplay];
    
    [self clearMatchedCards:collectionView];
}

- (void)clearMatchedCards:(UICollectionView*) collectionView {
    NSMutableArray* pathsToDelete = [NSMutableArray new];
    
    for (Card* matchedCard in self.game.recentlyMatchedCards) {
        NSInteger index = [self.game.cardsOnTable indexOfObject:matchedCard];
        NSIndexPath* path = [NSIndexPath indexPathForItem:index inSection:0];
        
        [pathsToDelete addObject:path];
    }
    
    [self.game clearMatchedCards];
    
    [collectionView performBatchUpdates:^{
        [collectionView deleteItemsAtIndexPaths:pathsToDelete];
    } completion:nil];
}

@end
