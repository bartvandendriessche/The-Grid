//
//  HUDLayer.h
//  thegrid
//
//  Created by Wouter Martens on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "HUDIcon.h"

@interface HUDLayer : CCLayer {
    NSMutableArray *_buildIcons;
    HUDIcon *_demolishIcon;
    CCSprite *_optionCircle;
    CCSprite *_money;
    CCSprite *_mayor;
    CCSprite *_energy;
    CCSprite *_people;
}

+ (id)layer;

- (id)init;
- (void)showOptionCircleOnPosition:(CGPoint)position forBuild:(BOOL)build;
- (void)hideOptionCircle;

@end
