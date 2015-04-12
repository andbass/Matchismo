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
    [super drawRect:rect cardColor:(self.card.state == Open) ? [UIColor whiteColor] : [UIColor grayColor]];
    
    UIBezierPath* path = self.shape;
    path.lineWidth = 2.0;
    
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
        lines.lineWidth = 1.0;
        
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

// Adapted from: http://stackoverflow.com/questions/25387940/how-to-draw-a-perfect-squiggle-in-set-card-game-with-objective-c
- (UIBezierPath*)squigglePath {
    UIBezierPath* path = [UIBezierPath new];
    
    [path moveToPoint:CGPointMake(0.05, 0.40)];
    
    [path addCurveToPoint:CGPointMake(0.35,   0.25)
            controlPoint1:CGPointMake(0.09,   0.15)
            controlPoint2:CGPointMake(0.18,   0.10)];
    
    [path addCurveToPoint:CGPointMake(0.75,   0.30)
            controlPoint1:CGPointMake(0.40,   0.30)
            controlPoint2:CGPointMake(0.60,   0.45)];
    
    [path addCurveToPoint:CGPointMake(0.97,   0.35)
            controlPoint1:CGPointMake(0.87,   0.15)
            controlPoint2:CGPointMake(0.98,   0.00)];
    
    [path addCurveToPoint:CGPointMake(0.45,   0.85)
            controlPoint1:CGPointMake(0.95,   1.10)
            controlPoint2:CGPointMake(0.50,   0.95)];
    
    [path addCurveToPoint:CGPointMake(0.25,   0.85)
            controlPoint1:CGPointMake(0.40,   0.80)
            controlPoint2:CGPointMake(0.35,   0.75)];
    
    [path addCurveToPoint:CGPointMake(0.05,   0.40)
            controlPoint1:CGPointMake(0.00,   1.10)
            controlPoint2:CGPointMake(0.005,  0.60)];
    
    [path applyTransform:self.scaleMatrix];
    [path applyTransform:CGAffineTransformMakeScale(0.6, 0.3)];
    
    CGPoint beginningPoint = { self.bounds.size.width * 0.05, self.bounds.size.height * 0.05 };
    
    [path applyTransform:CGAffineTransformMakeTranslation(self.bounds.size.width / 2.0 - beginningPoint.x, self.bounds.size.height / 2.0 - beginningPoint.y)];
    [path applyTransform:CGAffineTransformMakeTranslation(-path.bounds.size.width / 2.0, -path.bounds.size.height / 2.0)];
    
    return path;
}

- (UIBezierPath*)rectanglePath {
    CGRect rect = CGRectMake(0.2, 0.4, 0.6, 0.2);
    
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cornerRadius];
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
