//
//  LoginController.m
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/29/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()
@property (weak, nonatomic) IBOutlet UITextField *textField_username;
@property (weak, nonatomic) IBOutlet UITextField *textField_password;
@property (weak, nonatomic) IBOutlet UIButton *button_signIn;
@property(strong) NSMutableArray *object;
@end

@implementation LoginController
@synthesize loginInUser;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField_password.delegate = self;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button Action

- (IBAction)doLoginAction:(id)sender {
    NSString *username = _textField_username.text;
    NSString *password = _textField_password.text;
    
    if([username length]!=0 && [password length]!=0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self checkWithServerAboutLoginWithUsername:username andPassword:password];
            });
    }
    
    else{
       //Alert View Controller for Displaying Error
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warninng" message:@"Please Enter All Fields to login" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                //NSLog(@"You pressed button OK");
            }];
            
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }
}

-(void)checkWithServerAboutLoginWithUsername:(NSString *)username andPassword:(NSString *)password{
    NSLog(@"%@",username);
    NSLog(@"%@",password);
    
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
            if(data){
                _object =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSDictionary *info = _object[0];
                [loginInUser setUserName:[info objectForKey:@"username"]];
                [loginInUser setPassword:[info objectForKey:@"password"]];
                [loginInUser setEmail:[info objectForKey:@"email"]];
                
            }
        }];
        [uploadTask resume];
    }
    
}


#pragma mark - textField Method
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"loginSegue"]) {
        NSLog(@"Going Back");
    }
}



@end
