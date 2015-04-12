//
//  SetCard.h
//  Matchismo 2
//
//  Created by Spensa Tech on 4/12/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "Card.h"

#define NUMBER_OF_SHAPES 3
typedef NS_ENUM(NSInteger, Shape) {
    ThinDiamond,
    Squiggle,
    Rectangle,
};

#define NUMBER_OF_COLORS 3
typedef NS_ENUM(NSInteger, Color) {
    Red,
    Green,
    Purple,
};

#define NUMBER_OF_SHADINGS 3
typedef NS_ENUM(NSInteger, Shading) {
    NoShading,
    Striped,
    Solid,
};

@interface SetCard : Card

@property (nonatomic) Shape shape;

@property (nonatomic) Shading shading;

@property (nonatomic) Color color;

@property (nonatomic) NSInteger rank;

@end
