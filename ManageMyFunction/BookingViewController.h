//
//  BookingViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/16/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UILabel *start_date;
@property (strong, nonatomic) IBOutlet UILabel *start_time;
@property (strong, nonatomic) IBOutlet UILabel *end_date;
@property (strong, nonatomic) IBOutlet UILabel *end_time;

@property (strong, nonatomic) IBOutlet UITableView *tableview;


@property (strong, nonatomic) IBOutlet UILabel *hotelName;
@property (strong, nonatomic) IBOutlet UILabel *address;

@property(nonatomic,retain)NSString *hotelNamestr,*addressstr,*pricehourstr,*pricedaystr;
@property (strong, nonatomic) IBOutlet UIButton *proceedBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *editInfoBtn;
@property (strong, nonatomic) IBOutlet UIButton *editCommentBtn;
@property (strong, nonatomic) IBOutlet UILabel *facilityTotalPrice;


@property (strong, nonatomic) IBOutlet UILabel *venueTotalPrice;
@property (strong, nonatomic) IBOutlet UILabel *grandTotalPrice;
@property (strong, nonatomic) IBOutlet UILabel *pricePerHour;
@property (strong, nonatomic) IBOutlet UILabel *pricePerDay;
@property (strong, nonatomic) IBOutlet UITextField *comments;
@property (strong, nonatomic)  NSString *main_role;
@property (strong, nonatomic) IBOutlet UIButton *editOtherFacilityBtn;

@property(nonatomic,retain)NSMutableArray *venuefacility_arr;
@property (strong, nonatomic) IBOutlet UILabel *eventName;

@end
