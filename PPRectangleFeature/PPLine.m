//
//  PPLine.m
//  S2iPhone
//
//  Created by Pai Peng on 23/02/2017.
//  Copyright © 2017 Pai Peng. All rights reserved.
//

#import "PPLine.h"

@interface PPLine() {
    CGFloat a;
    CGFloat b;
}
@end

@implementation PPLine

+ (PPLine*) initPPLineWithPointA: (CGPoint) pointA withPointB: (CGPoint) pointB {
    PPLine* ppLine = [PPLine new];
    if (ppLine) {
        [ppLine setPointA:pointA];
        [ppLine setPointB:pointB];
        [ppLine calculateAB];
    }
    return ppLine;
}

- (void) calculateAB {
    // y = a * x + b;
    a = (self.pointB.y - self.pointA.y) / (self.pointB.x - self.pointA.x);
    b = self.pointB.y - a * (self.pointB.x);
}

- (CGFloat) getFactorA {
    return a;
}
- (CGFloat) getConstantB {
    return b;
}

+ (CGPoint*) calculateIntersectionPointWithLine: (PPLine*) lineA withLine: (PPLine*) lineB {
    CGPoint* intersectionPoint = nil;
    if (lineA && lineB) {
        intersectionPoint = (CGPoint*) malloc(sizeof(CGPoint));
        intersectionPoint->x = ([lineA getConstantB] - [lineB getConstantB])/([lineB getFactorA] - [lineA getFactorA]);
        intersectionPoint->y = [lineA getFactorA] * intersectionPoint->x + [lineA getConstantB];
        
    }
    return intersectionPoint;
}
@end
