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
    CGFloat x;
    CGFloat y;
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
    x = INFINITY;
    y = INFINITY;

    // y = a * x + b;
    if (self.pointB.x == self.pointA.x) {
        a = 1;
        b = -self.pointA.x;
        if (self.pointA.y < self.pointB.y) {
            alphaDegree = 90;
        } else {
            alphaDegree = -90;
        }
        alphaRadian = alphaDegree * M_PI / 180;
        x = self.pointA.x;
    } else if (self.pointB.y == self.pointA.y) {
        a = 0;
        b = self.pointB.y;
        alphaDegree = 0;
        alphaRadian = alphaDegree * M_PI / 180;
        
        y = self.pointA.y;
    } else {
        a = (self.pointB.y - self.pointA.y) / (self.pointB.x - self.pointA.x);
        b = self.pointB.y - a * (self.pointB.x);
        alphaRadian = atan(a);
        alphaDegree = alphaRadian*180/M_PI;
    }
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

- (CGFloat) getX {
    return x;
}
- (CGFloat) getY {
    return y;
}
- (BOOL) isTLine {
    return (x != INFINITY || y != INFINITY);
}

- (PPLine*) shiftLineWithDistance: (CGFloat) distance {
    CGPoint pointA, pointB;
    if (x == INFINITY && y == INFINITY) {
        CGFloat shiftDistance = [self calculateShiftDistanceWithDegree:distance];
        pointA = CGPointMake(self.pointA.x, self.pointA.y + shiftDistance);
        pointB = CGPointMake(self.pointB.x, self.pointB.y + shiftDistance);
    } else if (x != INFINITY) {
        pointA = CGPointMake(self.pointA.x + distance, self.pointA.y);
        pointB = CGPointMake(self.pointB.x + distance, self.pointB.y);
    } else if (y != INFINITY) {
        pointA = CGPointMake(self.pointA.x, self.pointA.y + distance);
        pointB = CGPointMake(self.pointB.x, self.pointB.y + distance);
    }
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
        // no T Lines
        if (![lineA isTLine] && ![lineB isTLine]) {
            intersectionPoint = (CGPoint*) malloc(sizeof(CGPoint));
            intersectionPoint->x = ([lineA getConstantB] - [lineB getConstantB])/([lineB getFactorA] - [lineA getFactorA]);
            intersectionPoint->y = [lineA getFactorA] * intersectionPoint->x + [lineA getConstantB];
        } else if ([lineA isTLine] && [lineB isTLine]) {
            // both T Lines
            if ([lineA getX] != INFINITY && [lineB getY] != INFINITY) {
                intersectionPoint = (CGPoint*) malloc(sizeof(CGPoint));
                intersectionPoint->x = [lineA getX];
                intersectionPoint->y = [lineB getY];
            } else if ([lineA getY] != INFINITY && [lineB getX] != INFINITY) {
                intersectionPoint = (CGPoint*) malloc(sizeof(CGPoint));
                intersectionPoint->x = [lineB getX];
                intersectionPoint->y = [lineA getY];
            } else {
                
            }
        } else if([lineA isTLine]) {
            // only one T Line
            intersectionPoint = (CGPoint*) malloc(sizeof(CGPoint));
            if ([lineA getX] != INFINITY) {
                intersectionPoint->x = [lineA getX];
                intersectionPoint->y = [lineA getX] * [lineB getFactorA] + [lineB getConstantB];
            } else {
                intersectionPoint->x = ([lineA getY] - [lineB getConstantB])/ [lineB getFactorA];
                intersectionPoint->y = [lineA getY];
            }
        } else if([lineB isTLine]) {
            intersectionPoint = (CGPoint*) malloc(sizeof(CGPoint));
            if ([lineB getX] != INFINITY) {
                intersectionPoint->x = [lineB getX];
                intersectionPoint->y = [lineB getX] * [lineA getFactorA] + [lineA getConstantB];
            } else {
                intersectionPoint->x = ([lineB getY] - [lineA getConstantB])/ [lineA getFactorA];
                intersectionPoint->y = [lineB getY];
            }
        }
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
