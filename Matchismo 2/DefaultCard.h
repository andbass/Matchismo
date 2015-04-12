//
//  DefaultCard.h
//  Matchismo 2
//
//  Created by Spensa Tech on 4/6/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "Card.h"

#define NUMBER_OF_SUITS 4
typedef NS_ENUM(NSInteger, Suite) {
    Spade = 0,
    Diamond,
    Club,
    Heart,
};

#define NUMBER_OF_FACES 4
typedef NS_ENUM(NSInteger, Face) {
    Joker = 11,
    King,
    Queen,
    Ace,
};

@interface DefaultCard : Card

@property Suite suite;

@property NSInteger rank;

@property (readonly) BOOL isFaceCard;
@property (readonly) BOOL isAceCard;

- (instancetype)initWithSuite:(NSInteger)suite
                     withRank:(NSInteger)rank;

@end
