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
#import "Environment.h"

#define DURATION_DAY 5
#define DURATION_NIGHT 5

@implementation GameScene

#pragma mark -
#pragma mark Initialization / Setup

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
        
        [self scheduleUpdate];
        
        _environment = [Environment environment];
        _dayNightCycleLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 128)];
        [self addChild:_dayNightCycleLayer z:2];
    }
    return self;
}

#pragma mark -
#pragma mark Sound
- (void)playNightTheme {
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"The Grid  Night fall.wav" loop:YES];
}

- (void)playDayTheme {
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"The Grid main theme day.wav" loop:YES];
}

#pragma mark - 
#pragma mark Gameloop
- (void)update:(ccTime)dt {
    CCLOG(@"Hey Bitzes, you require %d energy, and you're generating %d", [self requiredEnergy], [self yieldedEnergy]);
}

- (int)requiredEnergy {
    int total = 0;
    for (TileCity *c in _cityTiles) {
        [c requiredEnergy];
        total += [c requiredEnergy];
    }
    return total;
}

- (int)yieldedEnergy {
    int yielded = 0;
    for (TileEnergy *e in _energyTiles) {
        yielded += [e yield:_environment];
    }
    return yielded;
}

- (void)changeEnvironmentWindForce {
    int newForce = _environment.windForce + (arc4random() % 4) - 2;
    if (newForce < 1) newForce = 1;
    if (newForce > 10) newForce = 10;
    _environment.windForce = newForce;
}

- (void)switchEnvironmentToDay {
    _environment.dayTime = YES;
    [self changeEnvironmentWindForce];
}

- (void)switchEnvironmentToNight {
    _environment.dayTime = NO;
    [self changeEnvironmentWindForce];
}

- (CCFiniteTimeAction*)dayCycle {
    return [CCSequence actions:
            [CCFadeTo actionWithDuration:10 opacity:0],
            [CCCallFunc actionWithTarget:self selector:@selector(playDayTheme)],
            [CCCallFunc actionWithTarget:self selector:@selector(swithEnvironmentToDay)],
            [CCDelayTime actionWithDuration:DURATION_DAY],
            nil];
}

- (CCFiniteTimeAction*)nightCycle {
    return [CCSequence actions:
            [CCFadeTo actionWithDuration:10 opacity:128],
            [CCCallFunc actionWithTarget:self selector:@selector(playNightTheme)],
            [CCCallFunc actionWithTarget:self selector:@selector(swithEnvironmentToNight)],
            [CCDelayTime actionWithDuration:DURATION_NIGHT],
            nil];
}

- (void)startDayNightCycle {
    [_dayNightCycleLayer runAction:[CCRepeatForever actionWithAction:
                                    [CCSequence actions:
                                     [self dayCycle],
                                     [self nightCycle],
                                     nil]]];
}

#pragma mark -
#pragma mark Add game elements

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
    [self runAction:[CCSequence actions:
                     [CCCallFunc actionWithTarget:self selector:@selector(playNightTheme)],
                     [CCDelayTime actionWithDuration:DURATION_NIGHT],
                     [CCCallFunc actionWithTarget:self selector:@selector(startDayNightCycle)],
                     nil]];
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
    [_environment release], _environment = nil;
    [_cityTiles release], _cityTiles = nil;
    [_energyTiles release], _energyTiles = nil;
    [_hexNodes release], _hexNodes = nil;
    [super dealloc];
}

@end
