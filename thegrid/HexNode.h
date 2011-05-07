//
//  HexNode.h
//  thegrid
//
//  Created by Bart Vandendriessche on 06/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface HexNode : CCNode {
    float _radius;
    float _height;
    float _rowHeight;
    float _halfWidth;
    float _width;
    
    CGPoint _position;
}

@property (nonatomic, assign) float radius;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) float rowHeight;
@property (nonatomic, assign) float halfWidth;
@property (nonatomic, assign) float width;

@property (nonatomic, assign) CGPoint position;

+ (id)nodeWithRadius:(float)radius position:(CGPoint)position;
- (id)initWithRadius:(float)radius position:(CGPoint)position;

@end
