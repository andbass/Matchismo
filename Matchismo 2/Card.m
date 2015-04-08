//
//  Card.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/6/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "Card.h"
#import "Macros.h"

@implementation Card

+ (Deck*)createDeck {
    ABSTRACT_METHOD
}

+ (BOOL)isMatch:(NSArray*)cards value:(NSInteger *)value {
    ABSTRACT_METHOD
}

+ (NSInteger)cardsInMatch {
    ABSTRACT_METHOD
}

- (BOOL)matched {
    return self.state == Matched;
}

- (void)flip {
    if (self.state == Matched) return;
    
    self.state = !self.state;
}

@end
