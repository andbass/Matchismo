//
//  CardGameController.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/9/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "CardGameController.h"
#import "CardGameDatasource.h"
#import "CardGameDelegate.h"

#import "Game.h"
#import "DefaultCard.h"

@interface CardGameController()

@property Game* game;

@property CardGameDatasource* dataSource;
@property CardGameDelegate* delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

#define NUMBER_OF_CARDS 12

@implementation CardGameController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.game = [[Game alloc] initWithCard:DefaultCard.class cardsOnTable:NUMBER_OF_CARDS];
    
    self.delegate = [[CardGameDelegate alloc] initWithGame:self.game updater:self];
    self.dataSource = [[CardGameDatasource alloc] initWithGame:self.game];
    
    [self updateScore];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.collectionView.backgroundColor = nil;
    
    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self.delegate;
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

- (void)updateScore {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
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
