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

@implementation CardGameController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.game = [[Game alloc] initWithCard:DefaultCard.class cardsOnTable:4];
    
    self.delegate = [[CardGameDelegate alloc] initWithGame:self.game];
    self.dataSource = [[CardGameDatasource alloc] initWithGame:self.game];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.collectionView.backgroundColor = nil;
    
    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self.delegate;
}

- (IBAction)redealCards:(UIButton *)sender {
    NSInteger previousNumberOfCards = [self.game.cardsOnTable count];
    BOOL couldAddCards = [self.game dealMoreCards:3];
    
    if (couldAddCards) {
        [self.collectionView performBatchUpdates:^{
            NSMutableArray* indexPaths = [NSMutableArray new];
            
            for (NSInteger i = previousNumberOfCards; i < previousNumberOfCards + 3; i++) {
                [indexPaths addObject:[NSIndexPath indexPathForItem:i
                                                          inSection:0]];
            }
            
            [self.collectionView insertItemsAtIndexPaths:indexPaths];
            
        } completion:nil];
    }
}

@end
