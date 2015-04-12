//
//  CardGameController.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/9/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "CardGameController.h"
#import "Macros.h"

@implementation CardGameController

- (Game*)generateGame {
    ABSTRACT_METHOD
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.game = [self generateGame];
    
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

- (void)updateScore {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}

@end
