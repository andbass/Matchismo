//
//  Deck.m
//  Matchismo
//
//  Created by Spensa Tech on 3/9/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "Deck.h"
#import "Macros.h"

@implementation Deck

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.cards = [NSMutableArray new];
    }
    
    return self;
}

- (Card*)popRandomCard {
    int index = arc4random() % [self.cards count];
    
    Card* card = [self.cards objectAtIndex:index];
    [self.cards removeObjectAtIndex:index];
   
    return card;
}

@end
