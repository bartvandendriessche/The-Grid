//
//  HUDLayer.h
//  thegrid
//
//  Created by Wouter Martens on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "HUDIcon.h"

@class TileEnergy;

@interface HUDLayer : CCLayer {
    NSMutableArray *_buildIcons;
    HUDIcon *_demolishIcon;
    CCSprite *_optionCircle;
    
    TileEnergy *_activeTile;
}

@property (nonatomic,retain) TileEnergy* activeTile;

+ (id)layer;

- (id)init;
- (void)showOptionCircleOnPosition:(CGPoint)position forBuild:(BOOL)build;
- (void)showOptionCircleForEnergyTile:(TileEnergy*)tile;
- (void)hideOptionCircle;

@end
