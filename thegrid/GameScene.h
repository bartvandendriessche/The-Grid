//
//  GameScene.h
//  thegrid
//
//  Created by Bart Vandendriessche on 06/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@class GameLayer;
@class HexNode;
@class TileCity;
@class TileEnergy;
@class Environment;

@interface GameScene : CCScene<CCTargetedTouchDelegate> {
    GameLayer *_gameLayer;
    CCLayer *_dayNightCycleLayer;
    Environment *_environment;
    
    NSMutableArray* _hexNodes;
    NSMutableArray* _cityTiles;
    NSMutableArray* _energyTiles;
}

+ (id)scene;
- (id)init;

- (void)addHexNode:(HexNode*)hexNode;
- (void)addCityTile:(TileCity*)city;
- (void)addEnergyTile:(TileEnergy*)energy;

@end
