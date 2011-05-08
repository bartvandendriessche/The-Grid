//
//  Coal.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Coal.h"


@implementation Coal

- (id)init {
    if ((self = [super init])) {
        self.price = 100;
        self.baseYield = 40;
        self.sprite = [CCSprite spriteWithSpriteFrameName:@"energy_tile_overlay_coal.png"];
    }
    return self;
}

- (void)deplete:(TileEnergy*)energy {
    if (energy.scoreCoal <= 0) return;
    energy.scoreCoal-=2;
    if (energy.scoreCoal <= 0) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"powerdown.m4a"];
    }
}

- (int)yield:(TileEnergy *)energy environment:(Environment*)environment {
    if (energy.scoreCoal <= 0) {
        CCLOG(@"No longer yielding energy from coal at %d,%d", energy.pos.x, energy.pos.y);
        return 0;
    }
    return _baseYield;
}

@end
