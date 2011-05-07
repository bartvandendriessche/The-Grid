//
//  Environment.m
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Environment.h"


@implementation Environment

@synthesize dayTime = _dayTime;
@synthesize windForce = _windForce;

+ (id)environment {
    return [[[Environment alloc] init] autorelease];
}

- (id)init {
    if((self = [super init])) {
        self.dayTime = false;
        self.windForce = (arc4random() % 10) + 1;
    }
    return self;
}

@end
