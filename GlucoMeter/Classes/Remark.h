//
//  Remark.h
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/29/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Remark : NSObject
@property (strong,retain) NSString *remarkString;
@property (strong,retain) NSString *remarkTitle;
@property (strong,retain) NSString *patientUsername;
@property (strong,retain) NSString *doctorUsername;
@property (strong,retain) NSString *additionalCommentsFromUser;
@property long remarkID;

-(id)initWithRemarkID:(long)remarkID withRemarkString:(NSString *)remarkString
      withRemarkTitle:(NSString *)remarkTitle withPatientUsername:(NSString *)patientUserName withDoctorUsername:(NSString *)doctorUsername andWithAddtionalComments:(NSString *)additionalComments;

@end
