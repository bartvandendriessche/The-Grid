//
//  Geo.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Geo.h"


@implementation Geo

- (id)init {
    if ((self = [super init])) {
        self.price = 800;
        self.baseYield = 40;
        self.sprite = [CCSprite spriteWithSpriteFrameName:@"energy_tile_overlay_geo.png"];
    }
    return self;
}

- (void)deplete:(TileEnergy*)energy {
    
}

- (int)yield:(TileEnergy *)energy environment:(Environment*)environment {
    return _baseYield;
}

@end
