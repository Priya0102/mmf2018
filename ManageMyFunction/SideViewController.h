//
//  SideViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 11/10/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideViewController : UIViewController
{
    IBOutlet UIView *transV;
    IBOutlet UIView *sidePanel;
    IBOutlet UIButton *menuBtn;
}
@property(nonatomic)IBOutlet UIButton *menuBtn;
@property(nonatomic)IBOutlet UIView *sidePanel;
@property(nonatomic)IBOutlet UIView *transV;
@property (strong, nonatomic) IBOutlet UIButton *myProfileBtn;
@property (strong, nonatomic) IBOutlet UIButton *venueBtn;
@property (strong, nonatomic) IBOutlet UIButton *catrerBtn;
@property (strong, nonatomic) IBOutlet UIButton *photographerBtn;
@property (strong, nonatomic) IBOutlet UIButton *decoraterBtn;
@property (strong, nonatomic) IBOutlet UIImageView *profilepic;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@end
