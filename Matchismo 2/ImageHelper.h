//
//  ImageHelper.h
//  Matchismo 2
//
//  Created by Spensa Tech on 4/11/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (WithColor)

+ (UIImage*)imageNamed:(NSString *)name withColor:(UIColor*)color;

@end
