//
//  Coal.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Coal.h"


@implementation Coal

- (void)deplete:(TileEnergy*)energy {
    energy.scoreCoal-=2;
}

- (int)yield:(TileEnergy *)energy {
    return 0;
}

@end
