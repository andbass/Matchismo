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

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation CardGameController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.game = [[Game alloc] initWithCard:DefaultCard.class cardsOnTable:12];
    self.dataSource = [[CardGameDatasource alloc] initWithGame:self.game withView:self.collectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.collectionView.backgroundColor = nil;
    
    
    self.collectionView.dataSource = self.dataSource;
}

@end
