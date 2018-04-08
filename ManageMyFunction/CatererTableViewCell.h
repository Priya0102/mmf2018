//
//  CatererTableViewCell.h
//  ManageMyFunction
//
//  Created by Anveshak on 11/2/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatererTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *service_name;

@property (strong, nonatomic) IBOutlet UILabel *location;

@property (strong, nonatomic) IBOutlet UILabel *city;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *guest;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *food_type_id;
@property (strong, nonatomic) IBOutlet UILabel *service_provide_id;

@property (strong, nonatomic) IBOutlet UILabel *area_id;

@property (strong, nonatomic) IBOutlet UILabel *venue_type_id;
@property (strong, nonatomic) IBOutlet UILabel *available_status;
@property (strong, nonatomic) IBOutlet UIButton *viewMoreBtn;
@end
