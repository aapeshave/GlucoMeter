//
//  MyRecordsTableViewController.h
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/3/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>
#import "BloodGlucose.h"

@interface MyRecordsTableViewController : UITableViewController
@property (nonatomic) HKHealthStore *healthStore;

@end
