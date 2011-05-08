//
//  HUDLayer.h
//  thegrid
//
//  Created by Wouter Martens on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "HUDIcon.h"
#import "HUDStatusDisplay.h"

@class TileEnergy;

@interface HUDLayer : CCLayer {
    NSMutableArray *_buildIcons;
    HUDIcon *_demolishIcon;
    TileEnergy *_activeTile;
    HUDStatusDisplay *_money;
    HUDStatusDisplay *_mayor;
    HUDStatusDisplay *_energy;
    HUDStatusDisplay *_people;
    CCSprite *_optionCircle;
}

@property (nonatomic,retain) TileEnergy* activeTile;

+ (id)layer;

- (id)init;
- (void)showOptionCircleOnPosition:(CGPoint)position forBuild:(BOOL)build;
- (void)showOptionCircleForEnergyTile:(TileEnergy*)tile;
- (void)hideOptionCircle;

@end
