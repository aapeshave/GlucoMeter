//
//  User.h
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/28/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic) long userID;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *password;
@property (nonatomic) NSDate *birthDate;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *bloodGroup;
@property (nonatomic) NSString *assignedDoctorUsername;

-(id)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName andEmail:(NSString *)email
           andUsername:(NSString *)username andPassword:(NSString *)password
          andBirthDate:(NSDate *)date andBloodGroup:(NSString *)bloodGrouop andAssignedDoctorUsername:(NSString *)doctorUserName;
@end
