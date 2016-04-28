//
//  AddRecords.m
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/28/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import "AddRecords.h"

@interface AddRecords ()
@property (weak, nonatomic) IBOutlet UILabel *lbl_currentRecord;
@property (weak, nonatomic) IBOutlet UITextField *textField_record;
@property (weak, nonatomic) IBOutlet UIButton *button_addRecord;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddRecords

@synthesize recordDateAndTime;

- (void)viewDidLoad {
    [super viewDidLoad];
    _datePicker.maximumDate = [NSDate date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getValueFromDatePicker:(id)sender {
    recordDateAndTime = _datePicker.date;
}

- (IBAction)addRecordIntoHealthStore:(id)sender {
    HKQuantityType *glucoseType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
    HKUnit *unitBloodGlucose = [HKUnit unitFromString:@"mg/dl"];
    double glucoseValue = [_textField_record.text doubleValue];
    HKQuantity *glucoseQty = [HKQuantity quantityWithUnit:unitBloodGlucose doubleValue:glucoseValue];
    HKQuantitySample *glucoseSample = [HKQuantitySample quantitySampleWithType:glucoseType quantity:glucoseQty startDate:recordDateAndTime endDate:recordDateAndTime];
    
    [self.healthStore saveObject:glucoseSample withCompletion:^(BOOL success, NSError * _Nullable error) {
        if(success){
            NSLog(@"Record Added Successfully");
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            NSLog(@"Error in adding object");
        }
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
