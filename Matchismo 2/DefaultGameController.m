//
//  DefaultGameController.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/12/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "DefaultGameController.h"

#define NUMBER_OF_CARDS 12

@implementation DefaultGameController

- (Game*)generateGame {
    return [[Game alloc] initWithCard:DefaultCard.class cardsOnTable:NUMBER_OF_CARDS];
}

- (IBAction)redealCards:(UIButton *)sender {
    NSInteger previousNumberOfCards = [self.game.cardsOnTable count];
    [self.game.cardsOnTable removeAllObjects];
    
    [self.collectionView performBatchUpdates:^{
        NSMutableArray* pathsToDelete = [NSMutableArray new];
        
        for (int i = 0; i < previousNumberOfCards; i++) {
            NSIndexPath* path = [NSIndexPath indexPathForItem:i inSection:0];
            [pathsToDelete addObject:path];
        }
        
        [self.collectionView deleteItemsAtIndexPaths:pathsToDelete];
    } completion:nil];
    
    [self performSelector:@selector(addCards) withObject:nil afterDelay:0.75];
    
    self.game.score = 0;
    [self updateScore];
}

- (void)addCards {
    if ([self.game dealMoreCards:NUMBER_OF_CARDS]) {
        [self.collectionView performBatchUpdates:^{
            NSMutableArray* pathsToAdd = [NSMutableArray new];
            
            for (int i = 0; i < NUMBER_OF_CARDS; i++) {
                NSIndexPath* path = [NSIndexPath indexPathForItem:i inSection:0];
                
                [pathsToAdd addObject:path];
            }
            
            [self.collectionView insertItemsAtIndexPaths:pathsToAdd];
        } completion:nil];
    }
}

@end