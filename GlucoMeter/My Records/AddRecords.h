//
//  AddRecords.h
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/28/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>

@interface AddRecords : UIViewController

@property (nonatomic,nonnull)NSDate *recordDateAndTime;
@property (nonatomic) HKHealthStore *healthStore;
@end
