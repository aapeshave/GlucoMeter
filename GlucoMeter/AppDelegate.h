//
//  AppDelegate.h
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 3/26/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic)HKHealthStore *healthStore;
@end

