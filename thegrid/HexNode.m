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
@synthesize pos = _position;

+ (id)nodeWithRadius:(float)radius position:(HexPoint)position{
    return [[[HexNode alloc] initWithRadius:radius position:position] autorelease];
}

- (id)initWithRadius:(float)radius position:(HexPoint)position{
    if ((self = [super init])) {
        self.radius = radius;
        self.height = 2 * _radius;
        self.rowHeight = 1.5f * _radius;
        self.halfWidth = (float)sqrt((_radius * _radius) - ((_radius / 2) * (_radius / 2)));
        self.width = 2 * _halfWidth;
        
        self.pos = position;
    }
    return self;
}

- (CGPoint)origin:(HexPoint)hexPosition {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGPoint p = ccp(winSize.width/2 + ((hexPosition.x * _width) + ((hexPosition.y % 2 == 0) ? 0 : _halfWidth)), //y % 2 == 0 is asking 'Is y even?'
                    winSize.height/2 + (hexPosition.y * _rowHeight));
    return p;
}

- (CGPoint)tileCenter:(CGPoint) hexPosition {
    return ccpAdd(hexPosition, ccp(_halfWidth, _halfWidth));
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
    [self drawHexAt:[self origin:_position]];
}

@end
