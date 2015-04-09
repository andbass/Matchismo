//
//  CardViewer.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/6/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "CardViewer.h"
#import "Macros.h"

@implementation CardViewer

- (void)setup {
    self.backgroundColor = nil;
    self.opaque = false;
    self.contentMode = UIViewContentModeRedraw;
}

- (CGSize)padding {
    return CGSizeMake(self.bounds.size.width * BASE_PADDING_PERCENT, self.bounds.size.height * BASE_PADDING_PERCENT);
}

- (CGFloat)fontSize {
    return BASE_FONT_SIZE * BASE_HEIGHT / self.bounds.size.height;
}

- (CGRect)imageRect {
    return CGRectInset(self.bounds,
                       self.bounds.size.width * BASE_FRONT_IMAGE_INSET_PERCENT,
                       self.bounds.size.height * BASE_FRONT_IMAGE_INSET_PERCENT);
}

- (NSDictionary*)baseTextAttributes {
    NSMutableParagraphStyle* style = [NSMutableParagraphStyle new];
    style.alignment = NSTextAlignmentCenter;
    
    UIFont* font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    font = [font fontWithSize:self.fontSize];
    
    return @{ NSParagraphStyleAttributeName : style,
                        NSFontAttributeName : font };
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   cornerRadius:[self calculateCornerRadius]];
    
    path.lineWidth = BASE_STROKE_WIDTH / self.bounds.size.height;
    
    [path addClip];
    
    [[UIColor whiteColor] setFill];
    [[UIColor blackColor] setStroke];
    
    [path fill];
    [path stroke];
}

- (CGFloat)calculateCornerRadius {
    CGFloat ratio = self.bounds.size.height / BASE_HEIGHT;
    
    return BASE_RADIUS * ratio;
}

@end
