//
//  HexNode.m
//  thegrid
//
//  Created by Bart Vandendriessche on 06/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HexNode.h"


@implementation HexNode

@synthesize radius = _radius;
@synthesize height = _height;
@synthesize rowHeight = _rowHeight;
@synthesize halfWidth = _halfWidth;
@synthesize width = _width;
@synthesize position = _position;

+ (id)nodeWithRadius:(float)radius position:(CGPoint)position{
    return [[[HexNode alloc] initWithRadius:radius position:position] autorelease];
}

- (id)initWithRadius:(float)radius position:(CGPoint)position{
    if ((self = [super init])) {
        self.radius = radius;
        self.height = 2 * _radius;
        self.rowHeight = 1.5f * _radius;
        self.halfWidth = (float)sqrt((_radius * _radius) - ((_radius / 2) * (_radius / 2)));
        self.width = 2 * _halfWidth;
        
        self.position = position;
    }
    return self;
}

- (CGPoint)tileOrigin:(CGPoint)tileCoordinate {
    int xToInt = (int)tileCoordinate.x;
    return ccp((tileCoordinate.x * _width) + ((xToInt % 2 == 1) ? _halfWidth : 0), //Y % 2 == 1 is asking 'Is Y odd?'
               tileCoordinate.y * _rowHeight);
}

- (CGPoint)tileCenter:(CGPoint) tileCoordinate {
    return ccpAdd(tileCoordinate, ccp(_halfWidth, _halfWidth));
}

- (void)drawHexAt:(CGPoint)center {
    int x = center.x;
    int y = center.y;
    ccDrawLine(ccp(x-_halfWidth,y-_radius/2), ccp(x-_halfWidth,y+_radius/2));
    ccDrawLine(ccp(x-_halfWidth,y+_radius/2), ccp(x,y+_radius));
    ccDrawLine(ccp(x,y+_radius), ccp(x+_halfWidth,y+_radius/2));
    ccDrawLine(ccp(x+_halfWidth,y+_radius/2),ccp(x+_halfWidth,y-_radius/2));
    ccDrawLine(ccp(x+_halfWidth,y-_radius/2),ccp(x,y-_radius));
    ccDrawLine(ccp(x,y-_radius),ccp(x-_halfWidth,y-_radius/2));
}

- (void)draw {
    glLineWidth(5.0f);
    glEnable(GL_LINE_SMOOTH);
                
    glColor4ub(0, 0, 0, 255);
    CGSize winSize = [CCDirector sharedDirector].winSize;
    [self drawHexAt:_position];
}

@end
