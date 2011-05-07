//
//  Oil.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Oil.h"


@implementation Oil

- (void)deplete:(TileEnergy*)energy {
    energy.scoreOil -= 4;
}

- (int)yield:(TileEnergy *)energy {
    return 0;
}

@end
