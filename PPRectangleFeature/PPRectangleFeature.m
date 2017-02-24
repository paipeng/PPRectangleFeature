//
//  PPRectangleFeature.m
//  PPRectangleFeature
//
//  Created by Pai Peng on 23/02/2017.
//  Copyright © 2017 Pai Peng. All rights reserved.
//

#import "PPRectangleFeature.h"

@implementation PPRectangleFeature


- (CIRectangleFeature*) addBorder: (CGFloat) border {
    CGPoint expandTopLeft;
    CGPoint expandTopRight;
    CGPoint expandBottomRight;
    CGPoint expandBottomLeft;
#if 0
    // top
    PPLine* lineTop = [PPLine initPPLineWithPointA:self.topLeft withPointB:self.topRight];
    PPLine* shiftLineTop = [lineTop shiftLineWithDistance:border];
    
    // right
    PPLine* lineRight = [PPLine initPPLineWithPointA:self.topRight withPointB:self.bottomRight];
    PPLine* shiftLineRight = [lineRight shiftLineWithDistance:border];
    
    // left
    PPLine* lineLeft = [PPLine initPPLineWithPointA:self.bottomLeft withPointB:self.topLeft];
    PPLine* shiftLineLeft = [lineLeft shiftLineWithDistance:-border];

    // bottom
    PPLine* lineBottom = [PPLine initPPLineWithPointA:self.bottomRight withPointB:self.bottomLeft];
    PPLine* shiftLineBottom = [lineBottom shiftLineWithDistance:-border];
#else
    // top
    PPLine* lineTop = [PPLine initPPLineWithPointA:self.topRight withPointB:self.topLeft];
    PPLine* shiftLineTop = [lineTop shiftLineWithDistance:border];
    
    // right
    PPLine* lineRight = [PPLine initPPLineWithPointA:self.bottomRight withPointB:self.topRight];
    PPLine* shiftLineRight = [lineRight shiftLineWithDistance:border];
    
    // left
    PPLine* lineLeft = [PPLine initPPLineWithPointA:self.topLeft withPointB:self.bottomLeft];
    PPLine* shiftLineLeft = [lineLeft shiftLineWithDistance:border];
    
    // bottom
    PPLine* lineBottom = [PPLine initPPLineWithPointA:self.bottomLeft withPointB:self.bottomRight];
    PPLine* shiftLineBottom = [lineBottom shiftLineWithDistance:-border];
#endif
    
    CGPoint* p = [PPLine calculateIntersectionPointWithLine:shiftLineTop withLine:shiftLineRight];
    if (p) {
        expandTopRight.x = p->x;
        expandTopRight.y = p->y;
        free(p);
    }
    
    
    p = [PPLine calculateIntersectionPointWithLine:shiftLineLeft withLine:shiftLineTop];
    if (p) {
        expandTopLeft.x = p->x;
        expandTopLeft.y = p->y;
        free(p);
    }
    p = [PPLine calculateIntersectionPointWithLine:shiftLineRight withLine:shiftLineBottom];
    if (p) {
        expandBottomRight.x = p->x;
        expandBottomRight.y = p->y;
        free(p);
    }p = [PPLine calculateIntersectionPointWithLine:shiftLineBottom withLine:shiftLineLeft];
    if (p) {
        expandBottomLeft.x = p->x;
        expandBottomLeft.y = p->y;
        free(p);
    }
    
    
    PPRectangleFeature* expandedRectangleFeature = [PPRectangleFeature new];
    [expandedRectangleFeature setTopRight:expandTopRight];
    [expandedRectangleFeature setTopLeft:expandTopLeft];
    [expandedRectangleFeature setBottomLeft:expandBottomLeft];
    [expandedRectangleFeature setBottomRight:expandBottomRight];
    return (id)expandedRectangleFeature;
}

@end
