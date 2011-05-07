//
//  EnergyType.h
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TileEnergy.h"

@interface EnergyType : NSObject {
    
}

- (void)deplete:(TileEnergy *)energy;
- (int)yield:(TileEnergy*)energy;

@end
