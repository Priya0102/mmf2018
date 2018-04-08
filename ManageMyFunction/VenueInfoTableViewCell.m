//
//  VenueInfoTableViewCell.m
//  ManageMyFunction
//
//  Created by Anveshak on 8/21/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "VenueInfoTableViewCell.h"
#import "CheckBoxButton.h"
#import "VenueInfoViewController.h"
#import "VenueInfo.h"

@implementation VenueInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
       
     // self.quantity_no_txtfld.delegate=self;
    
    // [[NSUserDefaults standardUserDefaults]setValue:self.quantity_no_txtfld.text forKey:@"quantityNumber"];
    
    [_quantity_no_txtfld addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    
   //  self.quantity_no_txtfld.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"quantityNumber"];
    // Initialization code
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (!string.length)
    {
        return YES;
    }
    
    if ([string intValue])
    {
        return YES;
    }
    
    return NO;
    
}

-(void)textFieldDidChange{

    if (_quantity_no_txtfld.text.length>0){
        
        VenueInfo *mySingleton = [[VenueInfo alloc]init];
        mySingleton.venuefacilityarray = [[NSMutableArray alloc]init];
        
        

        VenueInfoViewController *vobj=[[VenueInfoViewController alloc]init];
        [vobj changeUserQuantity:(int)self.tag :self.quantity_no_txtfld.text];

        NSLog(@"Cell tag %ld",(long)self.tag);
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
    
//
//    // Configure the view for the selected state
}



- (IBAction)onChecked:(CheckBoxButton *)sender{
    
    NSLog(@"onchecked call====%ld",(long)sender.tag);

    if(_checkBoxBtn.isChecked){
        self.quantity_no_txtfld.enabled=YES;
        
//        [[NSUserDefaults standardUserDefaults]setValue:self.quantity_no_txtfld.text forKey:@"quantityNumber"];
//         NSLog(@"Quantity number = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"quantityNumber"]);
    }
    else{
        self.quantity_no_txtfld.enabled=NO;
    }
    
}

- (IBAction)quantity_no_txtfld:(UITextField *)sender {
}



@end
