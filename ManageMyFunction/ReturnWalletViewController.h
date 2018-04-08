//
//  ReturnWalletViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 10/5/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReturnWalletViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *transactionId;
@property (strong, nonatomic) IBOutlet UITextField *amountTxt;
@property (strong, nonatomic) IBOutlet UITextField *banknameTxt;

@property(nonatomic,retain)NSString *paymentTypeStr,*paymentIdStr,*amountTypeStr,*bookidStr,*success,*message;

@property (weak, nonatomic) IBOutlet UILabel *payment_mode_id;
@property (weak, nonatomic) IBOutlet UILabel *payment_mode_type;

@property (weak, nonatomic) IBOutlet UILabel *bookid;

@property (strong, nonatomic) IBOutlet UIButton *submitBtnClicked;

@end
