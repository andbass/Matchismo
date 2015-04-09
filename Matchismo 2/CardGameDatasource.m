//
//  CardGameDatasource.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/9/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "CardGameDatasource.h"
#import "CardViewer.h"

@implementation CardGameDatasource

- (instancetype)initWithGame:(Game *)game withView:(UICollectionView*)view {
    self = [super init];
   
    if (self) {
        self.game = game;
        self.collectionView = view;
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.game.cardsOnTable count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardViewer* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Card" forIndexPath:indexPath];
    
    NSInteger index = [indexPath item];
    cell.card = self.game.cardsOnTable[index];
    
    return cell;
}

@end
