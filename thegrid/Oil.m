//
//  Oil.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Oil.h"


@implementation Oil

- (id)init {
    if ((self = [super init])) {
        self.price = 300;
        self.baseYield = 50;
    }
    return self;
}

- (void)deplete:(TileEnergy*)energy {
    if (energy.scoreOil <= 0) return;
    energy.scoreOil -= 4;
    if (energy.scoreOil <= 0) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"powerdown.m4a"];
    }
}

- (int)yield:(TileEnergy *)energy environment:(Environment*)environment {
    if (!energy.scoreOil <= 0) {
        CCLOG(@"No longer yielding energy from oil at %d,%d", energy.pos.x, energy.pos.y);
        return 0;
    }
    return _baseYield;
}

@end
