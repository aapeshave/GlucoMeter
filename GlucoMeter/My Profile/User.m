//
//  User.m
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/28/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import "User.h"

@implementation User

-(id)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName andEmail:(NSString *)email
           andUsername:(NSString *)username andPassword:(NSString *)password
          andBirthDate:(NSDate *)date andBloodGroup:(NSString *)bloodGrouop andAssignedDoctorUsername:(NSString *)doctorUserName{
    self = [super init];
    if(self){
        _firstName = firstName;
        _lastName = lastName;
        _email = email;
        _userName = username;
        _password = password;
        _birthDate = date;
        _bloodGroup = bloodGrouop;
        _assignedDoctorUsername = doctorUserName;
    }
    return self;
}

-(void) encodeWithCoder: (NSCoder *) coder{
    [coder encodeObject:_firstName forKey:@"firstName"];
    [coder encodeObject:_lastName forKey:@"lastName"];
    [coder encodeObject:_email forKey:@"email"];
    [coder encodeObject:_userName forKey:@"username"];
    [coder encodeObject:_password forKey:@"password"];
    [coder encodeObject:_birthDate forKey:@"birthDate"];
    [coder encodeObject:_bloodGroup forKey:@"bloodGroup"];
    [coder encodeObject:_assignedDoctorUsername forKey:@"assignedDoctor"];
}

- (id) initWithCoder: (NSCoder *) coder {
    NSString *firstName = [coder decodeObjectForKey:@"firstName"];
    NSString *lastName = [coder decodeObjectForKey:@"lastName"];
    NSString *email = [coder decodeObjectForKey:@"email"];
    NSString *username = [coder decodeObjectForKey:@"username"];
    NSString *password = [coder decodeObjectForKey:@"password"];
    NSDate *birthDate = [coder decodeObjectForKey:@"birthDate"];
    NSString *bloodGroup = [coder decodeObjectForKey:@"bloodGroup"];
    NSString *assignedDoctor = [coder decodeObjectForKey:@"assignedDoctor"];
    
    return [self initWithFirstName:firstName andLastName:lastName andEmail:email andUsername:username andPassword:password andBirthDate:birthDate andBloodGroup:bloodGroup andAssignedDoctorUsername:assignedDoctor];
}

@end
