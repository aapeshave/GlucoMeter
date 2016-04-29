//
//  AddUserController.h
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/28/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface AddUserController : UITableViewController
@property(nonatomic,retain) User *currentUser;

-(void)createAlertWithMessage:(NSString *)message;
@end
