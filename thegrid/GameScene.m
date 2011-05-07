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
#import "SimpleAudioEngine.h"

@implementation GameScene

+ (id)scene {
    return [[[GameScene alloc] init] autorelease];
}

- (void)loadSpriteSheetWithName:(NSString*)name {
    CCSpriteBatchNode *spritesBatchNode = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"%@.pvr.ccz", name]];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist", name]];
}

- (void)createCity {
    // make a center hex with 6 hexes around it
    [self addCityTile:[TileCity nodeWithRadius:74.0f position:HexPointMake(-1,0) spriteName:@"city_tile_background.png"]];
    [self addCityTile:[TileCity nodeWithRadius:74.0f position:HexPointMake(-1,-1) spriteName:@"city_tile_background.png"]];
    [self addCityTile:[TileCity nodeWithRadius:74.0f position:HexPointMake(0,0) spriteName:@"city_tile_background.png"]];
    [self addCityTile:[TileCity nodeWithRadius:74.0f position:HexPointMake(0,1) spriteName:@"city_tile_background.png"]];
    [self addCityTile:[TileCity nodeWithRadius:74.0f position:HexPointMake(0,-1) spriteName:@"city_tile_background.png"]];
    [self addCityTile:[TileCity nodeWithRadius:74.0f position:HexPointMake(1,0) spriteName:@"city_tile_background.png"]];
    [self addCityTile:[TileCity nodeWithRadius:74.0f position:HexPointMake(1,-1) spriteName:@"city_tile_background.png"]];
}

- (id)init {
    if ((self = [super init])) {
        // load spriteSheets
        [self loadSpriteSheetWithName:@"tile-assets"];
        
        _gameLayer = [GameLayer layer];
        
        // load background
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        background.position = ccp(512, 384);
        [_gameLayer addChild:background];
        
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
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"The Grid  Night fall.wav" loop:YES];
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
