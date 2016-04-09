//
//  HealthKitManager.h
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 3/26/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSHealthKitManager : NSObject

+ (GSHealthKitManager *)sharedManager;

- (void)requestAuthorization;

- (NSDate *)readBirthDate;
- (void)writeWeightSample:(CGFloat)weight;

@end