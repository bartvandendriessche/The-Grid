//
//  GameScene.m
//  thegrid
//
//  Created by Bart Vandendriessche on 06/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "GameLayer.h"

@implementation GameScene

+ (id)scene {
    return [[[GameScene alloc] init] autorelease];
}

- (id)init {
    if ((self = [super init])) {
        CCLOG(@"TAZ DINGO");
        [self addChild:[GameLayer layer]];
    }
    return self;
}

@end
