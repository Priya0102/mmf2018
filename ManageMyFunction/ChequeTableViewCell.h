//
//  ChequeTableViewCell.h
//  ManageMyFunction
//
//  Created by Anveshak on 10/30/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChequeTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *selectBtn;
@property (strong, nonatomic) IBOutlet UILabel *paymentType;
@property (strong, nonatomic) IBOutlet UILabel *paymentId;

@end
