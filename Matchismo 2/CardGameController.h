//
//  CardGameController.h
//  Matchismo 2
//
//  Created by Spensa Tech on 4/9/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardGameDatasource.h"
#import "CardGameDelegate.h"

#import "Game.h"
#import "DefaultCard.h"

#import "UpdateProtocol.h"

@interface CardGameController : UIViewController <UpdateProtocol>

@property Game* game;

@property CardGameDatasource* dataSource;
@property CardGameDelegate* delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

- (Game*)generateGame;

- (void)appendCards:(NSInteger)cards scorePenalty:(BOOL)penalty;

@end
