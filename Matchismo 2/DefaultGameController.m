//
//  DefaultGameController.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/12/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "DefaultGameController.h"

#define NUMBER_OF_CARDS 8

@implementation DefaultGameController

- (Game*)generateGame {
    return [[Game alloc] initWithCard:[DefaultCard class] cardsOnTable:NUMBER_OF_CARDS];
}

- (IBAction)redealCards:(UIButton *)sender {
    NSInteger previousNumberOfCards = [self.game.cardsOnTable count];
    [self.game clearAllCards];
    
    [self.collectionView performBatchUpdates:^{
        NSMutableArray* pathsToDelete = [NSMutableArray new];
        
        for (int i = 0; i < previousNumberOfCards; i++) {
            NSIndexPath* path = [NSIndexPath indexPathForItem:i inSection:0];
            [pathsToDelete addObject:path];
        }
        
        [self.collectionView deleteItemsAtIndexPaths:pathsToDelete];
    } completion:^(BOOL fin) {
        if (fin) {
            [self appendCards:NUMBER_OF_CARDS scorePenalty:false];
        }
    }];
    
    self.game.score = 0;
    [self updateScore];
}

@end
