//
//  MyProfileTableViewController.m
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/3/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import "MyProfileTableViewController.h"

@interface MyProfileTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lbl_ageValue;
@property (weak, nonatomic) IBOutlet UILabel *lbl_bloodType;
@property (weak, nonatomic) IBOutlet UILabel *lbl_heightValue;
@property (weak, nonatomic) IBOutlet UILabel *lbl_weightValue;

@end

@implementation MyProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setUpHealthStoreObject];
    
    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *writeDataTypes = [self dataTypesToWrite];
        NSSet *readDataTypes = [self dataTypesToRead];
        
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
                
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Permission Granted");
                // Update the user interface based on the current user's health information.
                [self updateLabelAge];
                [self updateBloodTypeLabel];
                [self updateUsersHeightLabel];
                [self updateUsersWeightLabel];
            });
        }];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
*/
#pragma mark - HealthKit Setup


#pragma mark - HealthKit Permissions

// Returns the types of data that Fit wishes to write to HealthKit.
- (NSSet *)dataTypesToWrite {
    HKQuantityType *dietaryCalorieEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
    HKQuantityType *activeEnergyBurnType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType *glucoseType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
    //HKCharacteristicType *bloodType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBloodType];
    return [NSSet setWithObjects:dietaryCalorieEnergyType, activeEnergyBurnType, heightType, weightType, glucoseType, nil];
}

// Returns the types of data that Fit wishes to read from HealthKit.
- (NSSet *)dataTypesToRead {
    HKQuantityType *dietaryCalorieEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
    HKQuantityType *activeEnergyBurnType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKCharacteristicType *birthdayType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    HKCharacteristicType *biologicalSexType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];
    HKCharacteristicType *bloodType = [HKCharacteristicType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBloodType];
    
    //HKCharacteristicType *bloodType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBloodType];
    HKQuantityType *glucoseType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
    return [NSSet setWithObjects:dietaryCalorieEnergyType, activeEnergyBurnType, heightType, weightType, birthdayType, biologicalSexType,glucoseType,bloodType,nil];
}

# pragma mark - Receiving Health Data

-(void)updateLabelAge{
    NSError *error;
    NSDate *dateOfBirth = [self.healthStore dateOfBirthWithError:&error];
    HKBloodTypeObject *bloodTypeObject = [self.healthStore bloodTypeWithError:&error];
    NSLog(@"%@",[bloodTypeObject description]);
    NSLog(@"%ld",(long)[bloodTypeObject bloodType]);
    
    if (!dateOfBirth) {
        NSLog(@"Either an error occured fetching the user's age information or none has been stored yet. In your app, try to handle this gracefully.");
        
        self.lbl_ageValue.text = NSLocalizedString(@"Not available", nil);
        NSLog(@"Error in retrieving birthdate");
    }
    else {
        // Compute the age of the user.
        NSDate *now = [NSDate date];
        
        NSDateComponents *ageComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:dateOfBirth toDate:now options:NSCalendarWrapComponents];
        
        NSUInteger usersAge = [ageComponents year];
        
        NSString *ageValue = [NSNumberFormatter localizedStringFromNumber:@(usersAge) numberStyle:NSNumberFormatterNoStyle];
        NSString *ageUnit = @" Years";
        self.lbl_ageValue.text = [ageValue stringByAppendingString:ageUnit];
    }
}

-(void)updateBloodTypeLabel{
    NSError *error;
    HKBloodTypeObject *bloodTypeObject = [self.healthStore bloodTypeWithError:&error];
    if(!bloodTypeObject){
        NSLog(@"Either an error occured fetching the user's blood group information or none has been stored yet.");
        
        self.lbl_bloodType.text = NSLocalizedString(@"Not available", nil);
        NSLog(@"Error in retrieving blood type");
    }
    else{
        NSString *bloodTypeString = [self getBloodTypeLiteral:bloodTypeObject];
        self.lbl_bloodType.text = bloodTypeString;
    }
}

-(void)updateUsersHeightLabel
{
    // Query to get the user's latest height, if it exists.
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];

    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:heightType predicate:nil limit:1 sortDescriptors:@[timeSortDescriptor]
        resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if(!results){
            NSLog(@"%s","Error in updating height");
        }
        else{
            HKUnit *heightUnit = [HKUnit inchUnit];
            HKQuantitySample *quantitySample = results.firstObject;
            HKQuantity *quantity = quantitySample.quantity;
            double usersHeight = [quantity doubleValueForUnit:heightUnit];
            NSLog(@"%f",usersHeight);
            NSString *heightUnitString = @" Feet";
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *heightStringFormatted = [NSNumberFormatter localizedStringFromNumber:@(usersHeight) numberStyle:NSNumberFormatterNoStyle];
                self.lbl_heightValue.text = [heightStringFormatted stringByAppendingString:heightUnitString];
            });
        }
    }];
    [self.healthStore executeQuery:query];
}


-(void)updateUsersWeightLabel
{
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];

    HKSampleQuery *query = [[HKSampleQuery alloc]initWithSampleType:weightType predicate:nil limit:1 sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if (!results) {
            NSLog(@"%s","Error in updating height");
        } else {
            HKUnit *bodyMassUnit = [HKUnit poundUnit];
            HKQuantitySample *quantitySample = results.firstObject;
            HKQuantity *quantity = quantitySample.quantity;
            double userWeight = [quantity doubleValueForUnit:bodyMassUnit];
            
            NSLog(@"%f",userWeight);
            NSString *weightUnitString = @" Pounds";
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *userWeightFormatted = [NSNumberFormatter localizedStringFromNumber:@(userWeight) numberStyle:NSNumberFormatterNoStyle];
                self.lbl_weightValue.text = [userWeightFormatted stringByAppendingString:weightUnitString];
            });
            
        }
    }];
    [self.healthStore executeQuery:query];
}

#pragma mark - Additional HealthKit Metohds

-(NSString *)getBloodTypeLiteral:(HKBloodTypeObject*)bloodTypeObject{
    NSString *bloodTypeString;
    long valueForEnum = [bloodTypeObject bloodType];
    switch (valueForEnum) {
        case 0:
            bloodTypeString = @"NA";
            break;
        case 1:
            bloodTypeString = @"A+";
            break;
        case 2:
            bloodTypeString = @"A-";
            break;
        case 3:
            bloodTypeString = @"B+";
            break;
        case 4:
            bloodTypeString = @"B-";
            break;
        case 5:
            bloodTypeString = @"AB+";
            break;
        case 6:
            bloodTypeString = @"AB-";
            break;
        case 7:
            bloodTypeString = @"A+";
            break;
        case 8:
            bloodTypeString = @"A-";
            break;
        default:
            break;
    }
    return bloodTypeString;
}

/*9
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
