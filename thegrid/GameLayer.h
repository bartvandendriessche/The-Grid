//
//  GameLayer.h
//  thegrid
//
//  Created by Bart Vandendriessche on 06/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@class HexNode;

@interface GameLayer : CCLayerColor {
    NSMutableArray* _hexNodes;
}

+ (id)layer;
- (id)init;

- (void)addHexNode:(HexNode*)hexNode;

@end
