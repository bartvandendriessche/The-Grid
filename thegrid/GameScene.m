//
//  GameScene.m
//  thegrid
//
//  Created by Bart Vandendriessche on 06/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "GameLayer.h"
#import "HexNode.h"
#import "TileCity.h"
#import "TileEnergy.h"

@implementation GameScene

+ (id)scene {
    return [[[GameScene alloc] init] autorelease];
}

- (void)createCity {
    // make a center hex with 6 hexes around it
    [self addCityTile:[TileCity nodeWithRadius:40.0f position:HexPointMake(-1,0) sprite:nil]];
    [self addCityTile:[TileCity nodeWithRadius:40.0f position:HexPointMake(-1,-1) sprite:nil]];
    [self addCityTile:[TileCity nodeWithRadius:40.0f position:HexPointMake(0,0) sprite:nil]];
    [self addCityTile:[TileCity nodeWithRadius:40.0f position:HexPointMake(0,1) sprite:nil]];
    [self addCityTile:[TileCity nodeWithRadius:40.0f position:HexPointMake(0,-1) sprite:nil]];
    [self addCityTile:[TileCity nodeWithRadius:40.0f position:HexPointMake(1,0) sprite:nil]];
    [self addCityTile:[TileCity nodeWithRadius:40.0f position:HexPointMake(1,-1) sprite:nil]];
}

- (id)init {
    if ((self = [super init])) {
        _gameLayer = [GameLayer layer];
        [self addChild:_gameLayer z:1];
        [self createCity];
    }
    return self;
}

- (void)addHexNode:(HexNode*)hexNode {
    [_gameLayer addChild:hexNode];
    if (!_hexNodes) {
        _hexNodes = [[NSMutableArray alloc] init];
    }
    [_hexNodes addObject:hexNode];
}

- (void)addCityTile:(TileCity*)city {
    [self addHexNode:city];
    if (!_cityTiles) {
        _cityTiles = [[NSMutableArray alloc]init];
    }
    [_cityTiles addObject:city];
}

- (void)addEnergyTile:(TileEnergy*)energy {
    [self addHexNode:energy];
    if (!_energyTiles) {
        _energyTiles = [[NSMutableArray alloc]init];
    }
    [_energyTiles addObject:energy];
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

- (void)dealloc {
    [_gameLayer release], _gameLayer = nil;
    [_cityTiles release], _cityTiles = nil;
    [_energyTiles release], _energyTiles = nil;
    [_hexNodes release], _hexNodes = nil;
    [super dealloc];
}

@end
