//
//  Wind.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Wind.h"


@implementation Wind

- (id)init {
    if ((self = [super init])) {
        self.price = 400;
        self.baseYield = 25;
        self.sprite = [CCSprite spriteWithSpriteFrameName:@"energy_tile_overlay_wind.png"];
    }
    return self;
}

- (void)deplete:(TileEnergy*)energy {
    
}

- (int)yield:(TileEnergy *)energy environment:(Environment*)environment {
    int yield = _baseYield + (_baseYield * environment.windForce / 10);
    CCLOG(@"Yielding %d wind energy", yield);
    return yield;
}

@end
