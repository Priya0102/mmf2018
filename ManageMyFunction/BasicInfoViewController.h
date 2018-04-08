//
//  BasicInfoViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 10/27/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicInfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *hallName;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *capacity;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UITableView *tableview2;
@property (strong, nonatomic) IBOutlet UIButton *updateBasicInfoBtn;
@property (strong, nonatomic) IBOutlet UILabel *foodtype_lbl;
@property (strong, nonatomic) IBOutlet UIButton *foodTypeBtn;

@end
