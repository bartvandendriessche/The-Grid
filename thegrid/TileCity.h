//
//  TileCity.h
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HexNode.h"

@class Environment;

@interface TileCity : HexNode {
    
}

- (int)requiredEnergy:(Environment*)environment;

@end
