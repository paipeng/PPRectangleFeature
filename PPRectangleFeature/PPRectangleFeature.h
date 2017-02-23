//
//  PPRectangleFeature.h
//  PPRectangleFeature
//
//  Created by Pai Peng on 23/02/2017.
//  Copyright © 2017 Pai Peng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPLine.h"

@interface PPRectangleFeature : NSObject

@property (nonatomic) CGPoint topLeft;
@property (nonatomic) CGPoint topRight;
@property (nonatomic) CGPoint bottomRight;
@property (nonatomic) CGPoint bottomLeft;
@end
