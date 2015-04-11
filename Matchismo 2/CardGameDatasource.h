//
//  CardGameDatasource.h
//  Matchismo 2
//
//  Created by Spensa Tech on 4/9/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CardGameDelegate.h"

#import "Game.h"

@interface CardGameDatasource : NSObject <UICollectionViewDataSource>

@property UICollectionView* collectionView;

@property Game* game;

- (instancetype)initWithGame:(Game*)game;

@end
