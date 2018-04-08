//
//  WalletViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/31/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *transactionId;
@property (strong, nonatomic) IBOutlet UITextField *amountTxt;
@property (strong, nonatomic) IBOutlet UITextField *banknameTxt;

@property(nonatomic,retain)NSString *paymentTypeStr,*paymentIdStr,*amountTypeStr,*bookidStr,*success,*message;

@property (weak, nonatomic) IBOutlet UILabel *payment_mode_Id;
@property (weak, nonatomic) IBOutlet UILabel *payment_mode_Type;

@property (strong, nonatomic) IBOutlet UIButton *submitBtnClicked;

@property (strong, nonatomic) IBOutlet UIButton *yesBtn;
@property (strong, nonatomic) IBOutlet UIButton *noBtn;

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UILabel *bookid;

@property(strong,nonatomic) NSMutableArray *paymenttypearr,*tickarray;
@end
