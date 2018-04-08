//
//  BlockedTableViewCell.h
//  ManageMyFunction
//
//  Created by Anveshak on 10/24/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockedTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *serviceName;
@property (strong, nonatomic) IBOutlet UILabel *startDate;
@property (strong, nonatomic) IBOutlet UILabel *startTime;
@property (strong, nonatomic) IBOutlet UILabel *endDate;
@property (strong, nonatomic) IBOutlet UILabel *endTime;
@property (strong, nonatomic) IBOutlet UIButton *unblockBtn;
@property (strong, nonatomic) IBOutlet UILabel *blockedDateLabel;

@property(retain,nonatomic)NSString *success,*message;

@end
