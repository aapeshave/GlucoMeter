//
//  MyRemarksTableViewController.m
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/3/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import "MyRemarksTableViewController.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#import <sys/socket.h>
#import <netinet/in.h> 
#import <arpa/inet.h> 
#import <netdb.h>
#import "AddUserController.h"
#import "RemarksTableViewController.h"


@interface MyRemarksTableViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button_createAccount;
@property (weak, nonatomic) IBOutlet UIButton *button_signIn;
@property (weak, nonatomic) IBOutlet UIButton *button_viewRemarks;
@property (strong) NSMutableArray *objects;
@property (nonatomic) BOOL networkFlag;

@end

@implementation MyRemarksTableViewController
@synthesize iPhoneUser;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_button_viewRemarks setEnabled:false];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self checkNetworkAvailability];
        [self sendSomeGetRequest];
        [self loadUserObject];
    });
    
    
    
    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadUserObject{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"myuserInfo.plist"];
    
    NSFileManager *fileManager =[[NSFileManager alloc]init];
    
    if([fileManager fileExistsAtPath: filePath]){
        iPhoneUser = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        NSLog(@"Loading Data from file");
        [_button_createAccount setEnabled:NO];
    }
    else{
        iPhoneUser = [[User alloc]init];
        NSLog(@"Creating a new user");
    }
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

- (IBAction)createAccount:(id)sender {
    NSLog(@"button clicked");
}

#pragma mark - checkNetworkAvailability

-(void)checkNetworkAvailability{
    _networkFlag = [self connectedToNetwork];
    NSLog(_networkFlag ? @"Yes" : @"No");
}

- (BOOL) connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
    return (isReachable && !needsConnection) ? YES : NO;
}

# pragma mark - HTTP GET Request Method

-(void)sendSomeGetRequest {
    if(_networkFlag){
        NSString *urlStr = @"http://localhost:8080/ios/checkConnection.htm";
        NSURL *url = [NSURL URLWithString:urlStr];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        
//        NSURLResponse *response;
//        NSError *error;
        
        
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        [sessionConfiguration setAllowsCellularAccess:YES];
        [sessionConfiguration setHTTPAdditionalHeaders:@{@"Accept":@"application/json"}];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
        }]resume];
        
        //NSData *responseData = [NSURLSession dataT]

    }
}
- (IBAction)loginAction:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Log In"
                                      message:@"Enter User Credentials"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       //Do Some action here
                                                       NSString *username = alert.textFields[0].text;
                                                       NSString *password = alert.textFields[1].text;
                                                       if ([username length]!=0 && [password length]!=0) {
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               [self checkWithServerAboutLoginWithUsername:username andPassword:password];
                                                           });
                                                       }
                                                   }];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                                       }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textFieldUsername) {
            textFieldUsername.placeholder = @"Username";
        }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textFieldPassword) {
            textFieldPassword.placeholder = @"Password";
            textFieldPassword.secureTextEntry = YES;
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
    });
}


#pragma mark - viewRemarksAction
- (IBAction)viewRemarksAction:(id)sender {
}

/*
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
#pragma mark - login Code

-(void)checkWithServerAboutLoginWithUsername:(NSString *)username andPassword:(NSString *)password{
    //NSLog(@"%@",username);
    //NSLog(@"%@",password);
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/ios/loginUser.htm"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    
    NSString* requestData = [NSString stringWithFormat:@"username=%@&password=%@",username, password];
    
    NSData *data = [requestData dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    [request setHTTPBody:data];
    
    if(!error){
        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(data!=nil){
                _objects =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSDictionary *info = _objects[0];
                if(info){
                    [iPhoneUser setUserName:[info objectForKey:@"username"]];
                    [iPhoneUser setPassword:[info objectForKey:@"password"]];
                    [iPhoneUser setEmail:[info objectForKey:@"email"]];
                    [iPhoneUser setAssignedDoctorUsername:[info objectForKey:@"assignedDoctorName"]];
                    [_button_viewRemarks setEnabled:true];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"Log In Successfull" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                            //NSLog(@"You pressed button OK");
                        }];
                        
                        [alert addAction:okAction];
                        [self presentViewController:alert animated:YES completion:nil];
                    });
                }
                else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Your Credentials Do Not Match" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                            //NSLog(@"You pressed button OK");
                        }];
                        
                        [alert addAction:okAction];
                        [self presentViewController:alert animated:YES completion:nil];
                    });
                }
                
            }
        }];
        [uploadTask resume];
    }
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"createUserSegue"]) {
        AddUserController *destination = segue.destinationViewController;
        destination.currentUser = iPhoneUser;
    }
    if ([segue.identifier isEqualToString:@"viewRemarksSegue"]) {
        RemarksTableViewController *destination = segue.destinationViewController;
        destination.username = [iPhoneUser userName];
        destination.doctorUsername = [iPhoneUser assignedDoctorUsername];
    }
}




@end
