//
//  DropdownMenuController.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/16/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropdownMenuController : UIViewController



@property (weak,nonatomic) UIViewController *currentViewController;
@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIView *menubar;
@property (weak, nonatomic) IBOutlet UIView *menu;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

- (IBAction) displayGestureForTapRecognizer:(UITapGestureRecognizer *) recognizer;
- (IBAction) menuButtonAction: (UIButton *) sender;
- (IBAction) listButtonAction: (UIButton *) sender;

- (void) setTrianglePlacement: (float) trianglePlacementVal;
- (void) setFadeAmountWithAlpha:(float) alphaVal;
- (void) setFadeTintWithColor:(UIColor *) color;
- (void) dropShapeShouldShowWhenOpen:(BOOL)shouldShow;
- (void) setMenubarTitle:(NSString *) menubarTitle;
- (void) setMenubarBackground:(UIColor *) color;
- (void) toggleMenu;
- (void) showMenu;
- (void) hideMenu;


@end
