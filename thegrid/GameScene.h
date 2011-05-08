//
//  GameScene.h
//  thegrid
//
//  Created by Bart Vandendriessche on 06/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@class GameLayer;
@class HUDLayer;
@class HexNode;
@class TileCity;
@class TileEnergy;
@class Environment;

@interface GameScene : CCScene<CCTargetedTouchDelegate> {
    GameLayer *_gameLayer;
    HUDLayer *_hudLayer;
    CCLayer *_dayNightCycleLayer;
    Environment *_environment;
    
    NSMutableArray* _hexNodes;
    NSMutableArray* _cityTiles;
    NSMutableArray* _energyTiles;
    
    NSMutableArray* _spareEnergyTiles;
    
    int _chaos;
}

+ (id)scene;
- (id)init;

- (void)addHexNode:(HexNode*)hexNode;
- (void)addCityTile:(TileCity*)city;
- (void)addEnergyTile:(TileEnergy*)energy;
- (void)startDay;
- (void)startNight;

- (int)energySurplus;
- (int)requiredEnergy;
- (int)yieldedEnergy;
- (void)updateMayorState;

- (void)pause;
- (void)resume;

@end
