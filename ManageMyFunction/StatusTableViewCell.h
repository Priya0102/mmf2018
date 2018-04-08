//
//  StatusTableViewCell.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/31/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *startDate;
@property (strong, nonatomic) IBOutlet UILabel *firstname;
@property(strong,nonatomic)IBOutlet UILabel *lastname;
@property (strong, nonatomic) IBOutlet UILabel *service_provider_id;
@property (strong, nonatomic) IBOutlet UILabel *bookid;
@property(strong,nonatomic)IBOutlet UILabel *userid;
@property (strong, nonatomic) IBOutlet UILabel *contact;
@property (strong, nonatomic) IBOutlet UILabel *isConfirmed;
@property (strong, nonatomic) IBOutlet UILabel *isPaid;
@end
