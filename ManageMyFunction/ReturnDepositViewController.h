//
//  ReturnDepositViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 10/5/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReturnDepositViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) NSMutableArray *paymentmodearr;

@property(nonatomic,retain)NSString *paymentModetypeStr,*paymentmodeIdStr;
@end
