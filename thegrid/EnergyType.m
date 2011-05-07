//
//  EnergyType.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EnergyType.h"

@implementation EnergyType

- (void)deplete:(TileEnergy *)energy {
    NSAssert(false,@"You need to subclass EnergyType");
}

- (int)yield:(TileEnergy *)energy {
    NSAssert(false,@"You need to subclass EnergyType");
    return 0;
}

@end
