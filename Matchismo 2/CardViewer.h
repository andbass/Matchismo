//
//  CardViewer.h
//  Matchismo 2
//
//  Created by Spensa Tech on 4/6/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

#define BASE_RADIUS 12
#define BASE_STROKE_WIDTH 4.0

#define BASE_HEIGHT 180
#define BASE_WIDTH 115

#define BASE_PADDING_PERCENT 0.1

#define BASE_FONT_SIZE 36

#define BASE_FRONT_IMAGE_INSET_PERCENT 0.2

@interface CardViewer : UICollectionViewCell

@property Card* card;

@property (readonly) CGSize padding;
@property (readonly) CGFloat fontSize;

@property (readonly) CGSize imageInset;
@property (readonly) CGRect imageRect;

@property (readonly) NSDictionary* baseTextAttributes;

- (void)setup;

- (void)drawRect:(CGRect)rect withCardFill:(UIColor*)cardFill;

@end
