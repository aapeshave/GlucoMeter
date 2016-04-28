//
//  MyRecordsTableViewController.m
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/3/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import "MyRecordsTableViewController.h"
#import "BloodGlucose.h"

@interface MyRecordsTableViewController ()

@property (nonatomic) NSMutableArray *bloodGlucoseArray;

@end

@implementation MyRecordsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bloodGlucoseArray = [NSMutableArray array];
    
    [self getBloodGlucoseLevels];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bloodGlucoseArray.count;
}


#pragma mark - Get Blood Glucose Level 

-(void)getBloodGlucoseLevels{
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    HKQuantityType *glcoseType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];

    HKSampleQuery *query = [[HKSampleQuery alloc]initWithSampleType:glcoseType predicate:nil limit:nil sortDescriptors:@[timeSortDescriptor] resultsHandler:
    ^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if (!results) {
            NSLog(@"An error occured fetching blood glucose Levels. The error was: %@.", error);
            abort();
        }
        dispatch_async(dispatch_get_main_queue(), ^{
//            for(HKQuantityType *someType in results ){
//                HKUnit *unitBloodGlucose = [HKUnit unitFromString:@"mg/dl"];
//                HKQuantitySample *quantitySample = results.firstObject;
//                HKQuantity *quantity = quantitySample.quantity;
//                double usersHeight = [quantity doubleValueForUnit:unitBloodGlucose];
//                NSLog(@"%f",usersHeight);
//    
//            }
            for(int i=0;i<results.count;i++){
                HKUnit *unitBloodGlucose = [HKUnit unitFromString:@"mg/dl"];
                HKQuantitySample *quantitySample = results[i];
                HKQuantity *quantity = quantitySample.quantity;
                NSDate *someDate  = quantitySample.startDate;
                double bloodGlucoseLevel = [quantity doubleValueForUnit:unitBloodGlucose];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                // US English Locale (en_US)
                //[dateFormatter setDateFormat:@"dd-MM-yyyy"];
                dateFormatter.dateStyle = NSDateFormatterMediumStyle;
                dateFormatter.timeStyle = NSDateFormatterNoStyle;
                dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
                NSLog(@"%f",bloodGlucoseLevel);
                NSLog(@"%@", [dateFormatter stringFromDate:someDate]);
                
                BloodGlucose *instance =[[BloodGlucose alloc]initWithvalue:bloodGlucoseLevel andDate:someDate];
                [self.bloodGlucoseArray addObject:instance];
                //NSLog(@"%@",someDate);
                [self.tableView reloadData];
            }
        });
    }
    ];
    
    [self.healthStore executeQuery:query];
    
//        HKQuantitySample *glucoseSample = [HKQuantitySample quantitySampleWithType:HKQuantityTypeIdentifierBloodGlucose quantity:(nonnull HKQuantity *) startDate:<#(nonnull NSDate *)#> endDate:<#(nonnull NSDate *)#>]
//    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"instanceCell" forIndexPath:indexPath];
    
    if(cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"instanceCell"];
    }
    
    BloodGlucose *instance = [self.bloodGlucoseArray objectAtIndex:indexPath.row];
    if(instance!=nil){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // US English Locale (en_US)
        //[dateFormatter setDateFormat:@"dd-MM-yyyy"];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        NSString *stringDate = [dateFormatter stringFromDate:instance.date];
        NSString *stringValue = [NSString stringWithFormat:@"%f",instance.value];
        cell.detailTextLabel.text = stringDate;
        cell.textLabel.text = stringValue;
    }
    return cell;
}


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
