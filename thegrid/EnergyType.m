//
//  EnergyType.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EnergyType.h"

@implementation EnergyType

@synthesize price = _price;
@synthesize baseYield = _baseYield;

@synthesize sprite = _sprite;

+ (id)energyType {
    return [[[self alloc] init] autorelease];
}

- (void)deplete:(TileEnergy *)energy {
    NSAssert(false,@"You need to subclass EnergyType");
}

- (int)yield:(TileEnergy *)energy environment:(Environment*)environment{
    NSAssert(false,@"You need to subclass EnergyType");
    return 0;
}

@end
