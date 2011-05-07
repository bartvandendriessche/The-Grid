//
//  Environment.h
//  thegrid
//
//  Created by Bart Vandendriessche on 07/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Environment : NSObject {
    BOOL _dayTime;
    int _windForce;
}

@property (nonatomic,assign) BOOL dayTime;
@property (nonatomic,assign) int windForce;

+ (id)environment;

@end
