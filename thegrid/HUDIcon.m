//
//  HUDIcon.m
//  thegrid
//
//  Created by Wouter Martens on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HUDIcon.h"
#import "EnergyTypes.h"

@implementation HUDIcon

@synthesize type = _type;

+ (id)iconWithSpriteFrameName:(NSString*)name andType:(HUDIconType)iconType {
    return [[[HUDIcon alloc] initWithSpriteFrameName:name andType:iconType] autorelease];
}

- (id)initWithSpriteFrameName:(NSString*)name andType:(HUDIconType)iconType {
    if ((self = [super initWithSpriteFrameName:name])) {
        _type = iconType;
    }
    
    return self;
}

- (BOOL)isTouchForMe:(CGPoint)touchLocation {
	return CGRectContainsPoint([self boundingBox], touchLocation);
}

- (EnergyType*)energyType {
    switch (_type) {
        case kIconTypeBuildCoal:
            return [Coal energyType];
        case kIconTypeBuildOil:
            return [Oil energyType];
        case kIconTypeBuildGas:
            return [Gas energyType];
        case kIconTypeBuildNuclear:
            return [Nuclear energyType];
        case kIconTypeBuildWind:
            return [Wind energyType];
        case kIconTypeBuildWater:
            return [Water energyType];
        case kIconTypeBuildSun:
            return [Sun energyType];
        case kIconTypeBuildGeo:
            return [Geo energyType];
        default:
            return nil;
    }
}

- (NSString*)energyTypeDescription {
    switch (_type) {
        case kIconTypeBuildCoal:
            return @"Coal";
        case kIconTypeBuildOil:
            return @"Oil";
        case kIconTypeBuildGas:
            return @"Gas";
        case kIconTypeBuildNuclear:
            return @"Nuclear";
        case kIconTypeBuildWind:
            return @"Wind";
        case kIconTypeBuildWater:
            return @"Water";
        case kIconTypeBuildSun:
            return @"Sun";
        case kIconTypeBuildGeo:
            return @"Geo";
        default:
            return @"Unknown";
    }
}

@end
