//
//  AddUserController.m
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/28/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import "AddUserController.h"

@interface AddUserController ()
@property (weak, nonatomic) IBOutlet UITextField *textField_firstName;
@property (weak, nonatomic) IBOutlet UITextField *textField_lastName;
@property (weak, nonatomic) IBOutlet UITextField *textField_userName;
@property (weak, nonatomic) IBOutlet UITextField *textField_password;
@property (weak, nonatomic) IBOutlet UIButton *btn_createUser;
@property (weak, nonatomic) IBOutlet UITextField *textField_email;
@property (weak, nonatomic) IBOutlet UITextField *textField_bloodGroup;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker_birthDate;

@property(weak,nonatomic) NSDate *birthDate;
@end

@implementation AddUserController
@synthesize currentUser;


- (void)viewDidLoad {
    [super viewDidLoad];
    _datePicker_birthDate.maximumDate = [NSDate date];
     _birthDate = _datePicker_birthDate.date;
    self.textField_bloodGroup.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)getBirthDate:(id)sender {
    _birthDate = _datePicker_birthDate.date;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)addUser:(id)sender {
    NSString *firstName = _textField_firstName.text;
    NSString *lastName = _textField_lastName.text;
    NSString *email = _textField_email.text;
    NSString *username = _textField_userName.text;
    NSString *password = _textField_password.text;
    NSString *bloodGroup = _textField_bloodGroup.text;
    
    
    if(0 != [firstName length] && 0 != [lastName length] && 0 != [email length] &&
       0 != [username length] && 0 != [password length]){
        NSURL *url = [NSURL URLWithString:@"http://localhost:8080/ios/adduser.htm"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        
        NSString* requestData = [NSString stringWithFormat:@"firstName=%@&lastName=%@&username=%@&password=%@&email=%@&bloodGroup=%@&birthDate=%@",firstName, lastName, username,password, email,bloodGroup,_birthDate];

        NSData *data = [requestData dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *error = nil;
        [request setHTTPBody:data];
        
        if (!error) {
            // 4
            NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                //NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                if(data){
                    NSArray  *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    if([result count]!=0){
                        NSLog(@"Creating User");
                        //New Thread to Save current User to the file
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            
//                            [currentUser setEmail:email];
//                            [currentUser setFirstName:firstName];
//                            [currentUser setLastName:lastName];
//                            [currentUser setUserName:username];
//                            [currentUser setPassword:password];
//                            [currentUser setBirthDate:_birthDate];
//                            
//                            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//                            NSString *documentsDirectoryPath = [paths objectAtIndex:0];
//                            NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"myuserInfo.plist"];
//                            
//                            //NSString *filePath = @"/Users/ajinkya/myData.plist";
//                            NSFileManager *fileManager =[[NSFileManager alloc]init];
//                            if([fileManager fileExistsAtPath: filePath]){
//                                [NSKeyedArchiver archiveRootObject: currentUser toFile:filePath];
//                                NSLog(@"SAving file");
//                            }
//                            
//                        });
//
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"User Added Successfully" preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                //NSLog(@"You pressed button OK");
                                [_btn_createUser setEnabled:NO];
                            }];
                            
                            [alert addAction:okAction];
                            [self presentViewController:alert animated:YES completion:nil];

                        });
                    }
                    else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"User Can no be Added Successfully" preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                //NSLog(@"You pressed button OK");
                            }];
                            
                            [alert addAction:okAction];
                            [self presentViewController:alert animated:YES completion:nil];
                        });
                    }
                }
            }];
            
            // 5
            [uploadTask resume];
        }
        
    }
    else{
        NSLog(@"Please fill all fields");
    }
    
}


-(void)createAlertWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                NSLog(@"You pressed button OK");
    }];
    
    [alert addAction:okAction];
    
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
