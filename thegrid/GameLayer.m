//
//  GameLayer.m
//  thegrid
//
//  Created by Bart Vandendriessche on 06/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "HexNode.h"


@implementation GameLayer

+ (id)layer {
    return [[[GameLayer alloc] init] autorelease];
}

- (id)init {
    if ((self = [super initWithColor:ccc4(255, 255, 255, 255)])) {
        CCLOG(@"GameLayer initialized, DRAW SUM SHEPS !");
        
        // make a center hex with 6 hexes around it        
//        [self addHexNode:[HexNode nodeWithRadius:40.0f position:HexPointMake(0,0) sprite:nil]];
//        [self addHexNode:[HexNode nodeWithRadius:40.0f position:HexPointMake(0,1) sprite:nil]];
//        [self addHexNode:[HexNode nodeWithRadius:40.0f position:HexPointMake(1,0) sprite:nil]];
//        [self addHexNode:[HexNode nodeWithRadius:40.0f position:HexPointMake(-1,1) sprite:nil]];
//        [self addHexNode:[HexNode nodeWithRadius:40.0f position:HexPointMake(0,-1) sprite:nil]];
//        [self addHexNode:[HexNode nodeWithRadius:40.0f position:HexPointMake(-1,0) sprite:nil]];
//        [self addHexNode:[HexNode nodeWithRadius:40.0f position:HexPointMake(-1,-1) sprite:nil]];
        [self makeGrid:2];
    }
    return self;
}

- (void)makeGrid:(int)depth {
    //1 7 19 -- depth + ((depth-1) * 6)

        for (int x = -depth+1; x < depth; x++) {
            for (int y = -depth+1; y < depth; y++) {
                if (x < 0 && abs(x) >= abs(y) && abs(x) + abs(y) >= depth+1) {
                    continue;
                }                
                
                if (x > 0 && abs(x) + abs(y) >= depth+1) {
                    continue;
                }
                
                if (x > 0 && x > abs(y) && abs(x) + abs(y) >= depth) {
                    continue;
                }
                [self addHexNode:[HexNode nodeWithRadius:40.0f position:HexPointMake(x, y) sprite:nil]];
            }
        }

}

- (void)addHexNode:(HexNode*)hexNode {
    [self addChild:hexNode];
    if (!_hexNodes) {
        _hexNodes = [[NSMutableArray alloc] init];
    }
    [_hexNodes addObject:hexNode];
}

#pragma mark -
#pragma mark Overridden methods
- (void)onEnter {
    [super onEnter];
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:NO];
}

- (void)onExit {
    [super onExit];
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
}

#pragma mark -
#pragma mark CCTargetedTouchDelegate
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    for (HexNode* h in _hexNodes) {
        if ([h isTouchForMe:[self convertTouchToNodeSpace:touch]]) {
            [h randomizeColor];
            CCLOG(@"Just touched the hex at %d, %d", h.pos.x, h.pos.y);
        }
    }
    return YES;
}

// touch updates:
- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [_hexNodes release], _hexNodes = nil;
    [super dealloc];
}

@end
