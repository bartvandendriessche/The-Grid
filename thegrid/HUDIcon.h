//
//  HUDIcon.h
//  thegrid
//
//  Created by Wouter Martens on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCSprite.h"

typedef enum {
    kIconTypeBuildCoal,
    kIconTypeBuildOil,
    kIconTypeBuildGas,
    kIconTypeBuildNuclear,
    
    kIconTypeBuildWind,
    kIconTypeBuildSun,
    kIconTypeBuildGeo,
    kIconTypeBuildWater,
    
    kIconTypeDemolish,
    
    kIconTypeUnknown = -1
} HUDIconType;

@interface HUDIcon : CCSprite {
    HUDIconType _type;
}

@property (nonatomic, readonly) HUDIconType type;

+ (id)iconWithSpriteFrameName:(NSString*)name andType:(HUDIconType)iconType;

- (id)initWithSpriteFrameName:(NSString*)name andType:(HUDIconType)iconType;
- (BOOL)isTouchForMe:(CGPoint)touchLocation;
- (NSString*)energyTypeDescription;

@end
