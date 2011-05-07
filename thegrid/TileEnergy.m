//
//  TileEnergy.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TileEnergy.h"


@implementation TileEnergy

@synthesize scoreCoal = _scoreCoal;
@synthesize scoreOil = _scoreOil;
@synthesize scoreGas = _scoreGas;
@synthesize scoreNuclear = _scoreNuclear;

@synthesize scoreWind = _scoreWind;
@synthesize scoreSun = _scoreSun;
@synthesize scoreGeo = _scoreGeo;
@synthesize scoreWater = _scoreWater;

+ (id)tileWithRandomPropertiesAt:(HexPoint)point {
    return [[[TileEnergy alloc] initWithRandomPropertiesAt:point]autorelease];
}

- (id)initWithRandomPropertiesAt:(HexPoint)point {
    if ((self = [super initWithRadius:40.0f position:point sprite:nil])) {
        self.scoreCoal = arc4random() % 11;
        self.scoreOil = arc4random() % 11;
        self.scoreGas = arc4random() % 11;
        self.scoreNuclear = arc4random() % 11;
        
        self.scoreWind = arc4random() % 11;
        self.scoreSun = arc4random() % 11;
        self.scoreGeo = arc4random() % 11;
        self.scoreWater = arc4random() % 11;
    }
    return self;
}

@end
