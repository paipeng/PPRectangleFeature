//
//  PPRectangleFeature+expand.m
//  S2iPhone
//
//  Created by Pai Peng on 23/02/2017.
//  Copyright © 2017 Pai Peng. All rights reserved.
//

#import "PPRectangleFeature+expand.h"
#import "PPLine.h"

@interface PPRectangleFeature () {
    CGPoint expandTopLeft;
    CGPoint expandTopRight;
    CGPoint expandBottomRight;
    CGPoint expandBottomLeft;
}

@end


@implementation PPRectangleFeature (expand)

- (CIRectangleFeature*) addBorder: (CGFloat) border {
    return nil;
}


@end
