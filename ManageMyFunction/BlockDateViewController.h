//
//  BlockDateViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 10/6/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockDateViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *startdate;
@property (strong, nonatomic) IBOutlet UITextField *enddate;
@property (strong, nonatomic) IBOutlet UITextField *startTime;
@property (strong, nonatomic) IBOutlet UITextField *endTime;

@property (strong, nonatomic) IBOutlet UITextView *comments;
@property (retain, nonatomic) IBOutlet UIButton *blockButton;

@property(nonatomic,retain)NSString *success,*message;
@end
