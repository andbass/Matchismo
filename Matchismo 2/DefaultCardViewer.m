//
//  DefaultCardViewer.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/6/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "DefaultCardViewer.h"
#import "Macros.h"

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
    [super drawRect:rect];
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    if (self.card.isFaceCard) {
        UIImage* front = [UIImage imageNamed:[self rankSym]];
        
        CGRect rect = CGRectInset(self.bounds, self.bounds.size.width * BASE_FRONT_IMAGE_INSET_PERCENT, self.bounds.size.height * BASE_FRONT_IMAGE_INSET_PERCENT);
        
        [front drawInRect:rect];
    }
    
    [self drawCorners:ref];
}

@end
