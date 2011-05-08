//
//  TileEnergy.h
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "HexNode.h"

@class EnergyType;
@class Environment;

@interface TileEnergy : HexNode {
    int _scoreCoal;
    int _scoreOil;
    int _scoreGas;
    int _scoreNuclear;
    
    int _scoreWind;
    int _scoreSun;
    int _scoreGeo;
    int _scoreWater;
    
    EnergyType *_energy;
}

@property (nonatomic, assign) int scoreCoal;
@property (nonatomic, assign) int scoreOil;
@property (nonatomic, assign) int scoreGas;
@property (nonatomic, assign) int scoreNuclear;

@property (nonatomic, assign) int scoreWind;
@property (nonatomic, assign) int scoreSun;
@property (nonatomic, assign) int scoreGeo;
@property (nonatomic, assign) int scoreWater;

@property (nonatomic, retain) EnergyType *energy;

+ (id)tileWithRandomPropertiesAt:(HexPoint)point;
- (id)initWithRandomPropertiesAt:(HexPoint)point;

- (void)deplete;
- (int)yield:(Environment*)environment;

@end
