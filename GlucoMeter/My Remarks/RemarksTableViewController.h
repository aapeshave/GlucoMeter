//
//  RemarksTableViewController.h
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/29/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemarksTableViewController : UITableViewController
@property (strong) NSString *username;
@property (strong) NSString *doctorUsername;
@property Boolean networkFlag;
@property (strong,readwrite) NSMutableArray *objects;
@end
