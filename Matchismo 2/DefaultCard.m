//
//  DefaultCard.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/6/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "DefaultCard.h"

@implementation DefaultCard

+ (Deck*)createDeck {
    Deck* deck = [Deck new];
    
    for (int suite = 0; suite < NUMBER_OF_SUITS; suite++) {
        for (int rank = 1; rank < 10 + NUMBER_OF_FACES; rank++) {
            DefaultCard* curCard = [[DefaultCard alloc] initWithSuite:suite withRank:rank];
            [deck.cards addObject:curCard];
        }
    }
    
   
    return deck;
}

+ (BOOL)isMatch:(NSArray *)cards value:(NSInteger *)value {
    DefaultCard* card = [cards firstObject];
    DefaultCard* otherCard = cards[1];
    
    NSInteger increment = 0;
    
    bool suiteMatch = (card.suite == otherCard.suite);
    bool rankMatch = (card.rank == otherCard.rank);
    
    if (rankMatch || suiteMatch) {
        if (rankMatch) {
            if (card.isAceCard && otherCard.isAceCard) {
                increment += 8;
            }
            increment += 4;
        }
        
        if (suiteMatch) {
            increment += 1;
        }
        
        *value = increment;
        return true;
    }
    
    return false;
}

+ (NSInteger)cardsInMatch {
    return 2;
}

- (instancetype)initWithSuite:(NSInteger)suite withRank:(NSInteger)rank {
    self = [super init];
    
    if (self) {
        self.suite = suite;
        self.rank = rank;
    }
    
    return self;
}

- (BOOL)isFaceCard {
    return self.rank >= Joker && self.rank < Ace;
}

- (BOOL)isAceCard {
    return self.rank == Ace;
}

@end
