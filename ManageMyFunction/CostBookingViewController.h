//
//  CostBookingViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/29/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CostBookingViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *start_date;
@property (strong, nonatomic) IBOutlet UILabel *start_time;
@property (strong, nonatomic) IBOutlet UILabel *end_date;
@property (strong, nonatomic) IBOutlet UILabel *end_time;



@property (strong, nonatomic) IBOutlet UILabel *hotelName;
@property (strong, nonatomic) IBOutlet UILabel *address;

@property(nonatomic,retain)NSString *hotelNamestr,*addressstr,*pricehourstr,*pricedaystr;
@property (strong, nonatomic) IBOutlet UIButton *proceedBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *editInfoBtn;
@property (strong, nonatomic) IBOutlet UIButton *editCommentBtn;
@property (strong, nonatomic) IBOutlet UILabel *venueTotalPrice;
@property (strong, nonatomic) IBOutlet UILabel *grandTotalPrice;
@property (strong, nonatomic) IBOutlet UILabel *pricePerHour;
@property (strong, nonatomic) IBOutlet UILabel *pricePerDay;
@property (strong, nonatomic) IBOutlet UITextField *comments;
@end
