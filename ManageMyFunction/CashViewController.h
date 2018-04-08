//
//  CashViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/31/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *amountTxt;
@property(nonatomic,retain)NSString *paymentTypeStr,*paymentIdStr,*amountTypeStr,*success,*message,*bookidStr;

@property (weak, nonatomic) IBOutlet UILabel *payment_mode_id;
@property (weak, nonatomic) IBOutlet UILabel *payment_mode_type;


@property (strong, nonatomic) IBOutlet UIButton *submitBtnClicked;


@property (weak, nonatomic) IBOutlet UILabel *bookid;


@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) NSMutableArray *paymenttypearr,*tickarray;




@end
