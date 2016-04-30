//
//  BloodGlucose.h
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/27/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

@interface BloodGlucose : NSObject

@property(nonatomic) NSString  *value;
@property(nonatomic) NSDate *date;

-(id)initWithvalue:(NSString *)value andDate:(NSDate *)date;

@end
