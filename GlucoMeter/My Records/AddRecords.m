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
    recordDateAndTime = _datePicker.date;

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
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"Record Added Successfully" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    //NSLog(@"You pressed button OK");
                }];
                
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
            });
        }
        else{
            //NSLog(@"Error in adding object");
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"We can not add your data. Please check healthKit permissions." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    //NSLog(@"You pressed button OK");
                }];
                
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
            });
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
