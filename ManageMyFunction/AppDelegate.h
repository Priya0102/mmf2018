//
//  AppDelegate.h
//  ManageMyFunction
//
//  Created by Anveshak on 6/20/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong,nonatomic)UINavigationController *navC;



@property (strong,nonatomic) NSString *deviceToken;
@property (strong,nonatomic) NSString *payload;
@property (strong,nonatomic) NSString *certificate;



@end

