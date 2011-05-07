//
//  Nuclear.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Nuclear.h"


@implementation Nuclear

- (void)deplete:(TileEnergy*)energy {
    energy.scoreNuclear-=1;
}

- (int)yield:(TileEnergy *)energy {
    return 0;
}

@end
