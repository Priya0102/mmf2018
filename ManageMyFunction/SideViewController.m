//
//  SideViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 11/10/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "SideViewController.h"

@interface SideViewController ()

@end

@implementation SideViewController
@synthesize sidePanel,menuBtn,transV;
- (void)viewDidLoad {
    [super viewDidLoad];
    _contentView.layer.cornerRadius =30 ;
    _contentView.clipsToBounds = YES;
    
    _profilepic.layer.cornerRadius =30 ;
    _profilepic.clipsToBounds = YES;
    
    //[_venueBtn setBackgroundColor:[UIColor grayColor] forState:UIControlStateSelected];
    
    UITapGestureRecognizer *tapper=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideSidePanel:)];
    tapper.numberOfTapsRequired=1;
    [transV addGestureRecognizer:tapper];
    
    
}
-(void)hideSidePanel:(UIGestureRecognizer *)gesture{
    
    if (gesture.state==UIGestureRecognizerStateEnded) {
        [transV setHidden:YES];
        [UIView transitionWithView:sidePanel duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame=sidePanel.frame;
            frame.origin.x=-sidePanel.frame.size.width;
            sidePanel.frame=frame;
        } completion:nil];
    }
}
-(IBAction)buttonPressed:(id)sender{
    if (sender==menuBtn) {
        [transV setHidden:NO];
        [UIView transitionWithView:sidePanel duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame=sidePanel.frame;
            frame.origin.x=0;
            sidePanel.frame=frame;
        } completion:nil];
    }
}
- (IBAction)profilePicButton:(id)sender {
    _myProfileBtn.backgroundColor=[UIColor lightGrayColor];
    _venueBtn.backgroundColor=[UIColor whiteColor];
    _catrerBtn.backgroundColor=[UIColor whiteColor];
    _photographerBtn.backgroundColor=[UIColor whiteColor];
    _decoraterBtn.backgroundColor=[UIColor whiteColor];
    NSLog(@"PROFILE BUTTON CLICKED==%@",_myProfileBtn);
}
- (IBAction)venueBtnClicked:(id)sender {
    _venueBtn.backgroundColor=[UIColor lightGrayColor];
    NSLog(@"Venue BUTTON CLICKED==%@",_venueBtn);
    _myProfileBtn.backgroundColor=[UIColor whiteColor];
    _catrerBtn.backgroundColor=[UIColor whiteColor];
    _photographerBtn.backgroundColor=[UIColor whiteColor];
    _decoraterBtn.backgroundColor=[UIColor whiteColor];
}
- (IBAction)catererBtnClicked:(id)sender {
    _catrerBtn.backgroundColor=[UIColor lightGrayColor];
    NSLog(@"Caterer BUTTON CLICKED==%@",_catrerBtn);
    _myProfileBtn.backgroundColor=[UIColor whiteColor];
    _venueBtn.backgroundColor=[UIColor whiteColor];
    _photographerBtn.backgroundColor=[UIColor whiteColor];
    _decoraterBtn.backgroundColor=[UIColor whiteColor];
    
}
- (IBAction)photographerBtnClicked:(id)sender {
    _photographerBtn.backgroundColor=[UIColor lightGrayColor];
    NSLog(@"Photographer BUTTON CLICKED==%@",_photographerBtn);
    _myProfileBtn.backgroundColor=[UIColor whiteColor];
    _catrerBtn.backgroundColor=[UIColor whiteColor];
    _venueBtn.backgroundColor=[UIColor whiteColor];
    _decoraterBtn.backgroundColor=[UIColor whiteColor];
}
- (IBAction)decoraterBtnClicked:(id)sender {
    _decoraterBtn.backgroundColor=[UIColor lightGrayColor];
    NSLog(@"Decorater BUTTON CLICKED==%@",_decoraterBtn);
    _myProfileBtn.backgroundColor=[UIColor whiteColor];
    _catrerBtn.backgroundColor=[UIColor whiteColor];
    _photographerBtn.backgroundColor=[UIColor whiteColor];
    _venueBtn.backgroundColor=[UIColor whiteColor];
}


@end
