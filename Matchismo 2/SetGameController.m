//
//  SetGameController.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/12/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "SetGameController.h"

#import "SetCard.h"

#define NUMBER_OF_CARDS 3

@implementation SetGameController

- (Game*)generateGame {
    return [[Game alloc] initWithCard:[SetCard class] cardsOnTable:NUMBER_OF_CARDS];
}

- (IBAction)addMoreCards:(UIButton *)sender {
    [self appendCards:3 scorePenalty:true];
}

@end
