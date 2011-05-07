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

+ (id)nodeWithRadius:(float)radius position:(HexPoint)position spriteName:(NSString *)spriteName {
    return [[[HexNode alloc] initWithRadius:radius position:position spriteName:spriteName] autorelease];
}

- (id)initWithRadius:(float)radius position:(HexPoint)position spriteName:(NSString *)spriteName {
    if ((self = [super init])) {
        self.radius = radius;
        self.height = 2 * _radius;
        self.rowHeight = 1.5f * _radius;
        self.halfWidth = (float)sqrt((_radius * _radius) - ((_radius / 2) * (_radius / 2)));
        self.width = 2 * _halfWidth;
        
        self.pos = position;
        
        self.sprite = [CCSprite spriteWithSpriteFrameName:spriteName];
        _sprite.position = [self origin];
        [self addChild:_sprite];
        
        _color = ccc4(0, 0, 0, 255);
        
        CGPoint origin = [self origin];
        int x = origin.x;
        int y = origin.y;

        _leftBottom = ccp(x-_radius/2,y-_halfWidth);
        _left = ccp(x-_radius,y);
        _leftTop = ccp(x-_radius/2,y+_halfWidth);
        _rightTop = ccp(x+_radius/2,y+_halfWidth);
        _right = ccp(x+_radius,y);
        _rightBottom = ccp(x+_radius/2,y-_halfWidth);
    }
    return self;
}

- (CGPoint)origin {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGPoint p = ccp(winSize.width/2 - _halfWidth + (_position.x * _rowHeight), // NOTE: the origin of the grid has an offset to make room for the HUDLayer!
                    winSize.height/2 + (_position.y * _width) + ((_position.x % 2 == 0) ? 0 : _halfWidth));

    return p;
}

- (void)randomizeColor {
    _color = ccc4(arc4random() % 256, arc4random() % 256, arc4random() % 256, 255);
}

- (void)drawHexAt:(CGPoint)origin {
    ccDrawLine(_leftBottom, _left);
    ccDrawLine(_left, _leftTop);
    ccDrawLine(_leftTop, _rightTop);
    ccDrawLine(_rightTop, _right);
    ccDrawLine(_right, _rightBottom);
    ccDrawLine(_rightBottom, _leftBottom);
}

- (BOOL)sameSide:(CGPoint)p1 p2:(CGPoint)p2 a:(CGPoint)a b:(CGPoint)b {
    CGFloat cp1 = ccpCross(ccpSub(b, a), ccpSub(p1, a));
    CGFloat cp2 = ccpCross(ccpSub(b, a), ccpSub(p2, a));
    return cp1 * cp2 >= 0;
}

- (BOOL)isTouchForMe:(CGPoint)touch {
    CGPoint origin = [self origin];
    if (![self sameSide:touch p2:origin a:_leftBottom b:_left]) {
        return NO;
    }
    if (![self sameSide:touch p2:origin a:_left b:_leftTop]) {
        return NO;
    }
    if (![self sameSide:touch p2:origin a:_leftTop b:_rightTop]) {
        return NO;
    }
    if (![self sameSide:touch p2:origin a:_rightTop b:_right]) {
        return NO;
    }
    if (![self sameSide:touch p2:origin a:_right b:_rightBottom]) {
        return NO;
    }
    if (![self sameSide:touch p2:origin a:_rightBottom b:_leftBottom]) {
        return NO;
    }
    return YES;
}

- (void)draw {
    glLineWidth(1.0f);
    glEnable(GL_LINE_SMOOTH);
                
    glColor4ub(_color.r, _color.g, _color.b, 255);
    [self drawHexAt:[self origin]];
}

- (void)dealloc {
    [_sprite release], _sprite = nil;
    [super dealloc];
}

@end
