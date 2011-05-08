//
//  Sun.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Sun.h"


@implementation Sun

- (id)init {
    if ((self = [super init])) {
        self.price = 200;
        self.baseYield = 50;
        self.sprite = [CCSprite spriteWithSpriteFrameName:@"energy_tile_overlay_sun.png"];
    }
    return self;
}

- (void)deplete:(TileEnergy*)energy {
    
}

- (int)yield:(TileEnergy *)energy environment:(Environment*)environment {
    int yield = _baseYield + (_baseYield * (10-environment.cloudiness) / 10);
    return (environment.dayTime) ?  yield : yield / 5;
}

@end
