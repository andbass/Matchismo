//
//  SetCard.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/12/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (Deck*)createDeck {
    Deck* deck = [Deck new];
    
    for (int rank = 1; rank <= 3; rank++) {
        for (int color = 0; color < NUMBER_OF_COLORS; color++) {
            for (int shading = 0; shading < NUMBER_OF_SHADINGS; shading++) {
                for (int symbol = 0; symbol < NUMBER_OF_SHAPES; symbol++) {
                    SetCard* card = [SetCard new];
                    
                    card.color = color;
                    card.shape = symbol;
                    card.shading = shading;
                    card.rank = rank;
                    
                    [deck.cards addObject:card];
                }
            }
        }
    }
    
    return deck;
}

#define SCORE_VALUE 6

+ (BOOL)isMatch:(NSArray *)cards value:(NSInteger *)value {
    SetCard* cardOne = cards[0];
    SetCard* cardTwo = cards[1];
    SetCard* cardThree = cards[2];
    
    // TODO FIX ALL OF THIS
    bool numberSet = (cardOne.rank == cardTwo.rank && cardTwo.rank == cardThree.rank && cardOne.rank == cardThree.rank)
                   || (cardOne.rank != cardTwo.rank && cardTwo.rank != cardThree.rank && cardOne.rank != cardThree.rank);
    
    bool symbolSet = (cardOne.shape == cardTwo.shape && cardTwo.shape == cardThree.shape && cardOne.shape == cardThree.shape)
                   || (cardOne.shape != cardTwo.shape && cardTwo.shape != cardThree.shape && cardOne.shape != cardThree.shape);
    
    bool shadingSet = (cardOne.shading == cardTwo.shading && cardTwo.shading == cardThree.shading && cardOne.shading == cardThree.shading)
                    || (cardOne.shading != cardTwo.shading && cardTwo.shading != cardThree.shading && cardOne.shading != cardThree.shading);
    
    bool colorSet = (cardOne.color == cardTwo.color && cardTwo.color == cardThree.color && cardOne.color == cardThree.color)
                  || (cardOne.color != cardTwo.color && cardTwo.color != cardThree.color && cardOne.color != cardThree.color);
    
    if (numberSet && symbolSet && shadingSet && colorSet) {
        *value += SCORE_VALUE;
        return true;
    }
    
    return false;
}

+ (NSInteger)cardsInMatch {
    return 3;
}

@end
