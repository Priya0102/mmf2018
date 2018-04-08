//
//  ReturnOnlineViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 10/5/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReturnOnlineViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *amountTxt;

@property(nonatomic,retain)NSString *paymentTypeStr,*paymentIdStr,*amountTypeStr,*bookidStr,*success,*message;
@property (weak, nonatomic) IBOutlet UILabel *payment_mode_id;
@property (weak, nonatomic) IBOutlet UILabel *payment_mode_type;

@property (weak, nonatomic) IBOutlet UILabel *bookid;

@property (strong, nonatomic) IBOutlet UIButton *submitBtnClicked;

@end
