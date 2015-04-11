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

// An array of cards which were matched after a turn
// Upon selection of another card, this array is cleared
@property (readonly) NSMutableArray* recentlyMatchedCards;

@property (readonly) NSInteger score;

@property Class cardClass;

- (instancetype)initWithCard:(Class)cardClass
                cardsOnTable:(NSInteger)cards;

- (void)selectCard:(NSInteger)index;

// Adds more cards from the deck onto the table.
// Incurs a penalty, a point is deducted from the player's score for each card added
- (BOOL)dealMoreCards:(NSInteger)cardsToDeal;

- (void)clearMatchedCards;

@end
