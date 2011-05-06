//
//  GameLayer.m
//  thegrid
//
//  Created by Bart Vandendriessche on 06/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "HexNode.h"


@implementation GameLayer

+ (id)layer {
    return [[[GameLayer alloc] init] autorelease];
}

- (id)init {
    if ((self = [super initWithColor:ccc4(255, 255, 255, 255)])) {
        CCLOG(@"GameLayer initialized, DRAW SUM SHEPS !");
        [self addChild:[HexNode nodeWithRadius:40.0f position:HexPointMake(0,0)]];
        [self addChild:[HexNode nodeWithRadius:40.0f position:HexPointMake(0,1)]];
        [self addChild:[HexNode nodeWithRadius:40.0f position:HexPointMake(1,0)]];
        [self addChild:[HexNode nodeWithRadius:40.0f position:HexPointMake(1,-1)]];
    }
    return self;
}

@end
