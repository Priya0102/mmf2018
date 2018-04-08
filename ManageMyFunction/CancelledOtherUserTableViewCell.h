//
//  CancelledOtherUserTableViewCell.h
//  ManageMyFunction
//
//  Created by Anveshak on 10/24/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CancelledOtherUserTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *otherDetailsType;
@property (strong, nonatomic) IBOutlet UILabel *otherDetailInfo;
@property (strong, nonatomic) IBOutlet UILabel *bookid;
@property (strong, nonatomic) IBOutlet UILabel *serviceproviderid;
@property (strong, nonatomic) IBOutlet UILabel *otherDetailsId;
@property (strong, nonatomic) IBOutlet UILabel *eventTypeId;
@end
