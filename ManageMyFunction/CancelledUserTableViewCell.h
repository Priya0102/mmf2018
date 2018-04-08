//
//  CancelledUserTableViewCell.h
//  ManageMyFunction
//
//  Created by Anveshak on 10/24/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CancelledUserTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *facilityName;
@property (strong, nonatomic) IBOutlet UILabel *quantity;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *bookId;
@property (strong, nonatomic) IBOutlet UILabel *otherFacilityId;
@end
