//
//  Nuclear.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Nuclear.h"


@implementation Nuclear

- (id)init {
    if ((self = [super init])) {
        self.price = 400;
        self.baseYield = 60;
    }
    return self;
}

- (void)deplete:(TileEnergy*)energy {
    if (energy.scoreNuclear <= 0) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"powerdown.m4a"];
    }
    energy.scoreNuclear-=1;
    if (energy.scoreNuclear <= 0) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"powerdown.m4a"];
    }
}

- (int)yield:(TileEnergy *)energy environment:(Environment*)environment {
    if (energy.scoreNuclear <= 0) {
        CCLOG(@"No longer yielding energy from nuclear at %d,%d", energy.pos.x, energy.pos.y);
        return 0;
    }
    return _baseYield;
}

@end
