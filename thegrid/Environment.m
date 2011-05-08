//
//  Environment.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Environment.h"


@implementation Environment

@synthesize hour = _hour;
@synthesize windForce = _windForce;
@synthesize cloudiness = _cloudiness;

+ (id)environment {
    return [[[Environment alloc] init] autorelease];
}

- (id)init {
    if((self = [super init])) {
        self.hour = 20;
        self.windForce = (arc4random() % 10);
        self.cloudiness = (arc4random() % 10);
    }
    return self;
}

- (BOOL)dayTime {
    return 7 <= _hour && _hour <= 19;
}

@end
