//
//  BlockDateViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 10/6/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "BlockDateViewController.h"

@interface BlockDateViewController ()

@end

@implementation BlockDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.startdate.delegate=self;
    self.enddate.delegate=self;
    self.startdate.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"startdate"];//if we uncomment this then save value will not reflect
    self.enddate.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"enddate"];
    self.startTime.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"startTime"];
    self.endTime.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"endTime"];
    
    
    [self.blockButton addTarget:self action:@selector(blockedBtnClicked:) forControlEvents:UIControlEventTouchDown];

}
- (IBAction)blockedBtnClicked:(id)sender {
    
    NSLog(@"Block Button Clicked==%@",_blockButton);
    
    UIAlertController *alert=[UIAlertController
                              alertControllerWithTitle:@"ALERT" message:@"Are you sure you want to Block dates?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    [self blockedDatesParsing];
                                    NSLog(@"you pressed Yes, please button");
                                    //[self.navigationController popViewControllerAnimated:YES];
                                    
                                    // call method whatever u need
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   //What we write here????????**
                                   NSLog(@"you pressed No, thanks button");
                                   // call method whatever u need
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
//
//    [[NSUserDefaults standardUserDefaults]setValue:self.startdate.text forKey:@"startdate"];
//    [[NSUserDefaults standardUserDefaults]setValue:self.enddate.text forKey:@"enddate"];
//    [[NSUserDefaults standardUserDefaults]setValue:self.startTime.text forKey:@"startTime"];
//    [[NSUserDefaults standardUserDefaults]setValue:self.endTime.text forKey:@"endTime"];
    
    NSString *dateStart =_startdate.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDate *date = [dateFormatter dateFromString:dateStart];
    NSLog(@"Start date==%@,SDATE==%@",_startdate.text,date);
    
    
    NSString *dateEnd =_enddate.text;
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
    [dateFormatter1 setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDate *date1 = [dateFormatter1 dateFromString:dateEnd];
    NSLog(@"End date==%@,EDATE==%@",_enddate.text,date1);
    
    
    
    NSString *timeString =_startTime.text;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"hh:mm a";
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDate *time = [formatter dateFromString:timeString];
    NSLog(@"Start==%@,STime==%@",_startTime.text,time);
    
    
    
    NSString *timeEnd =_endTime.text;
    NSDateFormatter *timeFormatter1 = [[NSDateFormatter alloc] init];
    [timeFormatter1 setDateFormat:@"hh:mm a"];
    [timeFormatter1 setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDate *time1 = [timeFormatter1 dateFromString:timeEnd];
    NSLog(@"End==%@,ETime==%@",_endTime.text,time1);
    
    if (date>date1) {
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"End date must be greater than start date" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                             }];
        [alertView addAction:ok];
        [self presentViewController:alertView animated:YES completion:nil];
    }
    
    else if(date==date1)
    {
        
        if (time<time1)
        {
            
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"End time must be greater than start time" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alertView dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            
            [alertView addAction:ok];
            [self presentViewController:alertView animated:YES completion:nil];
            
        }
        else if (time==time1)
        {
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Both dates and time must not equal" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alertView dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            
            [alertView addAction:ok];
            [self presentViewController:alertView animated:YES completion:nil];
        }
        else{
            
            
            float diff=time1.timeIntervalSince1970-time.timeIntervalSince1970;
            
            int hours=(int)(diff/(3600));//total time difference divided by 3600 secs.
            NSLog(@"TIME Difference==%d",hours);
            //int hours=(int);
            
            [[NSUserDefaults standardUserDefaults] setInteger:hours forKey:@"hours"];
            
            [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"days"];
            
            
            
        }
    }
    else{
        float diff=date1.timeIntervalSince1970-date.timeIntervalSince1970;
        int days=(int)(diff/(24*3600));
        NSLog(@"Days Difference==%d",days);
        
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"hours"];
        [[NSUserDefaults standardUserDefaults] setInteger:days forKey:@"days"];
    }
    
    
    
}

-(void)blockedDatesParsing{
    
    NSLog(@"calender count service id = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"serviceproviderid"]);
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults] objectForKey:@"serviceproviderid"];
    
    NSString *myst=[NSString stringWithFormat:@"service_provider_id=%@&event_date_from=%@&event_date_to=%@&event_time_from=%@&event_time_to=%@&comments=%@",savedvalue,self.startdate.text,self.enddate.text,self.startTime.text,self.endTime.text,self.comments.text];
    
    
    NSLog(@"bLOCKED DETAILS**=%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *urlstr=@"http://localhost/phpmyadmin/MMF/insert_blocked_dates.php";
    
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
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
                [self presentViewController:alertView animated:YES completion:nil];
            }
            else
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Failure" message:@"Not updated successfully" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alertView dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                
                [alertView addAction:ok];
                [self presentViewController:alertView animated:YES completion:nil];
            }
        });
        
        
    }];
    
    [task resume];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
