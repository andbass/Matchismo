//
//  DefaultCardViewer.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/6/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "DefaultCardViewer.h"
#import "Macros.h"
#import "ImageHelper.h"

@implementation DefaultCardViewer

UIVIEW_CONSTRUCTORS(setup)

- (void)setup {
    [super setup];
}

- (NSString*)suiteSym {
    const NSArray* SUITE_SYM = @[@"♠︎", @"♦︎", @"♣︎", @"♥️"];
    
    return SUITE_SYM[self.card.suite];
}

- (NSString*)rankSym {
    const NSArray* FACE_SYM = @[@"J", @"K", @"Q"];
    
    if (self.card.isFaceCard) { // we have face card
        NSInteger index = self.card.rank - 11;
        
        return FACE_SYM[index];
    } else if (self.card.isAceCard) {
        return @"A";
    } else {
        return [NSString stringWithFormat:@"%ld", (long)self.card.rank];
    }
}

- (NSString*)cornerSym {
    return [NSString stringWithFormat:@"%@\n%@", [self rankSym], [self suiteSym]];
}

- (void)drawCorners:(CGContextRef)ref {
    NSAttributedString* corner = [[NSAttributedString alloc] initWithString:[self cornerSym] attributes:self.baseTextAttributes];
    CGPoint origin = CGPointMake(self.padding.width, self.padding.height);
    
    [corner drawAtPoint:origin];
    
    CGContextTranslateCTM(ref, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(ref, M_PI);
    
    [corner drawAtPoint:origin];
}

- (void)drawRect:(CGRect)rect {
    UIColor* cardFill = (self.card.matched) ? [UIColor grayColor] : [UIColor whiteColor];
    [super drawRect:rect withCardFill:cardFill];
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    // Any unselected card is considered face down for the DefaultCard game
    if (self.card.state == Open) {
        UIImage* cardBack = [UIImage imageNamed:@"CardBack"];
        
        [cardBack drawInRect:self.imageRect];
        return;
    }
    
    if (self.card.isFaceCard) {
        UIImage* front;
        
        if (self.card.matched) {
            front = [UIImage imageNamed:[self rankSym] withColor:cardFill];
        } else {
            front = [UIImage imageNamed:[self rankSym]];
        }
        
        [front drawInRect:self.imageRect];
    }
    
    [self drawCorners:ref];
}

@end
