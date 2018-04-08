//
//  MenuSideBarViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 11/13/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuSideBarViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)btnmenu:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *sideview;
@property (strong, nonatomic) IBOutlet UITableView *sidebar;
@property (strong, nonatomic) IBOutlet UIImageView *profilepic;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) NSMutableArray *arrdata;
@end
