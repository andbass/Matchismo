//
//  ImageHelper.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/11/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "ImageHelper.h"

// Thanks to: https://coffeeshopped.com/2010/09/iphone-how-to-dynamically-color-a-uiimage
@implementation UIImage (WithColor)

+ (UIImage*)imageNamed:(NSString *)name withColor:(UIColor*)color {
    UIImage* image = [UIImage imageNamed:name];
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    [color setFill];
    
    CGContextTranslateCTM(ref, 0, image.size.height);
    CGContextScaleCTM(ref, 1.0, -1.0);
    
    CGContextSetBlendMode(ref, kCGBlendModeColor);
    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(ref, bounds, image.CGImage);
    
    CGContextClipToMask(ref, bounds, image.CGImage);
    CGContextAddRect(ref, bounds);
    CGContextDrawPath(ref, kCGPathFill);
    
    UIImage* coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return coloredImage;
}

@end
