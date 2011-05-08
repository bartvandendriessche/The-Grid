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
    
    BOOL _handlingTouches;
}

@property (nonatomic,retain) TileEnergy* activeTile;
+ (id)layer;

- (id)init;
- (void)showOptionCircleForEnergyTile:(TileEnergy*)tile;

@end
