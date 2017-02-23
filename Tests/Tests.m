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

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    PPRectangleFeature* feature = [PPRectangleFeature new];
}

- (void)testPPLine {
    PPLine* line = [PPLine initPPLineWithPointA:CGPointMake(1, 1) withPointB:CGPointMake(3, 2)];
    CGFloat a = [line getFactorA];
    CGFloat b = [line getConstantB];
    
    XCTAssertEqual(a, 0.5, @"failed");
    XCTAssertEqual(b, 0.5, @"failed");
    
    
    
    line = [PPLine initPPLineWithPointA:CGPointMake(10, 1) withPointB:CGPointMake(5, 21)];
    a = [line getFactorA];
    b = [line getConstantB];
    
    XCTAssertEqual(a, -4, @"failed");
    XCTAssertEqual(b, 41, @"failed");
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

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
