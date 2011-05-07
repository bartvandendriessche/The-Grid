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
    energy.scoreNuclear-=1;
}

- (int)yield:(TileEnergy *)energy environment:(Environment*)environment {
    return _baseYield;
}

@end
