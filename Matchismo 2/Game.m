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

@property (readwrite) NSInteger score;

@end

@implementation Game

- (instancetype)initWithCard:(Class)cardClass
                cardsOnTable:(NSInteger)cards {
    self = [super init];
    
    if (self) {
        self.cardClass = cardClass;
        
        Deck* deck = [cardClass createDeck];
        
        for (int i = 0; i < cards; i++) {
            [self.cardsOnTable addObject:[deck popRandomCard]];
        }
        
        self.cardsToMatch = [cardClass cardsInMatch];
    }
    
    return self;
}

- (void)selectCard:(NSInteger)index {
    Card* card = self.cardsOnTable[index];
    if (card.matched) return; // if already matched, no need to do anything with it.
    
    // if already flipped, let's assume the player is flipping it back
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
    
    card.state = Selected;
    [self.selectedCards addObject:card];
    self.score -= 1;
    
    // check for match
    if ([self.selectedCards count] == self.cardsToMatch) {
        
        bool successfulMatch = false;
        NSInteger value = 0;
        // we have a match!
        if ([self.cardClass isMatch:self.selectedCards value:&value]) {
            self.score += 1; // reverse penalty
            self.score += value;
            
            [self.selectedCards removeAllObjects];
            
            successfulMatch = true;
        }
    }
}

@end
