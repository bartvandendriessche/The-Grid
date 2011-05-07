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
    }
    return self;
}

- (void)deplete:(TileEnergy*)energy {
    energy.scoreCoal-=2;
}

- (int)yield:(TileEnergy *)energy environment:(Environment*)environment {
    return _baseYield;
}

@end
