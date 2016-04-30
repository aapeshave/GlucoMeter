//
//  RemarksTableViewController.m
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/29/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import "RemarksTableViewController.h"
#import "RemarkViewController.h"
#import "Remark.h"

@interface RemarksTableViewController ()

@property int noData;
@end

@implementation RemarksTableViewController
@synthesize username,doctorUsername,objects;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",username);
    NSLog(@"%@",doctorUsername);
    
    _noData=1;
    
        [self getRemarksFromServerByUsername:username];
        [self.tableView reloadData];
    
    //[self.tableView reloadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
   [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myCell"];
    }
    
    if(objects.count==0){
        cell.textLabel.text = @"Empty";
        cell.detailTextLabel.text =@"No Data";
    }
    else{
        NSDictionary *info = [objects objectAtIndex:indexPath.row];
        cell.autoresizesSubviews = true;
        cell.textLabel.text = [info objectForKey:@"remarkTitle"];
        cell.detailTextLabel.text = [info objectForKey:@"doctorUsername"];
    }
    return cell;
}


#pragma mark - get Remarks From Server

-(void) getRemarksFromServerByUsername:(NSString *)patientUusername {
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/ios/getRemarkList.htm"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    
    NSString* requestData = [NSString stringWithFormat:@"username=%@",patientUusername];
    
    NSData *data = [requestData dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    [request setHTTPBody:data];
    
    if(!error){
        NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            objects =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [self.tableView reloadData];
        } ];
        [self.tableView reloadData];
        [task resume];
    }
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailedRemarkSegue"]) {
        RemarkViewController *destination = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = objects[indexPath.row];
        Remark *someRemark = [[Remark alloc]init];
        someRemark.remarkTitle = [object objectForKey:@"remarkTitle"];
        someRemark.remarkString = [object objectForKey:@"remarkString"];
        someRemark.doctorUsername = [object objectForKey:@"doctorUsername"];
        someRemark.additionalCommentsFromUser = [object objectForKey:@"additionalCommentsFromUser"];
        destination.detailedRemark = someRemark;
        //AddUserContoller *destination = segue.destinationViewController;
        //destination.currentUser = iPhoneUser;
    }
}


@end
