//
//  AppDelegate.m
//  ManageMyFunction
//
//  Created by Anveshak on 6/20/17.
//  Copyright © 2017 Anveshak. All rights reserved.
#import "AppDelegate.h"

#import "ViewController.h"
#import "Reachability.h"
#import <unistd.h>
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@import UserNotifications;
#endif

// Implement UNUserNotificationCenterDelegate to receive display notification via APNS for devices
// running iOS 10 and above.
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@interface AppDelegate () <UNUserNotificationCenterDelegate>
@end
#endif

// Copied from Apple's header in case it is missing in some cases (e.g. pre-Xcode 8 builds).
#ifndef NSFoundationVersionNumber_iOS_9_x_Max
#define NSFoundationVersionNumber_iOS_9_x_Max 1299
#endif


@interface AppDelegate ()
#define IDIOM UI_USER_INTERFACE_IDIOM()
#define IPAD UIUserInterfaceIdiomPad
@end

@implementation AppDelegate

NSString *const kGCMMessageIDKey = @"gcm.message_id";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    sleep(3);
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        //        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Explain the situation to the user" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        //        [alert show];
        //[alert release];
        
    }
    else {
                [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:45.0/255.0 green:25.0/255.0 blue:147.0/255.0 alpha:1.0]];
//        
//                [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:45.0/255.0 green:25.0/255.0 blue:147.0/255.0 alpha:1.0]];

//        
//        [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:206.0/255.0 green:34.0/255.0 blue:8.0/255.0 alpha:1.0]];
//        
//        [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:206.0/255.0 green:34.0/255.0 blue:8.0/255.0 alpha:1.0]];
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
        shadow.shadowOffset = CGSizeMake(0, 1);
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                               [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                               shadow, NSShadowAttributeName,
                                                               [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:20.0],NSFontAttributeName, nil]];
        
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    
        
        UIStoryboard *storyboard = [self grabStoryboard];
        
        // display storyboard
        self.window.rootViewController = [storyboard instantiateInitialViewController];
        [self.window makeKeyAndVisible];
        
        NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
        
        
        if(savedValue!=NULL)
        {
            int screenHeight = [UIScreen mainScreen].bounds.size.height;
            
            
            switch (screenHeight) {
                    // iPhone 4s
                case 480:
                {
                    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    ViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                    self.window.rootViewController = navController;
                    
                    
                    break;
                }
                    //iPhone 5 & iPhone SE
                case 548:
                {
                    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    ViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                    self.window.rootViewController = navController;
                    
                    
                    break;
                } // iPhone 5s
                case 568:
                {
                    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    ViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                    self.window.rootViewController = navController;
                    
                    
                    break;
                }
                    // iPhone 6 & 6s & iPhone 7
                case 647:
                {
                    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    ViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                    self.window.rootViewController = navController;
                    
                    
                    break;
                }
                    // iPhone 6 Plus & 6s Plus & iPhone 7 Plus
                case 716:
                {
                    storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
                    ViewController *loginController=[[UIStoryboard storyboardWithName:@"Main2" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                    self.window.rootViewController = navController;
                    
                    
                    break;
                }
                case 667:
                {
                    storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
                    ViewController *loginController=[[UIStoryboard storyboardWithName:@"Main2" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                    self.window.rootViewController = navController;
                    
                    
                    break;
                }
                case 736:
                {
                    storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
                    ViewController *loginController=[[UIStoryboard storyboardWithName:@"Main2" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                    self.window.rootViewController = navController;
                    
                    
                    break;
                }
                case 1366:
                {
                    storyboard = [UIStoryboard storyboardWithName:@"ipad2" bundle:nil];
                    ViewController *loginController=[[UIStoryboard storyboardWithName:@"ipad2" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                    self.window.rootViewController = navController;
                    
                    
                    break;
                }
                    
                default:
                {
                    storyboard = [UIStoryboard storyboardWithName:@"ipad" bundle:nil];
                    ViewController *loginController=[[UIStoryboard storyboardWithName:@"ipad" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                    self.window.rootViewController = navController;
                    
                    
                    break;
                }
            }
            
            
            
        }
        
        
        
        
        
        
        
        
        
        // [START configure_firebase]
//        [FIRApp configure];
//        // [END configure_firebase]
//        
//        // [START set_messaging_delegate]
//        [FIRMessaging messaging].delegate = self;
        // [END set_messaging_delegate]
        
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
            // iOS 7.1 or earlier. Disable the deprecation warnings.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            UIRemoteNotificationType allNotificationTypes =
            (UIRemoteNotificationTypeSound |
             UIRemoteNotificationTypeAlert |
             UIRemoteNotificationTypeBadge);
            [application registerForRemoteNotificationTypes:allNotificationTypes];
#pragma clang diagnostic pop
        } else {
            // iOS 8 or later
            // [START register_for_notifications]
            if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
                UIUserNotificationType allNotificationTypes =
                (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
                UIUserNotificationSettings *settings =
                [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
                [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            } else {
                // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
                // For iOS 10 display notification (sent via APNS)
                [UNUserNotificationCenter currentNotificationCenter].delegate = self;
                UNAuthorizationOptions authOptions =
                UNAuthorizationOptionAlert
                | UNAuthorizationOptionSound
                | UNAuthorizationOptionBadge;
                [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
                }];
#endif
            }
            
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            // [END register_for_notifications]
        }
        return YES;
    }
    return 0;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[Messaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
}


- (UIStoryboard *)grabStoryboard {
    
    // determine screen size
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    NSLog(@"screenhe %d",screenHeight);
    UIStoryboard *storyboard;
    
    switch (screenHeight) {
            // iPhone 4s
        case 480:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
            //iPhone 5 & iPhone SE
        case 548:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
            // iPhone 5s
        case 568:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
            // iPhone 6 & 6s & iPhone 7
        case 647:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
            // iPhone 6 Plus & 6s Plus & iPhone 7 Plus
        case 716:
            storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
            break;
            
        case 667:
            storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
            break;
        case 736:
            storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
            break;
            
        case 1366:
            storyboard = [UIStoryboard storyboardWithName:@"ipad2" bundle:nil];
            break;
            
            
        default:
            // it's an iPad
            storyboard = [UIStoryboard storyboardWithName:@"ipad" bundle:nil];
            break;
    }
    
    return storyboard;
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[Messaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}



#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// Handle incoming notification messages while app is in the foreground.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[Messaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    // Change this to your preferred presentation option
    completionHandler(UNNotificationPresentationOptionNone);
}

// Handle notification messages after display notification is tapped by the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler();
}
#endif
// [END ios_10_message_handling]

// [START refresh_token]
//- (void)messaging:(nonnull FIRMessaging *)messaging didRefreshRegistrationToken:(nonnull NSString *)fcmToken {
//    // Note that this callback will be fired everytime a new token is generated, including the first
//    // time. So if you need to retrieve the token as soon as it is available this is where that
//    // should be done.
//    NSLog(@"FCM registration token: %@", fcmToken);
//    // TODO: If necessary send token to application server.
//    
//    
//    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
//    NSString *myst=[NSString stringWithFormat:@"token=%@",fcmToken];
//    
//    // NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/iOSAPI/dev.php"];
//    NSURL * url = [NSURL URLWithString:@"http://www.siddhantedu.com/iOSAPI/Symp/dev.php"];////server
//    
//    //NSURL *url=[NSURL URLWithString:@"http://www.siddhantedu.com/admin_ith/dev.php"];//uploaded version server api
//    
//    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
//    [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if(error == nil)
//        {
//            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//            NSLog(@"%@",text);
//        }
//    }];
//    [dataTask resume];
//    
//}
//// [END refresh_token]
//
//// [START ios_10_data_message]
//// Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
//// To enable direct data messages, you can set [Messaging messaging].shouldEstablishDirectChannel to YES.
//- (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage {
//    NSLog(@"Received data message: %@", remoteMessage.appData);
//}
// [END ios_10_data_message]

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Unable to register for remote notifications: %@", error);
}

// This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
// If swizzling is disabled then this function must be implemented so that the APNs device token can be paired to
// the FCM registration token.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"APNs device token retrieved: %@", deviceToken);
    
    // With swizzling disabled you must set the APNs device token here.
    // [Messaging messaging].APNSToken = deviceToken;
}


@end

