//
//  Game.h
//  Matchismo 2
//
//  Created by Spensa Tech on 4/6/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface Game : NSObject

@property NSInteger cardsToMatch;

@property NSMutableArray* selectedCards;
@property NSMutableArray* cardsOnTable;

@property (readonly) NSInteger score;

@property Class cardClass;

- (instancetype)initWithCard:(Class)cardClass
                cardsOnTable:(NSInteger)cards;

- (void)selectCard:(NSInteger)index;
- (BOOL)dealMoreCards:(NSInteger)cardsToDeal;

@end
