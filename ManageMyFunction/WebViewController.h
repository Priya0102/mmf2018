//
//  WebViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/18/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@property (nonatomic,strong) NSString *myurl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicaor;

@end
