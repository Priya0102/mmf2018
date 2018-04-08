//
//  CheckViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/31/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *chequeNumTxt;
@property (strong, nonatomic) IBOutlet UITextField *amountTxt;
@property (strong, nonatomic) IBOutlet UITextField *banknameTxt;

@property (weak, nonatomic) IBOutlet UILabel *payment_mode_id;
@property (weak, nonatomic) IBOutlet UILabel *payment_mode_type;

@property(nonatomic,retain)NSString *paymentTypeStr,*paymentIdStr,*amountTypeStr,*success,*message,*bookidStr;

@property (strong, nonatomic) IBOutlet UIButton *yesBtn;
@property (strong, nonatomic) IBOutlet UIButton *noBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtnClicked;

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UILabel *bookid;

@property(strong,nonatomic) NSMutableArray *paymenttypearr,*tickarray;

@end
