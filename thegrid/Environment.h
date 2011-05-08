//
//  Environment.h
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Environment : NSObject {
    int _windForce;
    int _cloudiness;
    int _hour;
}

@property (nonatomic,assign) int windForce;
@property (nonatomic,assign) int cloudiness;
@property (nonatomic,assign) int hour;

+ (id)environment;

- (BOOL)dayTime;

@end
