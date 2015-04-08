//
//  macros.h
//  Matchismo
//
//  Created by Spensa Tech on 3/30/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#ifndef MACROS_H
#define MACROS_H

#define ABSTRACT_METHOD @throw [NSException exceptionWithName:@"Abstract method called" reason:[NSString stringWithFormat:@"%s is an abstract method", __PRETTY_FUNCTION__] userInfo:nil];

#define UIVIEW_CONSTRUCTORS(fn) \
    - (void)awakeFromNib { \
        [super fn]; \
    } \
    - (instancetype)initWithFrame:(CGRect)frame { \
        self = [super initWithFrame:frame]; \
        if (self) { \
            [self fn]; \
        } \
        return self; \
    }

#endif