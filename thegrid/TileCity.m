//
//  TileCity.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TileCity.h"
#import "Environment.h"

@implementation TileCity

- (int)requiredEnergy:(Environment*)environment {
    int required = 35 + arc4random() % 10;
    return environment.dayTime ? required : required / 5;
}

@end
