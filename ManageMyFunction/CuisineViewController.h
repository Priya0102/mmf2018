//
//  CuisineViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 11/16/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CuisineViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSMutableArray *cuisinearr,*cusidarr,*cusnamearr;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

//@property(nonatomic,strong)UILabel *service_provider_id;
@property (strong, nonatomic) IBOutlet UILabel *service_pro_id;

@property(nonatomic,retain)NSString *serviceprovideridStr;

@end
