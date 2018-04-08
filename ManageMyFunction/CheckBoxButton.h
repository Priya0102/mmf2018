//
//  CheckBoxButton.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/21/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckBoxButton : UIButton


@property(nonatomic,assign)IBInspectable BOOL isChecked;
@property(nonatomic,strong)IBInspectable UIImage* checkedStateImage;
@property(nonatomic,strong)IBInspectable UIImage* uncheckedStateImage;
@property(strong,nonatomic,nullable) NSString* onChecked;

@end
