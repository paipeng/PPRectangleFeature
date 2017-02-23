//
//  Tests.m
//  Tests
//
//  Created by Pai Peng on 23/02/2017.
//  Copyright © 2017 Pai Peng. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PPRectangleFeature.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPPLine {
    CGFloat distance = 10;
    
    PPLine* line = [PPLine initPPLineWithPointA:CGPointMake(1, 1) withPointB:CGPointMake(3, 2)];
    CGFloat a = [line getFactorA];
    CGFloat b = [line getConstantB];
    CGFloat degree = round([line getAlphaDegree]*1000)/1000;
    XCTAssertEqual(a, 0.5, @"failed");
    XCTAssertEqual(b, 0.5, @"failed");
    XCTAssertEqual(degree, 26.565, @"failed");
    
    CGFloat d = round([line calculateShiftDistanceWithDegree:distance]*1000)/1000;
    XCTAssertEqual(d, 11.180, @"failed");
    
    PPLine* shiftLine = [line shiftLineWithDistance:distance];
    
    CGFloat sd = [PPLine calculateDistanceBetweenLine:line andLine:shiftLine];
    XCTAssertEqual(fabs(sd), distance, @"failed");
    
    
    line = [PPLine initPPLineWithPointA:CGPointMake(10, 1) withPointB:CGPointMake(5, 21)];
    a = [line getFactorA];
    b = [line getConstantB];
    
    degree = round([line getAlphaDegree]*1000)/1000;
    
    XCTAssertEqual(a, -4, @"failed");
    XCTAssertEqual(b, 41, @"failed");
    XCTAssertEqual(degree, -75.964, @"failed");
    d = round([line calculateShiftDistanceWithDegree:10]*1000)/1000;
    XCTAssertEqual(d, 41.231, @"failed");
    
    
    line = [PPLine initPPLineWithPointA:CGPointMake(10, 1) withPointB:CGPointMake(10, 2)];
    a = [line getFactorA];
    b = [line getConstantB];
    
    degree = round([line getAlphaDegree]*1000)/1000;
    
    XCTAssertEqual(a, 1, @"failed");
    XCTAssertEqual(b, -10, @"failed");
    XCTAssertEqual([line getX], 10, @"failed");
    XCTAssertEqual([line getY], INFINITY, @"failed");
    XCTAssertEqual(degree, 90, @"failed");
    d = round([line calculateShiftDistanceWithDegree:10]*1000)/1000;
    XCTAssertEqual(d, 10, @"failed");

    line = [PPLine initPPLineWithPointA:CGPointMake(10, 2) withPointB:CGPointMake(10, 1)];
    a = [line getFactorA];
    b = [line getConstantB];
    
    degree = round([line getAlphaDegree]*1000)/1000;
    
    XCTAssertEqual(a, 1, @"failed");
    XCTAssertEqual(b, -10, @"failed");
    XCTAssertEqual(degree, -90, @"failed");
    
    XCTAssertEqual([line getX], 10, @"failed");
    XCTAssertEqual([line getY], INFINITY, @"failed");
    
    d = round([line calculateShiftDistanceWithDegree:10]*1000)/1000;
    XCTAssertEqual(d, 10, @"failed");

    
    
    line = [PPLine initPPLineWithPointA:CGPointMake(10, 2) withPointB:CGPointMake(20, 2)];
    a = [line getFactorA];
    b = [line getConstantB];
    
    degree = round([line getAlphaDegree]*1000)/1000;
    
    XCTAssertEqual(a, 0, @"failed");
    XCTAssertEqual(b, 2, @"failed");
    XCTAssertEqual(degree, 0, @"failed");
    d = round([line calculateShiftDistanceWithDegree:10]*1000)/1000;
    XCTAssertEqual(d, 10, @"failed");

    
    line = [PPLine initPPLineWithPointA:CGPointMake(20, 2) withPointB:CGPointMake(10, 2)];
    a = [line getFactorA];
    b = [line getConstantB];
    
    degree = round([line getAlphaDegree]*1000)/1000;
    
    XCTAssertEqual(a, 0, @"failed");
    XCTAssertEqual(b, 2, @"failed");
    XCTAssertEqual(degree, 0, @"failed");
    d = round([line calculateShiftDistanceWithDegree:10]*1000)/1000;
    XCTAssertEqual(d, 10, @"failed");
}


- (void) testPPLineCalculateIntersectionPoint {
    PPLine* lineA = [PPLine initPPLineWithPointA:CGPointMake(1, 1) withPointB:CGPointMake(3, 2)];
    PPLine* lineB = [PPLine initPPLineWithPointA:CGPointMake(10, 1) withPointB:CGPointMake(5, 21)];

    CGPoint* p = [PPLine calculateIntersectionPointWithLine:lineA withLine:lineB];
    
    XCTAssertNotEqual(p, nil, @"failed");
    if (p) {
        XCTAssertEqual(p->x, 9, @"failed");
        XCTAssertEqual(p->y, 5, @"failed");
        free(p);
    }
}



- (void)testPPRectangleFeature {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    PPRectangleFeature* feature = [PPRectangleFeature new];
    
    feature.topRight = CGPointMake(10, 10);
    feature.topLeft = CGPointMake(0, 10);
    feature.bottomLeft = CGPointMake(0, 0);
    feature.bottomRight = CGPointMake(10, 0);
    
    
    CIRectangleFeature* rF = [feature addBorder:10];
    
    
    XCTAssertEqual(rF.topLeft.x, -10, @"failed");
    XCTAssertEqual(rF.topLeft.y, 20, @"failed");
    
    XCTAssertEqual(rF.topRight.x, 20, @"failed");
    XCTAssertEqual(rF.topRight.y, 20, @"failed");
    
    XCTAssertEqual(rF.bottomLeft.x, -10, @"failed");
    XCTAssertEqual(rF.bottomLeft.y, -10, @"failed");
    
    XCTAssertEqual(rF.bottomRight.x, 20, @"failed");
    XCTAssertEqual(rF.bottomRight.y, -10, @"failed");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
