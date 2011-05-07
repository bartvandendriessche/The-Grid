//
//  Gas.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Gas.h"


@implementation Gas

- (void)deplete:(TileEnergy*)energy {
    energy.scoreGas-=3;
}

- (int)yield:(TileEnergy *)energy {
    return 0;
}

@end
