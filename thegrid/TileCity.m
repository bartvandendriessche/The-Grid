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

@synthesize population = _population;

- (id)initWithRadius:(float)radius position:(HexPoint)position spriteName:(NSString *)spriteName {
    if ((self = [super initWithRadius:radius position:position spriteName:spriteName])) {
        _population = 0;
        self.overlay = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"city_tile_overlay_%i.png", arc4random() % 6]];
        _overlay.position = ccp(self.sprite.position.x, self.sprite.position.y + 20);
        [self addChild:_overlay];
    }
    return self;
}

- (int)requiredEnergy:(Environment*)environment {
    int required = _population + ((_population / 10) * (arc4random() % 10));
    
    return ([environment dayTime]) ? required : required / 4;
}

@end
