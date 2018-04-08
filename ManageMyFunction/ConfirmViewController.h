//
//  ConfirmViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/21/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Checkbox.h"
@interface ConfirmViewController : UIViewController<NSURLSessionDelegate,UITextFieldDelegate>

@property (strong,nonatomic) NSMutableArray *myprofile;

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *contact;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *eventname;

@property (strong, nonatomic) IBOutlet UIButton *bookBtnClicked;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtnClicked;

@property (weak, nonatomic) NSString *userid;
@property (strong,nonatomic) NSString *success,*user_event_id;

@end
