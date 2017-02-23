//
//  PPRectangleFeature+expand.h
//  S2iPhone
//
//  Created by Pai Peng on 23/02/2017.
//  Copyright © 2017 Pai Peng. All rights reserved.
//

#import "PPRectangleFeature.h"
#import <CoreImage/CoreImage.h>
@interface PPRectangleFeature (expand)

- (CIRectangleFeature*) addBorder: (CGFloat) border;
@end
