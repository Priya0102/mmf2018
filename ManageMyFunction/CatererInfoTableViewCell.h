//
//  CatererInfoTableViewCell.h
//  ManageMyFunction
//
//  Created by Anveshak on 11/3/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Checkbox.h"
#import "CheckBoxButton.h"
@interface CatererInfoTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *facility_name;
@property (strong, nonatomic) IBOutlet UILabel *quantity;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *comments;

@property (strong, nonatomic) IBOutlet UILabel *facility_id;
@property (strong, nonatomic) IBOutlet UILabel *facility_id_no;
@property (strong, nonatomic) IBOutlet UILabel *unit;


@property(nonatomic,assign)IBInspectable BOOL isChecked;
@property(nonatomic,strong)IBInspectable UIImage* checkedStateImage;

//- (IBAction)quantity_no_txtfld:(UITextField *)sender;

//- (IBAction)checkBtn:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet CheckBoxButton *checkBoxBtn;
@property (strong, nonatomic) IBOutlet UITextField *quantity_no_txtfld;

@property(nonatomic,strong)IBInspectable UIImage* uncheckedStateImage;


@end
