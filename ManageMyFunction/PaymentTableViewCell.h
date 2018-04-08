//
//  PaymentTableViewCell.h
//  ManageMyFunction
//
//  Created by Anveshak on 10/11/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;
@property (strong, nonatomic) IBOutlet UILabel *paymentModeType;
@property (strong, nonatomic) IBOutlet UILabel *paymentModeId;



@end
