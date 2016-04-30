//
//  Remark.m
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/29/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import "Remark.h"

@implementation Remark




-(id)initWithRemarkID:(long)remarkID withRemarkString:(NSString *)remarkString withRemarkTitle:(NSString *)remarkTitle withPatientUsername:(NSString *)patientUserName withDoctorUsername:(NSString *)doctorUsername andWithAddtionalComments:(NSString *)additionalComments {
    self = [super init];
    if(self){
        _remarkID = remarkID;
        _remarkTitle = remarkTitle;
        _remarkString = remarkString;
        _patientUsername = patientUserName;
        _doctorUsername = doctorUsername;
        _additionalCommentsFromUser = additionalComments;
    }
    return self;
}
@end
