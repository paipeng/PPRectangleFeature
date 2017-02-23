//
//  PPLine.m
//  S2iPhone
//
//  Created by Pai Peng on 23/02/2017.
//  Copyright © 2017 Pai Peng. All rights reserved.
//

#import "PPLine.h"
#import <math.h>

@interface PPLine() {
    CGFloat a;
    CGFloat b;
    CGFloat alphaDegree;
    CGFloat alphaRadian;
}
@end

@implementation PPLine

+ (PPLine*) initPPLineWithPointA: (CGPoint) pointA withPointB: (CGPoint) pointB {
    PPLine* ppLine = [PPLine new];
    if (ppLine) {
        [ppLine setPointA:pointA];
        [ppLine setPointB:pointB];
        [ppLine calculate];
    }
    return ppLine;
}

- (void) calculate {
    // y = a * x + b;
    a = (self.pointB.y - self.pointA.y) / (self.pointB.x - self.pointA.x);
    b = self.pointB.y - a * (self.pointB.x);
    alphaRadian = atan(a);
    alphaDegree = alphaRadian*180/M_PI;
}

- (CGFloat) getFactorA {
    return a;
}
- (CGFloat) getConstantB {
    return b;
}

- (CGFloat) getAlphaDegree {
    return alphaDegree;
}

- (CGFloat) getAlphaRadian {
    return alphaRadian;
}

- (PPLine*) shiftLineWithDistance: (CGFloat) distance {
    CGFloat shiftDistance = [self calculateShiftDistanceWithDegree:distance];
    CGPoint pointA = CGPointMake(self.pointA.x, self.pointA.y + shiftDistance);
    CGPoint pointB = CGPointMake(self.pointB.x, self.pointB.y + shiftDistance);
    PPLine* shiftLine = [PPLine initPPLineWithPointA:pointA withPointB:pointB];
    return shiftLine;
}

- (CGFloat) calculateShiftDistanceWithDegree: (CGFloat) distance {
    if (alphaDegree != 90 && alphaDegree != -90)
        return distance / cos(alphaRadian);
    else
        return distance;
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

+ (CGFloat) calculateDistanceBetweenLine: (PPLine*) lineA andLine: (PPLine*) lineB {
    if ([lineA getFactorA] == [lineB getFactorA]) {
        return cos([lineA getAlphaRadian]) * ([lineA getConstantB] - [lineB getConstantB]);
    } else {
        return 0;
    }
}

@end
