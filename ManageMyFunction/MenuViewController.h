//
//  MenuViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 11/15/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSMutableArray *menuarr,*menuidarr,*menunamearr;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@end
