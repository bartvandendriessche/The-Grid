//
//  Water.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Water.h"


@implementation Water

- (id)init {
    if ((self = [super init])) {
        self.price = 600;
        self.baseYield = 50;
    }
    return self;
}

- (void)deplete:(TileEnergy*)energy {
    
}

- (int)yield:(TileEnergy *)energy environment:(Environment*)environment {
    return _baseYield;
}

@end
