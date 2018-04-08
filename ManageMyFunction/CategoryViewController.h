//
//  CategoryViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 11/16/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSMutableArray *categoryarr,*catidarr,*catnamearr;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end
