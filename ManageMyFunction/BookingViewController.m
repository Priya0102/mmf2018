//
//  BookingViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 8/16/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "BookingViewController.h"
#import "HomeViewController.h"
#import "ViewController.h"
#import "VenueInfoViewController.h"
#import "ConfirmViewController.h"
#import "BookCostTableViewCell.h"
#import "VenueInfo.h"
@interface BookingViewController ()

@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _venuefacility_arr=[[NSMutableArray alloc]init];
    [_venuefacility_arr removeAllObjects];
    
    
//    
//     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//     NSString *eventName = [prefs stringForKey:@"eventName"];
//    
//    NSLog(@"event name===%@",eventName);
    
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"venuefacilityarr"];
    if (dataRepresentingSavedArray != nil)
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil)
            _venuefacility_arr = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        else
            _venuefacility_arr = [[NSMutableArray alloc] init];
    }
    
    for(VenueInfo *temp in _venuefacility_arr)
    {
        
        NSLog(@"SelectedfacilityArray****= %@%@",temp.facility_name, temp.userquantity);
        
    }
    
    
    
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
    NSLog(@"Price Per Day==%@",self.pricePerDay.text);
    _pricePerHour.text=_pricehourstr;
    NSLog(@"Price Per Hour==%@",self.pricePerHour.text);
    _hotelName.text=_hotelNamestr;
    _address.text=_addressstr;

    
    [[NSUserDefaults standardUserDefaults]setValue:self.hotelName.text forKey:@"hotelName"];
    NSLog(@"bOOKING Hotel Name = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"hotelName"]);
    
  
               
               // Grab the values from the UITextFields.
         /*      float pricePerDay = [[_pricePerDay text] floatValue];
               float priceDayInteger = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"days"] text] floatValue];
               
               // Multiply them.
               float j = pricePerDay * priceDayInteger;
    NSLog(@"Price1===%f",j);
    
    
    // Grab the values from the UITextFields.
    float pricePerHour = [[_pricePerHour text] floatValue];
    float priceHourInteger = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"hours"] text] floatValue];
    
    // Multiply them.
    float i = pricePerHour * priceHourInteger;
        NSLog(@"Price2===%f",i);
    
[_grandTotalPrice setText:[NSString stringWithFormat:@"%.2f", j + i]];
    
    NSLog(@"Grand Total Price===%@",_grandTotalPrice);
   //    int sum = [[_venueTotalPrice text] intValue] + [[_facilityTotalPrice text] intValue];
//    _grandTotalPrice.text = [NSString stringWithFormat:@"%d", sum];
//        float sum = [[_pricePerDay * priceDayInteger text]floatValue] + [[_pricePerHour * priceHourInteger text] floatValue];
//        _grandTotalPrice.text = [NSString stringWithFormat:@"%f", sum];
//  
          */
    
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
    
    
//    if([[segue identifier]isEqualToString:@"showLogin"])
//    {
//        HomeViewController *t=[segue destinationViewController];
//        //        t.service_provider_id_str=_service_id_str;
//    
//    }
    
 //   if([[segue identifier]isEqualToString:@"showEditInfoVenue"])
//    {
//        
//        VenueInfoViewController *v=[segue destinationViewController];
//        //        t.service_provider_id_str=_service_id_str;
//        [self.navigationController popViewControllerAnimated:YES];
//        
//    }
//    if([[segue identifier]isEqualToString:@"showConfirm"])
//    {
//        
//        ConfirmViewController *c=[segue destinationViewController];
//        //        t.service_provider_id_str=_service_id_str;
//        [self.navigationController popViewControllerAnimated:YES];
//        
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)proceedBtnClicked:(id)sender {
    
    UIButton *resultbutton= (UIButton*)sender;
    NSString *buttontitle=_proceedBtn.currentTitle;
 
    if ([buttontitle isEqual:@"Proceed"])
    {
        [_proceedBtn setTitle:@"Proceed" forState:UIControlStateNormal];
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
   else
    {
        [_proceedBtn setTitle:@"Next" forState:UIControlStateNormal];
        [self performSegueWithIdentifier:@"showConfirm" sender:self];
    }
//    UIButton *resultbutton= (UIButton*)sender;
//    NSString *buttontitle=_proceedBtn.currentTitle;
//    
//    if ([buttontitle isEqual:@"Proceed"]) {
//        // perform your 1st button action
//        //call your method
//    
//        
//        
//        
//    }
//    else if ([buttontitle isEqual:@"Next"]) {
//        // perform your 2nd button action
//        
//    }
//   
//    if (self.main_role!=NULL) {
//        
//        int mainRole=[self.main_role intValue];
//        
//        NSLog(@"Main role===%@",self.main_role);
//        
//        switch (mainRole) {
//            case 1:
//                [self performSegueWithIdentifier:@"showLogin" sender:self];
//                
//                [_proceedBtn setTitle:@"Proceed" forState:UIControlStateNormal];
//                break;
//                
//            case 2:
//                [self performSegueWithIdentifier:@"showConfirm" sender:self];
//                [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"isLoggedIn"];
//                
//                [_proceedBtn setTitle:@"Next" forState:UIControlStateNormal];
//                break;
//                
//            default:
//                break;
//        }
//    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _venuefacility_arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    BookCostTableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    VenueInfo *vinfo=[[VenueInfo alloc]init];
    vinfo=[_venuefacility_arr objectAtIndex:indexPath.row];
    
    
    NSLog(@"Book Facility indexpath==%@",_venuefacility_arr);
    
    cell.facilityName.text=vinfo.facility_name;
    cell.quantityNo.text=vinfo.quantity;
    cell.price.text=vinfo.price;
    cell.unit.text=vinfo.unit;
        
    return  cell;
    
}


@end
