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
    return (CGFloat)BASE_FONT_SIZE / (CGFloat)BASE_HEIGHT * self.bounds.size.height;
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
    [self drawRect:rect cardColor:[UIColor whiteColor]];
}

- (void)drawRect:(CGRect)rect cardColor:(UIColor*)fillColor {
    [super drawRect:rect];
    
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                    cornerRadius:self.cornerRadius];
    
    [path addClip];
    
    [fillColor setFill];
    [path fill];
}

- (CGFloat)cornerRadius {
    CGFloat ratio = self.bounds.size.height / BASE_HEIGHT;
    
    return BASE_RADIUS * ratio;
}

@end
