//
//  RemarkViewController.m
//  GlucoMeter
//
//  Created by Ajinkya Peshave on 4/29/16.
//  Copyright © 2016 Ajinkya Peshave. All rights reserved.
//

#import "RemarkViewController.h"

@interface RemarkViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UITextView *textViewDetail;

@end

@implementation RemarkViewController
@synthesize detailedRemark;

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%@",[detailedRemark remarkTitle]);
    _lbl_title.text = [detailedRemark remarkTitle];
    _textViewDetail.text = [detailedRemark remarkString];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
