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

@synthesize sprite = _sprite;

+ (id)nodeWithRadius:(float)radius position:(HexPoint)position sprite:(CCSprite *)sprite{
    return [[[HexNode alloc] initWithRadius:radius position:position sprite:sprite] autorelease];
}

- (id)initWithRadius:(float)radius position:(HexPoint)position sprite:(CCSprite *)sprite{
    if ((self = [super init])) {
        self.radius = radius;
        self.height = 2 * _radius;
        self.rowHeight = 1.5f * _radius;
        self.halfWidth = (float)sqrt((_radius * _radius) - ((_radius / 2) * (_radius / 2)));
        self.width = 2 * _halfWidth;
        
        self.pos = position;
        self.sprite = sprite;
        _sprite.position = [self origin];
        _color = ccc4(0, 0, 0, 255);
    }
    return self;
}

- (CGPoint)origin {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGPoint p = ccp(winSize.width/2 + ((_position.x * _width) + ((_position.y % 2 == 0) ? 0 : _halfWidth)), //y % 2 == 0 is asking 'Is y even?'
                    winSize.height/2 + (_position.y * _rowHeight));
    return p;
}

- (void)randomizeColor {
    _color = ccc4(arc4random() % 256, arc4random() % 256, arc4random() % 256, 255);
}

- (void)drawHexAt:(CGPoint)origin {
    int x = origin.x;
    int y = origin.y;
    ccDrawLine(ccp(x-_halfWidth,y-_radius/2), ccp(x-_halfWidth,y+_radius/2));
    ccDrawLine(ccp(x-_halfWidth,y+_radius/2), ccp(x,y+_radius));
    ccDrawLine(ccp(x,y+_radius), ccp(x+_halfWidth,y+_radius/2));
    ccDrawLine(ccp(x+_halfWidth,y+_radius/2),ccp(x+_halfWidth,y-_radius/2));
    ccDrawLine(ccp(x+_halfWidth,y-_radius/2),ccp(x,y-_radius));
    ccDrawLine(ccp(x,y-_radius),ccp(x-_halfWidth,y-_radius/2));
}

- (BOOL)sameSide:(CGPoint)p1 p2:(CGPoint)p2 a:(CGPoint)a b:(CGPoint)b {
    CGFloat cp1 = ccpCross(ccpSub(b, a), ccpSub(p1, a));
    CGFloat cp2 = ccpCross(ccpSub(b, a), ccpSub(p2, a));
    return cp1 * cp2 >= 0;
}

- (BOOL)isTouchForMe:(CGPoint)touch {
    CGPoint origin = [self origin];
    int x = origin.x;
    int y = origin.y;
    if (![self sameSide:touch p2:origin a:ccp(x-_halfWidth,y-_radius/2) b:ccp(x-_halfWidth, y+_radius/2)]) {
        return NO;
    }
    if (![self sameSide:touch p2:origin a:ccp(x-_halfWidth,y+_radius/2) b:ccp(x,y+_radius)]) {
        return NO;
    }
    if (![self sameSide:touch p2:origin a:ccp(x,y+_radius) b:ccp(x+_halfWidth,y+_radius/2)]) {
        return NO;
    }
    if (![self sameSide:touch p2:origin a:ccp(x+_halfWidth,y+_radius/2) b:ccp(x+_halfWidth,y-_radius/2)]) {
        return NO;
    }
    if (![self sameSide:touch p2:origin a:ccp(x+_halfWidth,y-_radius/2) b:ccp(x,y-_radius)]) {
        return NO;
    }
    if (![self sameSide:touch p2:origin a:ccp(x,y-_radius) b:ccp(x-_halfWidth,y-_radius/2)]) {
        return NO;
    }
    return YES;
}

- (void)draw {
    glLineWidth(5.0f);
    glEnable(GL_LINE_SMOOTH);
                
    glColor4ub(_color.r, _color.g, _color.b, 255);
    [self drawHexAt:[self origin]];
}

- (void)dealloc {
    [_sprite release], _sprite = nil;
    [super dealloc];
}

@end
