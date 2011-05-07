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
        self.baseYield = 20;
    }
    return self;
}

- (void)deplete:(TileEnergy*)energy {
    
}

- (int)yield:(TileEnergy *)energy environment:(Environment*)environment {
    return _baseYield + (_baseYield * environment.windForce / 100);
}

@end
