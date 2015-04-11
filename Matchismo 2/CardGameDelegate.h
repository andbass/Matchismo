//
//  CardGameDelegate.h
//  Matchismo 2
//
//  Created by Spensa Tech on 4/9/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "UpdateProtocol.h"

#import "Game.h"

@interface CardGameDelegate : NSObject <UICollectionViewDelegate>

@property Game* game;

- (instancetype)initWithGame:(Game*)game updater:(id <UpdateProtocol>)updater;

@end
