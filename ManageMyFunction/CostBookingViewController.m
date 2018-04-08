//
//  CostBookingViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 8/29/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "CostBookingViewController.h"
#import "ConfirmViewController.h"
@interface CostBookingViewController ()

@end

@implementation CostBookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_editCommentBtn setEnabled:NO];
    // Do any additional setup after loading the view.
    _proceedBtn.layer.borderWidth = 1;
    _proceedBtn.layer.borderColor = [[UIColor cyanColor] CGColor];
    _proceedBtn.layer.cornerRadius = 5;
    _proceedBtn.clipsToBounds = YES;
    
    _cancelBtn.layer.borderWidth = 1;
    _cancelBtn.layer.borderColor = [[UIColor cyanColor] CGColor];
    _cancelBtn.layer.cornerRadius = 5;
    _cancelBtn.clipsToBounds = YES;
    
    self.start_date.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"startdate"];//storing for temprorary
    self.end_date.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"enddate"];
    self.start_time.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"startTime"];
    self.end_time.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"endTime"];
    
    self.comments.text=[[NSUserDefaults standardUserDefaults]stringForKey:@"comments"];
    
    int value=[[NSUserDefaults standardUserDefaults]objectForKey:@"hours"];
    NSLog(@"hours integer = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"hours"]);
    
    
    int value1=[[NSUserDefaults standardUserDefaults] objectForKey:@"days"];
    NSLog(@"days integer = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"days"]);
    
    _pricePerDay.text=_pricedaystr;
    _pricePerHour.text=_pricehourstr;
    _hotelName.text=_hotelNamestr;
    _address.text=_addressstr;
    
    
    
    
}

- (IBAction)setEditCommentBtn:(UIButton *)editCommentBtn {
    if ([_comments.text length] != 0){
        [_editCommentBtn setEnabled:YES];
        [_comments setEnabled:YES];
        _comments.backgroundColor = [UIColor whiteColor];
        
        
        [[NSUserDefaults standardUserDefaults]setValue:self.comments.text forKey:@"editComment"];
        NSLog(@"Edit Comments = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"editComment"]);
        
    }
    else {
        [_editCommentBtn setEnabled:NO];
        [_comments setEnabled:NO];
        _comments.backgroundColor = [UIColor lightGrayColor];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if([[segue identifier]isEqualToString:@"showConfirm"])
    {
        ConfirmViewController *c=[segue destinationViewController];
        //        t.service_provider_id_str=_service_id_str;
        
    }
    
   

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
