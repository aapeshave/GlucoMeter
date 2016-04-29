//
//  MyRemarksTableViewController.h
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/3/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>
#import "User.h"

@interface MyRemarksTableViewController : UITableViewController
@property (nonatomic) HKHealthStore *healthStore;
@property (nonatomic,retain) User *iPhoneUser;
@property (weak) NSDate *birthDate;
@property (weak) NSString *bloodGroup;
@end
