//
//  GameScene.m
//  thegrid
//
//  Created by Bart Vandendriessche on 06/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "GameLayer.h"
#import "HUDLayer.h"
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
    //CCSpriteBatchNode *spritesBatchNode = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"%@.pvr.ccz", name]];
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

- (NSMutableArray*)createSpareEnergyTiles {
    NSMutableArray *a = [[NSMutableArray alloc] init];
    //[a addObject:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(-1, 2)]];
    //[a addObject:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(1, 2)]];
    //[a addObject:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(-1, -3)]];
    //[a addObject:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(1, -3)]];
    
    [a addObject:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(2, 2)]];
    [a addObject:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(-2, 2)]];
    [a addObject:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(2, -2)]];
    [a addObject:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(-2, -2)]];
    
    [a addObject:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(-3, 1)]];
    [a addObject:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(-3, 0)]];
    [a addObject:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(-3, -1)]];
    [a addObject:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(-3, -2)]];
    [a addObject:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(3, 1)]];
    [a addObject:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(3, 0)]];
    [a addObject:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(3, -1)]];
    [a addObject:[TileEnergy tileWithRandomPropertiesAt:HexPointMake(3, -2)]];
    return [a autorelease];
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

- (void)preloadSounds {
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"win.m4a"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"lose.m4a"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"powerup.m4a"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"powerdown.m4a"];
}

- (void)unloadSounds {
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"win.m4a"];
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"lose.m4a"];
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"powerup.m4a"];
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"powerdown.m4a"];
}

- (id)init {
    if ((self = [super init])) {
        // load spriteSheets
        [self loadSpriteSheetWithName:@"tile-assets"];
        [self loadSpriteSheetWithName:@"icon-assets"];
        
        _gameLayer = [GameLayer layer];
        
        // load background
        CCSprite *background = [CCSprite spriteWithFile:@"Background.png"];
        background.position = ccp(512, 384);
        [_gameLayer addChild:background];
        
        [self addChild:_gameLayer z:0];
        [self createEnergyTiles];
        [self createCity];
        
        _environment = [[Environment environment] retain];
        _dayNightCycleLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 128)];
        [self addChild:_dayNightCycleLayer z:1];
        
        _hudLayer = [HUDLayer layer];
        [self addChild:_hudLayer z:2];
        _spareEnergyTiles = [[self createSpareEnergyTiles] retain];
        
        _chaos = 0;
        
        [self scheduleUpdate];
        [self schedule:@selector(hourTick:) interval:0.5];
    }
    return self;
}

#pragma mark -
#pragma mark Sound
- (void)playNightTheme {
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"nightfall.m4a" loop:YES];
}

- (void)playDayTheme {
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"daytime.m4a" loop:YES];
}

#pragma mark - 
#pragma mark Gameloop

- (void)pause {
    [self pauseSchedulerAndActions];
    [_dayNightCycleLayer pauseSchedulerAndActions];
}

- (void)resume {
    [self resumeSchedulerAndActions];
    [_dayNightCycleLayer resumeSchedulerAndActions];
}

- (void)updateMayorState {
    CCLOG(@"Update mayor state for %d", _chaos);
}

- (void)updateChaosState {
    int surplus = [self energySurplus];

    if (surplus == 0)return;
    
    if (surplus > 0) {
        _chaos--;
        if (_chaos < -5) {
            _chaos = -5;
        }
    }
    
    if (surplus < 0) {
        _chaos++;
    }
    
    [self updateMayorState];
    [self endGameIfNecessary];
}

- (void)updateTiles {
    for (TileEnergy *tile in _energyTiles) {
        [tile deplete];
    }
}

- (void)incrementTime {
    int nextHour = _environment.hour + 1;
    if (nextHour > 23) {
        nextHour = 0;
        _environment.day++;
    }
    _environment.hour = nextHour;
}

- (void)hourTick:(ccTime)dt {
    [self incrementTime];
    if (_environment.hour == 7) {
        [self startDay];
    }
    
    if (_environment.hour == 19) {
        [self startNight];
    }
    
    if ([_environment dayTime]) { // population grows during the day
        for (TileCity *c in _cityTiles) {            
            c.population += arc4random() % (2 + (_environment.day / 2));
        }
    }
    
    [self updateChaosState];
    [self updateTiles];
    CCLOG(@"It is now day %d, %d o'clock. You require %d energy, and you're generating %d", _environment.day, _environment.hour, [self requiredEnergy], [self yieldedEnergy]);
}

- (void)update:(ccTime)dt {
    //CCLOG(@"Hey Bitzes, you require %d energy, and you're generating %d", [self requiredEnergy], [self yieldedEnergy]);
}

- (int)requiredEnergy {
    int total = 0;
    CCLOG(@"Required energy during %@", ([_environment dayTime]) ? @"day" : @"night");
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

- (int)energySurplus {
    return [self yieldedEnergy] - [self requiredEnergy];
}

- (int)population {
    int population = 0;
    for (TileCity *city in _cityTiles) {
        population += city.population;
    }
    return population;
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
    [self changeEnvironmentWindForce];
}

- (void)switchEnvironmentToNight {
    [self changeEnvironmentWindForce];
}

- (CCFiniteTimeAction*)dayCycle {
    return [CCSequence actions:
            [CCFadeTo actionWithDuration:5 opacity:0],
            [CCCallFunc actionWithTarget:self selector:@selector(playDayTheme)],
            [CCCallFunc actionWithTarget:self selector:@selector(switchEnvironmentToDay)],
            nil];
}

- (CCFiniteTimeAction*)nightCycle {
    return [CCSequence actions:
            [CCFadeTo actionWithDuration:5 opacity:128],
            [CCCallFunc actionWithTarget:self selector:@selector(playNightTheme)],
            [CCCallFunc actionWithTarget:self selector:@selector(switchEnvironmentToNight)],
            nil];
}

- (void)startDay {
    [_dayNightCycleLayer runAction:[self dayCycle]];
}

- (void)endGameIfNecessary {
    if (!_environment.dayTime && _environment.day >= 10) {
        CCLOG(@"Congratulations! you made it to day 10");
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine] playEffect:@"win.m4a"];
        [self pause];
    }
    
    if(_chaos >= 8) {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine] playEffect:@"lose.m4a"];
        [self pause];
    }
}

- (void)startNight {
    [self endGameIfNecessary];
    [_dayNightCycleLayer runAction:[self nightCycle]];
}

- (void)startDayNightCycle {
    [_dayNightCycleLayer runAction:[CCRepeatForever actionWithAction:
                                    [CCSequence actions:
                                     [self dayCycle],
                                     [self nightCycle],
                                     nil]]];
}

- (void)addNewEnergyTileFromSpare {
    if (!_spareEnergyTiles || ![_spareEnergyTiles count]) {
        return;
    }
    TileEnergy *tile = [_spareEnergyTiles objectAtIndex:arc4random() % [_spareEnergyTiles count]];
    [self addEnergyTile:tile];
    [_spareEnergyTiles removeObject:tile];
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
                     //[CCDelayTime actionWithDuration:DURATION_NIGHT],
                     //[CCCallFunc actionWithTarget:self selector:@selector(startDayNightCycle)],
                     nil]];    
    _chaos = 0;
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
            //[h randomizeColor];
            
            if ([h isKindOfClass:[TileEnergy class]]) {
                [_hudLayer showOptionCircleForEnergyTile:(TileEnergy*)h];
            }
        }
    }
    
    BOOL tileAvailable = NO;
    for (TileEnergy *tile in _energyTiles) {
        if (tile.energy) {
            continue;
        }
        tileAvailable = YES;
    }
    
    if (!tileAvailable) {
        [self addNewEnergyTileFromSpare];
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
    [_spareEnergyTiles release], _spareEnergyTiles = nil;
    [_hexNodes release], _hexNodes = nil;
    [super dealloc];
}

@end
