//
//  BookCostTableViewCell.h
//  ManageMyFunction
//
//  Created by Anveshak on 9/11/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookCostTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *quantityNo;
@property (strong, nonatomic) IBOutlet UILabel *unit;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *facilityName;

@end
