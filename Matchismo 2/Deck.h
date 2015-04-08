//
//  Deck.h
//  Matchismo
//
//  Created by Spensa Tech on 3/9/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Card;

@interface Deck : NSObject

@property (nonatomic) NSMutableArray* cards;

- (Card*)popRandomCard;

@end
