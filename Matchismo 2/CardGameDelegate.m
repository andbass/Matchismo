//
//  CardGameDelegate.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/9/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "CardGameDelegate.h"
#import "CardViewer.h"

@interface CardGameDelegate()

@property id<UpdateProtocol> updater;
@property NSInteger itemsAnimating;

@end

@implementation CardGameDelegate

- (instancetype)initWithGame:(Game *)game updater:(id<UpdateProtocol>)updater {
    self = [super init];
    
    if (self) {
        self.game = game;
        self.updater = updater;
    }
    
    return self;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [indexPath item];
    
    [self.game selectCard:index];
   
    CardViewer* viewer = (CardViewer*)[collectionView cellForItemAtIndexPath:indexPath];
    
    self.itemsAnimating += 1;
    
    [UIView transitionWithView:viewer duration:0.75 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        [viewer setNeedsDisplay];
    } completion:^(BOOL fin) {
        [self cardViewerDoneAnimating:collectionView];
        
        [self.updater updateScore];
    }];
    
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
    } completion:^(BOOL fin){
        [collectionView reloadData];
    }];
}

- (void)cardViewerDoneAnimating:(UICollectionView*)collectionView {
    self.itemsAnimating -= 1;
    
    if (self.itemsAnimating <= 0) {
        [self clearMatchedCards:collectionView];
    }
}

@end
