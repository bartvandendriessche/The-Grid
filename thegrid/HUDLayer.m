//
//  HUDLayer.m
//  thegrid
//
//  Created by Wouter Martens on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"
#import "TileEnergy.h"

@implementation HUDLayer

@synthesize activeTile = _activeTile;

+ (id)layer {
    return [[[HUDLayer alloc] init] autorelease];
}

- (id)init {
    if ((self = [super init])) {
        CCLOG(@"GameLayer initialized, DRAW SUM SHEPS !");
        
        // Create sprite-icons
        HUDIcon *coalIcon = [HUDIcon iconWithSpriteFrameName:@"icon_coal.png" andType:kIconTypeBuildCoal];
        HUDIcon *oilIcon = [HUDIcon iconWithSpriteFrameName:@"icon_oil.png" andType:kIconTypeBuildOil];
        HUDIcon *gasIcon = [HUDIcon iconWithSpriteFrameName:@"icon_gas.png" andType:kIconTypeBuildGas];
        HUDIcon *nuclearIcon = [HUDIcon iconWithSpriteFrameName:@"icon_nuclear.png" andType:kIconTypeBuildNuclear];
        
        HUDIcon *windIcon = [HUDIcon iconWithSpriteFrameName:@"icon_wind.png" andType:kIconTypeBuildWind];
        HUDIcon *sunIcon = [HUDIcon iconWithSpriteFrameName:@"icon_sun.png" andType:kIconTypeBuildSun];
        HUDIcon *geoIcon = [HUDIcon iconWithSpriteFrameName:@"icon_geo.png" andType:kIconTypeBuildGeo];
        HUDIcon *waterIcon = [HUDIcon iconWithSpriteFrameName:@"icon_water.png" andType:kIconTypeBuildWater];
        
        _demolishIcon = [HUDIcon iconWithSpriteFrameName:@"icon_coal.png" andType:kIconTypeDemolish];
        
        // add build icons to array
        _buildIcons = [[NSMutableArray arrayWithObjects:coalIcon, oilIcon, nuclearIcon, gasIcon, sunIcon, waterIcon, windIcon, geoIcon, nil] retain];
        
        // load option circle
        _optionCircle = [CCSprite spriteWithFile:@"OptionWheel.png"];
        _optionCircle.scale = 0.5f;
        _optionCircle.visible = FALSE;
        [self addChild:_optionCircle];
        
        // load stats
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        _money = [HUDStatusDisplay spriteWithFile:@"hud_money.png"];
        _money.position = ccp(winSize.width - _money.contentSize.width / 2 - 20, winSize.height - _money.contentSize.height / 2 - 20);
        [self addChild:_money];
        
        _mayor = [HUDStatusDisplay spriteWithFile:@"hud_mayor.png"];
        _mayor.position = ccp(_money.position.x, _money.position.y - _money.contentSize.height / 2 - _mayor.contentSize.height / 2  - 10);
        [self addChild:_mayor];
        
        _energy = [HUDStatusDisplay spriteWithFile:@"hud_energy.png"];
        _energy.position = ccp(_mayor.position.x, _mayor.position.y - _mayor.contentSize.height / 2 - _energy.contentSize.height / 2  - 10);
        [self addChild:_energy];
        
        _people = [HUDStatusDisplay spriteWithFile:@"hud_people.png"];
        _people.position = ccp(_energy.position.x, _energy.position.y - _energy.contentSize.height / 2 - _people.contentSize.height / 2  - 10);
        [self addChild:_people];
        
        // add icons to the option circle
        for (int i = 0; i < [_buildIcons count]; i++) {
            HUDIcon *currentIcon = (HUDIcon*)[_buildIcons objectAtIndex:i];
            currentIcon.scale = 0.0f;
            currentIcon.position = ccp(cos(CC_DEGREES_TO_RADIANS(i * 45)) * 80 + _optionCircle.contentSize.width / 2, 
                                       sin(CC_DEGREES_TO_RADIANS(i * 45)) * 80 + _optionCircle.contentSize.height / 2);
            [_optionCircle addChild:currentIcon];
        }
    }
    return self;
}

- (void)showIcons {
    for (int i = 0; i < [_buildIcons count]; i++) {
        HUDIcon *currentIcon = (HUDIcon*)[_buildIcons objectAtIndex:i];
        [currentIcon runAction:[CCSequence actions: 
                                [CCScaleTo actionWithDuration:0.0f scale:0.0f],
                                [CCDelayTime actionWithDuration:(0.015f * i)],
                                [CCScaleTo actionWithDuration:0.2f scale:1.1f],
                                [CCScaleTo actionWithDuration:0.05f scale:1.0f],
                                nil]];
    }
}

- (void)hideIcons {
    for (int i = 0; i < [_buildIcons count]; i++) {
        HUDIcon *currentIcon = (HUDIcon*)[_buildIcons objectAtIndex:i];
        [currentIcon runAction:[CCScaleTo actionWithDuration:0.0f scale:0.0f]];
    }
}

- (void)showOptionCircleOnPosition:(CGPoint)position forBuild:(BOOL)build {
    CCSequence *sequence = [CCSequence actions:
                            [CCCallFunc actionWithTarget:self selector:@selector(hideIcons)],
                            [CCScaleTo actionWithDuration:0.0f scale:0.0f],
                            [CCMoveTo actionWithDuration:0.0f position:position],
                            [CCScaleTo actionWithDuration:0.2f scale:1.1f],
                            [CCCallFuncN actionWithTarget:self selector:@selector(showIcons)],
                            [CCScaleTo actionWithDuration:0.05f scale:1.0f],
                            nil];
    
    _optionCircle.visible = TRUE;
    [_optionCircle runAction:sequence];
}

- (void)showOptionCircleForEnergyTile:(TileEnergy*)tile {
    self.activeTile = tile;
    CCSequence *sequence = [CCSequence actions:
                            [CCCallFunc actionWithTarget:self selector:@selector(hideIcons)],
                            [CCScaleTo actionWithDuration:0.0f scale:0.0f],
                            [CCMoveTo actionWithDuration:0.0f position:tile.sprite.position],
                            [CCScaleTo actionWithDuration:0.2f scale:1.1f],
                            [CCCallFuncN actionWithTarget:self selector:@selector(showIcons)],
                            [CCScaleTo actionWithDuration:0.05f scale:1.0f],
                            nil];
    
    _optionCircle.visible = TRUE;
    [_optionCircle runAction:sequence];
}

- (void) dealloc {
    [_activeTile release], _activeTile = nil;
    [_buildIcons release], _buildIcons = nil;
    [super dealloc];
}

@end
