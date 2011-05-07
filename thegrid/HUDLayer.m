//
//  HUDLayer.m
//  thegrid
//
//  Created by Wouter Martens on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"

@implementation HUDLayer

+ (id)layer {
    return [[[HUDLayer alloc] init] autorelease];
}

- (id)init {
    if ((self = [super init])) {
        CCLOG(@"GameLayer initialized, DRAW SUM SHEPS !");
        
        // Create sprite-icons
        HUDIcon *coalIcon = [HUDIcon iconWithSpriteFrameName:@"" andType:kIconTypeBuildCoal];
        HUDIcon *oilIcon = [HUDIcon iconWithSpriteFrameName:@"" andType:kIconTypeBuildOil];
        HUDIcon *gasIcon = [HUDIcon iconWithSpriteFrameName:@"" andType:kIconTypeBuildGas];
        HUDIcon *nuclearIcon = [HUDIcon iconWithSpriteFrameName:@"" andType:kIconTypeBuildNuclear];
        
        HUDIcon *windIcon = [HUDIcon iconWithSpriteFrameName:@"" andType:kIconTypeBuildWind];
        HUDIcon *sunIcon = [HUDIcon iconWithSpriteFrameName:@"" andType:kIconTypeBuildSun];
        HUDIcon *geoIcon = [HUDIcon iconWithSpriteFrameName:@"" andType:kIconTypeBuildGeo];
        HUDIcon *waterIcon = [HUDIcon iconWithSpriteFrameName:@"" andType:kIconTypeBuildWater];
        
        _demolishIcon = [HUDIcon iconWithSpriteFrameName:@"" andType:kIconTypeDemolish];
        
        // add build icons to array
        [_buildIcons addObject:coalIcon];
        [_buildIcons addObject:oilIcon];
        [_buildIcons addObject:gasIcon];
        [_buildIcons addObject:nuclearIcon];
        [_buildIcons addObject:windIcon];
        [_buildIcons addObject:sunIcon];
        [_buildIcons addObject:geoIcon];
        [_buildIcons addObject:waterIcon];
    }
    return self;
}

@end
