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
#import "EnergyTypes.h"

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

- (void)createEnergyTiles {
    [self addEnergyTile:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(-2, 0)]];
    [self addEnergyTile:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(-2, 1)]];
    [self addEnergyTile:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(-1, 1)]];
    [self addEnergyTile:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(0, 2)]];
    [self addEnergyTile:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(1, 1)]];
    [self addEnergyTile:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(2, 1)]];
    [self addEnergyTile:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(2, 0)]];
    [self addEnergyTile:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(2, -1)]];
    [self addEnergyTile:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(1, -2)]];
    [self addEnergyTile:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(0, -2)]];
    [self addEnergyTile:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(-1, -2)]];
    [self addEnergyTile:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(-2, -1)]];
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
        
        [self addChild:_gameLayer z:0];
        [self createEnergyTiles];
        [self createCity];
        
        [self scheduleUpdate];
        
        _environment = [[Environment environment] retain];
        _dayNightCycleLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 128)];
        [self addChild:_dayNightCycleLayer z:1];
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
        total += [c requiredEnergy:_environment];
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
    int weight = 2;
    
    if (_environment.windForce <= 0) {
        weight = 0;
    }
    
    if (_environment.windForce >= 9) {
        weight = 4;
    }
    
    int newForce = _environment.windForce + (arc4random() % 4) - weight;
    if (newForce < 0) newForce = 0;
    if (newForce > 9) newForce = 9;
    _environment.windForce = newForce;
}

- (void)changeEnvironmentCloudiness {
    int weight = 2;
    
    if (_environment.cloudiness <= 0) {
        weight = 0;
    }
    
    if (_environment.cloudiness >= 9) {
        weight = 4;
    }
    
    int newCloudiness = _environment.cloudiness + (arc4random() % 4) - weight;
    if (newCloudiness < 0) newCloudiness = 0;
    if (newCloudiness > 9) newCloudiness = 9;
    _environment.cloudiness = newCloudiness;
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
            [CCCallFunc actionWithTarget:self selector:@selector(switchEnvironmentToDay)],
            [CCDelayTime actionWithDuration:DURATION_DAY],
            nil];
}

- (CCFiniteTimeAction*)nightCycle {
    return [CCSequence actions:
            [CCFadeTo actionWithDuration:10 opacity:128],
            [CCCallFunc actionWithTarget:self selector:@selector(playNightTheme)],
            [CCCallFunc actionWithTarget:self selector:@selector(switchEnvironmentToNight)],
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
    NSArray *energyTypes = [NSArray arrayWithObjects:
                            //[Coal class],
                            //[Oil class],
                            //[Gas class],
                            //[Nuclear class],
                            [Wind class],
                            //[Water class],
                            [Sun class],
                            //[Geo class],
                            nil];
    for (HexNode* h in _hexNodes) {
        if ([h isTouchForMe:[self convertTouchToNodeSpace:touch]]) {
            [h randomizeColor];
            CCLOG(@"Just touched the hex at %d, %d", h.pos.x, h.pos.y);
            if ([h isKindOfClass:[TileEnergy class]]) { 
                ((TileEnergy*)h).energy = [[energyTypes objectAtIndex:(arc4random() % [energyTypes count])] energyType];
                CCLOG(@"Just added %@ to this tile", [((TileEnergy*)h).energy class]);
            }
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
