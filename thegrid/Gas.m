//
//  Gas.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Gas.h"


@implementation Gas

- (id)init {
    if ((self = [super init])) {
        self.price = 200;
        self.baseYield = 50;
        self.sprite = [CCSprite spriteWithSpriteFrameName:@"energy_tile_overlay_gas.png"];
    }
    return self;
}

- (void)deplete:(TileEnergy*)energy {
    if (energy.scoreGas <= 0) return;
    energy.scoreGas -= 3;
    if (energy.scoreGas <= 0) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"powerdown.m4a"];
    }
}

- (int)yield:(TileEnergy *)energy environment:(Environment*)environment {
    if (energy.scoreGas <= 0) {
        CCLOG(@"No longer yielding energy from gas at %d,%d", energy.pos.x, energy.pos.y);
        return 0;
    }
    return _baseYield;
}

@end
