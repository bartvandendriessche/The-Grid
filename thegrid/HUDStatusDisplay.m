//
//  HUDStatusDisplay.m
//  thegrid
//
//  Created by Wouter Martens on 08/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HUDStatusDisplay.h"

@implementation HUDStatusDisplay

@synthesize label = _label;

- (id)initWithFile:(NSString *)filename {
    if ((self = [super initWithFile:filename])) {
        self.label = [CCLabelBMFont labelWithString:@"0" fntFile:@"freebooter-hd.fnt"];
        _label.scale = 0.7f;
        _label.color = ccc3(200, 188, 150);
        _label.position = ccp(self.contentSize.width / 2 + 30, self.contentSize.height / 2 - 10);
        [self addChild:_label];
    }
    
    return self;
}

@end
