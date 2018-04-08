//
//  OnlineTransViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/31/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnlineTransViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *amountTxt;
@property(nonatomic,retain)NSString *paymentTypeStr,*paymentIdStr,*amountTypeStr,*success,*message;

@property (weak, nonatomic) IBOutlet UILabel *payment_mode_id;
@property (weak, nonatomic) IBOutlet UILabel *payment_mode_type;
//@property (strong, nonatomic) IBOutlet UIButton *depositBtn;
//@property (strong, nonatomic) IBOutlet UILabel *deposit_lbl;
//@property (strong, nonatomic) IBOutlet UIButton *advanceBtn;
//@property (strong, nonatomic) IBOutlet UILabel *net_lbl;
//@property (strong, nonatomic) IBOutlet UIButton *netButton;
//@property (strong, nonatomic) IBOutlet UILabel *advance_lbl;
//@property (strong, nonatomic) IBOutlet UIButton *fullpaymentBtn;
//@property (strong, nonatomic) IBOutlet UILabel *fullPayment_lbl;

@property (strong, nonatomic) IBOutlet UIButton *submitBtnClicked;


@property (weak, nonatomic) IBOutlet UILabel *bookid;


@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) NSMutableArray *paymenttypearr,*tickarray;



@end
