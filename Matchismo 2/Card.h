//
//  Card.h
//  Matchismo 2
//
//  Created by Spensa Tech on 4/6/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

typedef NS_ENUM(NSInteger, State) {
    Selected = 1,
    Open = 0,
    Matched = -1,
};

@interface Card : NSObject

+ (Deck*)createDeck;
+ (BOOL)isMatch:(NSArray*)cards value:(NSInteger*)value;

// How many cards must be selected before a match is computed
+ (NSInteger)cardsInMatch;

@property State state;

@property (readonly) BOOL matched;

- (void)flip;

@end
