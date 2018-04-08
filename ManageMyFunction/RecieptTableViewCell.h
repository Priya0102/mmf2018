//
//  RecieptTableViewCell.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/31/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecieptTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *facilityName;
@property (strong, nonatomic) IBOutlet UILabel *quantity;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *bookId;
@property (strong, nonatomic) IBOutlet UILabel *otherFacilityId;
@end
