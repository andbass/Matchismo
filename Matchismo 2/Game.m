//
//  Game.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/6/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "Game.h"
#import "Card.h"

@interface Game()

@property Deck* deck;
@property (readwrite) NSInteger score;

@end

@implementation Game

- (instancetype)initWithCard:(Class)cardClass
                cardsOnTable:(NSInteger)cards {
    self = [super init];
    
    if (self) {
        self.cardClass = cardClass;
        self.cardsOnTable = [NSMutableArray new];
        self.selectedCards = [NSMutableArray new];
        
        self.deck = [cardClass createDeck];
        
        for (int i = 0; i < cards; i++) {
            [self.cardsOnTable addObject:[self.deck popRandomCard]];
        }
        
        self.cardsToMatch = [cardClass cardsInMatch];
    }
    
    return self;
}

- (void)selectCard:(NSInteger)index {
    Card* card = self.cardsOnTable[index];
    if (card.matched) return; // if already matched, no need to do anything with it.

    [card flip];
    
    if (card.state == Open) {
        [self.selectedCards removeObject:card];
        
        return;
    }
    
    // if two cards are already selected, we have to clear the selected cards
    if ([self.selectedCards count] == self.cardsToMatch) {
        for (Card* card in self.selectedCards) {
            card.state = Open;
        }
        
        [self.selectedCards removeAllObjects];
    }
    
    [self.selectedCards addObject:card];
    self.score -= 1;
    
    // check for match
    if ([self.selectedCards count] == self.cardsToMatch) {
        NSInteger value = 0;
        
        // we have a match!
        if ([self.cardClass isMatch:self.selectedCards value:&value]) {
            self.score += 1; // reverse penalty
            self.score += value;
            
            for (Card* card in self.selectedCards) {
                card.state = Matched;
            }
            
            [self.selectedCards removeAllObjects];
        }
    }
}

- (BOOL)dealMoreCards:(NSInteger)cardsToDeal {
    if ([self.deck.cards count] < cardsToDeal) return false;
    
    for (int i = 0; i < cardsToDeal; i++) {
        [self.cardsOnTable addObject:[self.deck popRandomCard]];
    }
    
    return true;
}

@end
