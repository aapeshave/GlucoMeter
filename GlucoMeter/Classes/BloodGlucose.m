//
//  BloodGlucose.m
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/27/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import "BloodGlucose.h"
#import <HealthKit/HealthKit.h>

@implementation BloodGlucose

- (NSString *)description {
    return [@{
              @"date": self.date,
              @"value": self.value
              } description];
}

-(id)initWithvalue:(NSString *)value andDate:(NSDate *)date{
    self = [super init];
    if (self) {
        _date = date;
        _value = value;
    }
    return self;
}


@end
