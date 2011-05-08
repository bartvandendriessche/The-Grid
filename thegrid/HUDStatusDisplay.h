//
//  HUDStatusDisplay.h
//  thegrid
//
//  Created by Wouter Martens on 08/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface HUDStatusDisplay : CCSprite {
    CCLabelBMFont *_label;
}

@property (nonatomic, assign) CCLabelBMFont *label;

@end
