//
//  BlockedTableViewCell.m
//  ManageMyFunction
//
//  Created by Anveshak on 10/24/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "BlockedTableViewCell.h"

@implementation BlockedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    
//    [self.unblockBtn addTarget:self action:@selector(unblockBtnClicked:) forControlEvents:UIControlEventTouchDown];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*- (IBAction)unblockBtnClicked:(id)sender {
    
    
//    NSLog(@"*****Unblock Button Clicked****==%@",_unblockBtn);
//    
//    UIAlertController *alert=[UIAlertController
//                              alertControllerWithTitle:@"ALERT" message:@"Are you sure you want to Unblock dates?"preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction* yesButton = [UIAlertAction
//                                actionWithTitle:@"Yes"
//                                style:UIAlertActionStyleDefault
//                                handler:^(UIAlertAction * action)
//                                {
    
    
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"blocked_id"];
    
    NSLog(@"*blocked ID=%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"blocked_id"]);
    
    NSString *st=[NSString stringWithFormat:@"blocked_id=%@",savedvalue];
    
    NSLog(@"Blocked id==%@",st);
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    
    NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/unblock_dates.php"];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[st dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error == nil)
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
        }
        NSError *er=nil;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
        if(er)
        {
        }
        self.success=[responseDict objectForKey:@"success"];
        self.message=[responseDict objectForKey:@"message"];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([self.success isEqualToString:@"1"])
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Success" message:self.message preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alertView dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                
                [alertView addAction:ok];
             
            }
            else
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Failure" message:@"Not Unblocked" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alertView dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                
                [alertView addAction:ok];
           
            }
        });
        
        
    }];
    
    [dataTask resume];
    
    
//                                }];
//    UIAlertAction* noButton = [UIAlertAction
//                               actionWithTitle:@"No"
//                               style:UIAlertActionStyleDefault
//                               handler:^(UIAlertAction * action)
//                               {
//                                   //What we write here????????**
//                                   NSLog(@"you pressed No, thanks button");
//                                   // call method whatever u need
//                               }];
//    
//    [alert addAction:yesButton];
//    [alert addAction:noButton];
//
//    
    
}
*/
@end
