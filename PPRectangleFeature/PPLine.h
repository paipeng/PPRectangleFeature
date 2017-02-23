//
//  PPLine.h
//  S2iPhone
//
//  Created by Pai Peng on 23/02/2017.
//  Copyright © 2017 Pai Peng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PPLine : NSObject

@property (nonatomic) CGPoint pointA;
@property (nonatomic) CGPoint pointB;

+ (PPLine*) initPPLineWithPointA: (CGPoint) pointA withPointB: (CGPoint) pointB;
- (CGFloat) getFactorA;
- (CGFloat) getConstantB;
- (void) calculate;

+ (CGPoint*) calculateIntersectionPointWithLine: (PPLine*) lineA withLine: (PPLine*) lineB;
+ (CGFloat) calculateDistanceBetweenLine: (PPLine*) lineA andLine: (PPLine*) lineB;

- (CGFloat) getAlphaDegree;
- (CGFloat) getAlphaRadian;
- (CGFloat) calculateShiftDistanceWithDegree: (CGFloat) distance;
- (PPLine*) shiftLineWithDistance: (CGFloat) distance;
@end
