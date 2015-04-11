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
    CardViewer* cardViewer = (CardViewer*)[collectionView cellForItemAtIndexPath:indexPath];
    
    [self.game selectCard:index];
    
    if (!cardViewer.card.matched) {
        [self.viewsToBeAnimated addObject:cardViewer];
    }
    
    [collectionView reloadData];
}

@end
