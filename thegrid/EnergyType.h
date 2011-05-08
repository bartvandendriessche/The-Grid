//
//  EnergyType.h
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TileEnergy.h"
#import "Environment.h"
#import "SimpleAudioEngine.h"

@interface EnergyType : NSObject {
    int _price;
    int _baseYield;
    CCSprite *_sprite;
}

@property (nonatomic, assign)int price;
@property (nonatomic, assign)int baseYield;

@property (nonatomic, retain)CCSprite *sprite;

+ (id)energyType;

- (void)deplete:(TileEnergy *)energy;
- (int)yield:(TileEnergy *)energy environment:(Environment*)environment;

@end
