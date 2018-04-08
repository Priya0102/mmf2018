//
//  VenueInfoTableViewCell.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/21/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckBoxButton.h"

@interface VenueInfoTableViewCell : UITableViewCell<UITextFieldDelegate>



//@property(nonatomic, readonly, retain) UINavigationController *navigationController;

@property (strong, nonatomic) IBOutlet UILabel *facility_name;
@property (strong, nonatomic) IBOutlet UILabel *quantity;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *comments;

@property (strong, nonatomic) IBOutlet UILabel *facility_id;
@property (strong, nonatomic) IBOutlet UILabel *facility_id_no;
@property (strong, nonatomic) IBOutlet UILabel *unit;

@property (strong, nonatomic) IBOutlet UIImageView *downImg;

@property(nonatomic,assign)IBInspectable BOOL isChecked;
@property(nonatomic,strong)IBInspectable UIImage* checkedStateImage;

//- (IBAction)quantity_no_txtfld:(UITextField *)sender;

//- (IBAction)checkBtn:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet CheckBoxButton *checkBoxBtn;
@property (strong, nonatomic) IBOutlet UITextField *quantity_no_txtfld;

@property(nonatomic,strong)IBInspectable UIImage* uncheckedStateImage;
@property (strong, nonatomic) IBOutlet UIButton *btnread;

//-(void)changeUserQuantity;

@end
