//
//  SetCardViewer.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/6/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "SetCardViewer.h"
#import "Macros.h"

@interface SetCardViewer()

@property (readonly) UIBezierPath* shape;

@property (readonly) UIBezierPath* diamondPath;
@property (readonly) UIBezierPath* squigglePath;
@property (readonly) UIBezierPath* rectanglePath;

@property (readonly) UIColor* strokeColor;
@property (readonly) UIColor* fillColor;

@property (readonly) CGAffineTransform scaleMatrix;

@end

#define DISTANCE_BETWEEN_LINES 5
#define VERTICAL_GAP 5

@implementation SetCardViewer

UIVIEW_CONSTRUCTORS(setup);

- (void)setup {
    [super setup];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIBezierPath* path = self.shape;
    
    CGFloat gap = path.bounds.size.height + VERTICAL_GAP;
    CGFloat percentageOffset = self.card.rank / 2.0 - 0.5;
    CGFloat offset = percentageOffset * gap;
    
    [path applyTransform:CGAffineTransformMakeTranslation(0.0, -offset)];
    
    for (int i = 0; i < self.card.rank; i++) {
        [self drawShading:path];
        [path applyTransform:CGAffineTransformMakeTranslation(0.0, gap)];
    }
}

- (void)drawShading:(UIBezierPath*)path {
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    if (self.card.shading == Solid) {
        [self.fillColor setFill];
        [path fill];
        
        return;
    }
    
    if (self.card.shading == Striped) {
        CGContextSaveGState(ref);
        
        [path addClip];
        UIBezierPath* lines = [UIBezierPath new];
        
        for (int x = 0; x < self.bounds.size.width; x += DISTANCE_BETWEEN_LINES) {
            [lines moveToPoint:CGPointMake(x, 0)];
            [lines addLineToPoint:CGPointMake(x, self.bounds.size.height)];
        }
        
        [self.fillColor setStroke];
        [lines stroke];
        
        CGContextRestoreGState(ref);
    }
        
    [self.strokeColor setStroke];
    [path stroke];
}

- (UIBezierPath*)shape {
    const NSArray* shapes = @[self.diamondPath, self.squigglePath, self.rectanglePath];
    return shapes[self.card.shape];
}

- (UIBezierPath*)diamondPath {
    UIBezierPath* path = [UIBezierPath new];
    
    [path moveToPoint:CGPointMake(0.2, 0.5)];
    [path addLineToPoint:CGPointMake(0.5, 0.4)];
    [path addLineToPoint:CGPointMake(0.8, 0.5)];
    [path addLineToPoint:CGPointMake(0.5, 0.6)];
    [path closePath];
    
    [path applyTransform:self.scaleMatrix];
                       
    return path;
}

- (UIBezierPath*)squigglePath {
    UIBezierPath* path = [UIBezierPath new];
    
    path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 10, 10)];
    
    return path;
}

- (UIBezierPath*)rectanglePath {
    CGRect rect = CGRectMake(0.2, 0.4, 0.6, 0.2);
    
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4];
    [path applyTransform:self.scaleMatrix];
    
    return path;
}

- (CGAffineTransform)scaleMatrix {
    return CGAffineTransformMakeScale(self.bounds.size.width, self.bounds.size.height);
}

- (UIColor*)fillColor {
    CGFloat hue, sat, bright, alpha;
    
    [self.strokeColor getHue:&hue saturation:&sat brightness:&bright alpha:&alpha];
    
    return [UIColor colorWithHue:hue saturation:(sat - 0.2) brightness:1.0 alpha:1.0];
}

- (UIColor*)strokeColor {
    const NSArray* colors = @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]];
    
    return colors[self.card.color];
}

@end
