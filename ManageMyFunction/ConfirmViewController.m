//
//  ConfirmViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 8/21/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "ConfirmViewController.h"
#import "Attendee.h"
#import "Checkbox.h"
@interface ConfirmViewController ()
{
    Checkbox *cbox;
}
@end

@implementation ConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
   cbox = [[Checkbox alloc] initWithFrame:CGRectMake(20,408,100,20)];
   
   // cbox.text = @"Checked";
    cbox.showTextLabel = YES;
    cbox.labelFont = [UIFont systemFontOfSize:10];
    [cbox addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cbox];


  
    
    _address.delegate=self;
    _eventname.delegate=self;
    
    

    
    _bookBtnClicked.layer.borderWidth = 1;
    _bookBtnClicked.layer.cornerRadius = 5;
    _bookBtnClicked.clipsToBounds = YES;
    
    _cancelBtnClicked.layer.borderWidth = 1;
    _cancelBtnClicked.layer.cornerRadius = 5;
    _cancelBtnClicked.clipsToBounds = YES;
    
    
    
    Attendee *a1=[[Attendee alloc]init];
    
    self.myprofile=[[NSMutableArray alloc]init];
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    
    
    NSString *myst=[NSString stringWithFormat:@"username=%@",savedValue];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/getprofile.php"];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if(error)
    {
    }
    
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          if(error)
                                          {
                                          }
                                          
                                          NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                          NSError *er=nil;
                                          NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
                                          if(er)
                                          {
                                          }
                                          
                                          NSArray *profile=[responseDict objectForKey:@"getprofile"];
                                          
                                          for(NSDictionary * dict in profile)
                                          {
                                              
                                              a1.first_name=dict[@"first_name"];
                                              a1.last_name=[dict objectForKey:@"last_name"];
                                              a1.contact=[dict objectForKey:@"contact"];
                                              a1.address=[dict objectForKey:@"address"];
                                              a1.image_name=[dict objectForKey:@"image_name"];
                                              a1.is_active=[dict objectForKey:@"is_active"];
                                              a1.is_tiedup=[dict objectForKey:@"is_tiedup"];
                                              a1.image_extension=dict[@"image_extension"];
                                              a1.username=dict[@"username"];
                                              a1.userid=dict[@"user_id"];
                                              self.userid=dict[@"user_id"];
                                              // self.myid=dict[@"id"];
                                              
                                              [self.myprofile addObject:a1];
                                              
                                              
                                          }
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              
                                              if(a1.first_name==(NSString *) [NSNull null])
                                              {
                                                  a1.first_name=@"not given";
                                              }
                                              if(a1.last_name==(NSString *) [NSNull null])
                                              {
                                                  a1.last_name=@"not given";
                                              }
                                              if(a1.contact==(NSString *) [NSNull null])
                                              {
                                                  a1.contact=@"";
                                              }
                                              if(a1.address==(NSString *) [NSNull null])
                                              {
                                                  a1.address=@"not given";
                                              }
                                              if(a1.image_name==(NSString *) [NSNull null])
                                              {
                                                  a1.image_name=@"not given";
                                              }
                                              if(a1.is_active==(NSString *) [NSNull null])
                                              {
                                                  a1.is_active=@"";
                                              }
                                              if(a1.is_tiedup==(NSString *) [NSNull null])
                                              {
                                                  a1.is_tiedup=@"";
                                              }
                                              if(a1.image_extension==(NSString *) [NSNull null])
                                              {
                                                  a1.image_extension=@"---";
                                              }
                                              if(a1.username==(NSString *) [NSNull null])
                                              {
                                                  a1.username=@"---";
                                              }
                                              
                                              _name.text=[a1.first_name stringByAppendingFormat:@"%s %@","", a1.last_name];
                                              
                                              
                                              self.contact.text=a1.contact;
                                              NSLog(@"Contact==%@",self.contact.text);
                                              self.address.text=a1.address;
                                              self.username.text=a1.username;
                                             
//                                              [[NSUserDefaults standardUserDefaults]setValue:self.address.text forKey:@"address"];
//                                              NSLog(@"address = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"address"]);
                                              
                                              [[NSUserDefaults standardUserDefaults] setObject:a1.userid forKey:@"user_id"];
                                              
                                          });
                                      }];
    
    [dataTask resume];
    
    
}
- (void) checkAction{
    
    if (cbox.isChecked == true) {
        //cbox.text = @"Checked";
    }
    else{
        //cbox.text = @"Unchecked";
    }
}

- (IBAction)bookBtnClicked:(id)sender {
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do you want to Book services?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //What we write here????????**
                                    [self bookServices];
                                    NSLog(@"you pressed Yes, please button");
                                    [self.navigationController popViewControllerAnimated:YES];
                                    
                                    // call method whatever u need
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
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
    
}
-(void)bookServices
{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    NSString *startDate = [prefs stringForKey:@"startdate"];
    NSString *endDate = [prefs stringForKey:@"enddate"];
    NSString *startTime = [prefs stringForKey:@"startTime"];
    NSString *endTime = [prefs stringForKey:@"endTime"];
    NSInteger myInt = [prefs integerForKey:@"user_id"];
    NSString *city = [prefs stringForKey:@"city"];
    NSString *eventName = [prefs stringForKey:@"eventName"];
    NSString *eventvenue = [prefs stringForKey:@"hotelName"];

    
    
    NSLog(@"Start Date=%@ End Date=%@ Start Time=%@ End Time=%@ User_id=%ld city=%@ Service Name=%@ Hotel Name=%@",startDate,endDate,startTime,endTime,(long)myInt,city,eventName,eventvenue);
    
    
    NSString *myst=[NSString stringWithFormat:@"start_date=%@&end_date=%@&start_time=%@&end_time=%@&user_id=%@&city=%@&event=%@event_venue=%@",startDate,endDate,startTime,endTime,_userid,city,eventName,eventvenue];
    
    
//    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"username"];//used to retrieve user's emailid which we have stored in nsuserdefaults for key email(those user login dat person mail id will get using userdefaults)
//    
//    NSString *myst=[NSString stringWithFormat:@"username=%@ ",savedValue];

    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/book_user_event.php"];
    
    NSMutableURLRequest *urlrequest=[NSMutableURLRequest requestWithURL:url];
    [urlrequest setHTTPMethod:@"POST"];
    [urlrequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if(error)
    {
        NSLog(@"%@",error.description);
    }
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:urlrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    if (error)
                                    {
                                        NSLog(@"%@",error.description);
                                    }
                                    NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                    NSLog(@"data =%@",text);
                                    NSError *error1=nil;
                                    NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                    if(error1)
                                    {
                                        NSLog(@"error 1 is %@",error1.description);
                                    }
                                    
//                                    self.success=[responsedict objectForKey:@"success"];
//                                    
//                                    
//                                    dispatch_async(dispatch_get_main_queue(), ^{
//                                        
//                                        if([self.success isEqualToString:@"1"])
//                                        {
//                                            self.user_event_id=[responsedict objectForKey:@"user_event_id"];
//                                
//                                            NSLog(@"User event id==%@",self.user_event_id);
//                                            
//                                        }
//                                        else
//                                        {
//                                            NSLog(@"Error.......");
//                                        }
//                                    });
                                    
                                    
                                    NSLog(@"json book user event= %@",responsedict);
        
                                }];
    [task resume];
    
    
   
    
    NSUserDefaults *prefs2 = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    NSString *serviceproviderid = [prefs2 stringForKey:@"serviceproviderid"];

    NSString *myst2=[NSString stringWithFormat:@"service_provider_id=%@&user_event_id=%d",serviceproviderid,1];
    
    NSLog(@"My st2===%@",myst2);
    
    NSURLSessionConfiguration *config2=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session2=[NSURLSession sessionWithConfiguration:config2 delegate:self delegateQueue:nil];
    NSURL * url2 = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/booking_master.php"];
    
    NSMutableURLRequest *urlrequest2=[NSMutableURLRequest requestWithURL:url2];
    [urlrequest2 setHTTPMethod:@"POST"];
    [urlrequest2 setHTTPBody:[myst2 dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error2=nil;
    if(error2)
    {
        NSLog(@"%@",error2.description);
    }
    
    NSURLSessionDataTask *task2=[session2 dataTaskWithRequest:urlrequest2 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error2)
                                {
                                    if (error2)
                                    {
                                        NSLog(@"%@",error2.description);
                                    }
                                    NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                    NSLog(@"data booking master=%@",text);
                                    NSError *error1=nil;
                                    NSDictionary *responsedict2=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                    if(error1)
                                    {
                                        NSLog(@"error 1 is %@",error1.description);
                                    }
                                    NSLog(@"json booking master= %@",responsedict2);
                                    
                                    
                                }];
    [task2 resume];

    NSUserDefaults *prefs3 = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    NSString *eventDateFrom = [prefs3 stringForKey:@"startdate"];
    NSString *eventDateTo = [prefs3 stringForKey:@"enddate"];
    NSString *eventTimeFrom = [prefs3 stringForKey:@"startTime"];
    NSString *eventTimeTo = [prefs3 stringForKey:@"endTime"];
    NSString *guestcount = [prefs3 stringForKey:@"guestcount"];
    
    
    NSString *myst3=[NSString stringWithFormat:@"book_id=%d&event_date_from=%@&event_date_to=%@&event_time_from=%@&event_time_to=%@&no_of_guests=%@",1,eventDateFrom,eventDateTo,eventTimeFrom,eventTimeTo,guestcount];
    
    NSLog(@"My st3===%@",myst3);
    
    NSURLSessionConfiguration *config3=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session3=[NSURLSession sessionWithConfiguration:config3 delegate:self delegateQueue:nil];
    NSURL * url3 = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/booked_venue_details.php"];
    
    NSMutableURLRequest *urlrequest3=[NSMutableURLRequest requestWithURL:url3];
    [urlrequest3 setHTTPMethod:@"POST"];
    [urlrequest3 setHTTPBody:[myst3 dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error3=nil;
    if(error3)
    {
        NSLog(@"%@",error3.description);
    }
    
    NSURLSessionDataTask *task3=[session3 dataTaskWithRequest:urlrequest3 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error3)
                                 {
                                     if (error3)
                                     {
                                         NSLog(@"%@",error3.description);
                                     }
                                     NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                     NSLog(@"data booked venue details=%@",text);
                                     NSError *error1=nil;
                                     NSDictionary *responsedict3=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                     if(error1)
                                     {
                                         NSLog(@"error 1 is %@",error1.description);
                                     }
                                     NSLog(@"json booked venue details= %@",responsedict3);
                                     
                                     
                                 }];
    [task3 resume];
    

  
    
    
    NSString *myst4=[NSString stringWithFormat:@"book_id=%d&event_amount_id=%d&total_amount=%d",1,12,2000];
    
    NSLog(@"My st4===%@",myst4);
    
    NSURLSessionConfiguration *config4=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session4=[NSURLSession sessionWithConfiguration:config4 delegate:self delegateQueue:nil];
    NSURL * url4 = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/booked_events_amount_map.php"];
    
    NSMutableURLRequest *urlrequest4=[NSMutableURLRequest requestWithURL:url4];
    [urlrequest4 setHTTPMethod:@"POST"];
    [urlrequest4 setHTTPBody:[myst4 dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error4=nil;
    if(error4)
    {
        NSLog(@"%@",error4.description);
    }
    
    NSURLSessionDataTask *task4=[session4 dataTaskWithRequest:urlrequest4 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error4)
                                 {
                                     if (error4)
                                     {
                                         NSLog(@"%@",error4.description);
                                     }
                                     NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                     NSLog(@"data booked events amount=%@",text);
                                     NSError *error1=nil;
                                     NSDictionary *responsedict4=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                     if(error1)
                                     {
                                         NSLog(@"error 1 is %@",error1.description);
                                     }
                                     NSLog(@"json booked events amount= %@",responsedict4);
                                     
                                     
                                 }];
    [task4 resume];

    
     NSUserDefaults *prefs5 = [NSUserDefaults standardUserDefaults];
     NSString *comment = [prefs5 stringForKey:@"comments"];
    
    NSString *myst5=[NSString stringWithFormat:@"book_id=%d&event_comment_id=%d&comments=%@",1,12,comment];
    
    NSLog(@"My st5===%@",myst5);
    
    NSURLSessionConfiguration *config5=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session5=[NSURLSession sessionWithConfiguration:config5 delegate:self delegateQueue:nil];
    NSURL * url5 = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/booked_events_comment_map.php"];
    
    NSMutableURLRequest *urlrequest5=[NSMutableURLRequest requestWithURL:url5];
    [urlrequest5 setHTTPMethod:@"POST"];
    [urlrequest5 setHTTPBody:[myst5 dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error5=nil;
    if(error5)
    {
        NSLog(@"%@",error5.description);
    }
    
    NSURLSessionDataTask *task5=[session5 dataTaskWithRequest:urlrequest5 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error5)
                                 {
                                     if (error5)
                                     {
                                         NSLog(@"%@",error5.description);
                                     }
                                     NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                     NSLog(@"data booked events comment=%@",text);
                                     NSError *error1=nil;
                                     NSDictionary *responsedict5=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                     if(error1)
                                     {
                                         NSLog(@"error 1 is %@",error1.description);
                                     }
                                     NSLog(@"json booked events comment= %@",responsedict5);
                                     
                                     
                                 }];
    [task5 resume];
    
//    NSUserDefaults *prefs6 = [NSUserDefaults standardUserDefaults];
//    NSString *quantity = [prefs6 stringForKey:@"quantity"];
//    NSString *price = [prefs6 stringForKey:@"price"];

    NSString *myst6=[NSString stringWithFormat:@"book_id=%d&other_facility_id=%d&quantity=%d&price=%d",1,12,22,2222];
    
    NSLog(@"My st5===%@",myst6);
    
    NSURLSessionConfiguration *config6=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session6=[NSURLSession sessionWithConfiguration:config6 delegate:self delegateQueue:nil];
    NSURL * url6 = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/other_facilities_booking"];
    
    NSMutableURLRequest *urlrequest6=[NSMutableURLRequest requestWithURL:url6];
    [urlrequest6 setHTTPMethod:@"POST"];
    [urlrequest6 setHTTPBody:[myst6 dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error6=nil;
    if(error6)
    {
        NSLog(@"%@",error6.description);
    }
    
    NSURLSessionDataTask *task6=[session6 dataTaskWithRequest:urlrequest6 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error6)
                                 {
                                     if (error6)
                                     {
                                         NSLog(@"%@",error6.description);
                                     }
                                     NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                     NSLog(@"data other facilties booking=%@",text);
                                     NSError *error1=nil;
                                     NSDictionary *responsedict6=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                     if(error1)
                                     {
                                         NSLog(@"error 1 is %@",error1.description);
                                     }
                                     NSLog(@"json other facilties booking= %@",responsedict6);
                                     
                                     
                                 }];
    [task6 resume];

    
    NSString *myst7=[NSString stringWithFormat:@"book_id=%d&other_details_id=%d&other_details_info=%s",1,12,"sghdjg"];
    
    NSLog(@"My st7===%@",myst7);
    
    NSURLSessionConfiguration *config7=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session7=[NSURLSession sessionWithConfiguration:config7 delegate:self delegateQueue:nil];
    NSURL * url7 = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/booked_other_details"];
    
    NSMutableURLRequest *urlrequest7=[NSMutableURLRequest requestWithURL:url7];
    [urlrequest7 setHTTPMethod:@"POST"];
    [urlrequest7 setHTTPBody:[myst7 dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error7=nil;
    if(error7)
    {
        NSLog(@"%@",error7.description);
    }
    
    NSURLSessionDataTask *task7=[session7 dataTaskWithRequest:urlrequest7 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error6)
                                 {
                                     if (error6)
                                     {
                                         NSLog(@"%@",error6.description);
                                     }
                                     NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                     NSLog(@"data booked_other_details=%@",text);
                                     NSError *error1=nil;
                                     NSDictionary *responsedict6=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                     if(error1)
                                     {
                                         NSLog(@"error 1 is %@",error1.description);
                                     }
                                     NSLog(@"json booked_other_details= %@",responsedict6);
                                     
                                     
                                 }];
    [task7 resume];
    

   // [self bookedOtherDetails];
    
    
}
//-(void)bookedOtherDetails{
//    
//    NSString *myst7=[NSString stringWithFormat:@"book_id=%d&other_details_id=%d&other_details_info=%s",1,12,"sghdjg"];
//    
//    NSLog(@"My st7===%@",myst7);
//    
//    NSURLSessionConfiguration *config7=[NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session7=[NSURLSession sessionWithConfiguration:config7 delegate:self delegateQueue:nil];
//    NSURL * url7 = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/booked_other_details"];
//    
//    NSMutableURLRequest *urlrequest7=[NSMutableURLRequest requestWithURL:url7];
//    [urlrequest7 setHTTPMethod:@"POST"];
//    [urlrequest7 setHTTPBody:[myst7 dataUsingEncoding:NSUTF8StringEncoding]];
//    NSError *error7=nil;
//    if(error7)
//    {
//        NSLog(@"%@",error7.description);
//    }
//    
//    NSURLSessionDataTask *task7=[session7 dataTaskWithRequest:urlrequest7 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error6)
//                                 {
//                                     if (error6)
//                                     {
//                                         NSLog(@"%@",error6.description);
//                                     }
//                                     NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                                     NSLog(@"data booked_other_details=%@",text);
//                                     NSError *error1=nil;
//                                     NSDictionary *responsedict6=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
//                                     if(error1)
//                                     {
//                                         NSLog(@"error 1 is %@",error1.description);
//                                     }
//                                     NSLog(@"json booked_other_details= %@",responsedict6);
//                                     
//                                     
//                                 }];
//    [task7 resume];
//
//    
//    
//    
//}
- (IBAction)cancelBtnClicked:(id)sender {
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do you want to Cancel services?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //What we write here????????**
                                    [self cancelServices];
                                    NSLog(@"you pressed Yes, please button");
                                    [self.navigationController popViewControllerAnimated:YES];
                                    
                                    // call method whatever u need
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
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
    
    

}
-(void)cancelServices
{
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"username"];//used to retrieve user's emailid which we have stored in nsuserdefaults for key email(those user login dat person mail id will get using userdefaults)
    
    NSString *myst=[NSString stringWithFormat:@"username=%@",savedValue];
    NSLog(@"Username===%@",myst);
    // NSString *myst=[NSString stringWithFormat:@"emailid=rohini@anveshak.com & session_id=s2"];
    
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/book_services.php"];
    
    NSMutableURLRequest *urlrequest=[NSMutableURLRequest requestWithURL:url];
    [urlrequest setHTTPMethod:@"POST"];
    [urlrequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if(error)
    {
        NSLog(@"%@",error.description);
    }
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:urlrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    if (error)
                                    {
                                        NSLog(@"%@",error.description);
                                    }
                                    NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                    NSLog(@"data=%@",text);
                                    NSError *error1=nil;
                                    NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                    if(error1)
                                    {
                                        NSLog(@"error 1 is %@",error1.description);
                                    }
                                    NSLog(@"json = %@",responsedict);
                                    
                                    
                                }];
    [task resume];
}


@end
