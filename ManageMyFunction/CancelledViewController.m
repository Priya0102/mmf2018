//
//  CancelledViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 10/6/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "CancelledViewController.h"

@interface CancelledViewController ()

@end

@implementation CancelledViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _serviceproviderid.text=_service_provider_id_str;
    _bookid.text=_book_id_str;
    
    [[NSUserDefaults standardUserDefaults]setValue:self.bookid.text forKey:@"book_id"];
    NSLog(@"book_id = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"book_id"]);
    
    [[NSUserDefaults standardUserDefaults]setValue:self.serviceproviderid.text forKey:@"service_provider_id"];
    NSLog(@"service_provider_id = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"service_provider_id"]);

}
-(void)viewWillAppear:(BOOL)animated
{
    [self getBookingDetails];
    
   
    
}
-(void)getBookingDetails{
    
    
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"];
    NSLog(@"Book id*** = %@", [[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"]);
    
    
    NSString *myst=[NSString stringWithFormat:@"book_id=%@",savedvalue];
    
    NSLog(@"##Book id==%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSString *urlstr=@"http://localhost/phpmyadmin/MMF/get_booking_details.php";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"Data is nil");
        }
        else{
            NSLog(@"RESPONSE VENUE DETAILS===%@",response);
            
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr=[outerdic objectForKey:@"booking_details"];
            for (NSDictionary *temp in arr) {
                NSString *str1=[temp objectForKey:@"book_id"];
                NSString *str2=[temp objectForKey:@"service_provider_id"];
                NSString *str3=[temp objectForKey:@"user_event_id"];
                NSString *str4=[temp objectForKey:@"user_id"];
                NSString *str5=[temp objectForKey:@"event_type_id"];
                NSString *str6=[temp objectForKey:@"event_date_from"];
                NSString *str7=[temp objectForKey:@"event_date_to"];
                NSString *str8=[temp objectForKey:@"event_time_from"];
                NSString *str9=[temp objectForKey:@"event_time_to"];
                NSString *str10=[temp objectForKey:@"no_of_guests"];
                NSString *str11=[temp objectForKey:@"requested_date"];
                // NSString *str12=[temp objectForKey:@"confirmed_date"];
                NSString *str13=[temp objectForKey:@"is_paid"];
                NSString *str14=[temp objectForKey:@"is_confirmed"];
                NSString *str15=[temp objectForKey:@"service_provider_user_id"];
                NSString *str16=[temp objectForKey:@"first_name"];
                NSString *str17=[temp objectForKey:@"last_name"];
                NSString *str18=[temp objectForKey:@"contact"];
                //NSString *str19=[temp objectForKey:@"address"];
                NSString *str20=[temp objectForKey:@"service_name"];
                NSString *str21=[temp objectForKey:@"established_year"];
                NSString *str22=[temp objectForKey:@"event_name"];
                
                //                    NSLog(@"book_id=%@ \n service_provider_id=%@ \n user_event_id=%@ \n user_id=%@ \n event_type_id=%@ \n event_date_from=%@ \n event_date_to=%@ \n event_time_from=%@ \n event_time_to=%@ \n no_of_guests=%@ \n requested_date=%@ \n confirmed_date=%@ \n is_paid=%@\n is_confirmed=%@ \n  service_provider_user_id=%@ \n first_name=%@ \n last_name=%@ \n contact=%@ \n address=%@ \n Service Name==%@ \n Established yr==%@ \n event_name=%@",str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str14,str15,str16,str17,str18,str19,str20,str21,str22);
                NSLog(@"book_id=%@ \n service_provider_id=%@ \n user_event_id=%@ \n user_id=%@ \n event_type_id=%@ \n event_date_from=%@ \n event_date_to=%@ \n event_time_from=%@ \n event_time_to=%@ \n no_of_guests=%@ \n requested_date=%@ \n is_paid=%@\n is_confirmed=%@ \n  service_provider_user_id=%@ \n first_name=%@ \n last_name=%@ \n contact=%@ \n Service Name==%@ \n Established yr==%@ \n event_name=%@",str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str13,str14,str15,str16,str17,str18,str20,str21,str22);
                {
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        _book_id_str=str1;
                        _service_provider_id_str=str2;
                        _usereventidStr=str3;
                        _user_idStr=str4;
                        _eventTypeidStr=str5;
                        _eventDatefromStr=str6;
                        _eventDateToStr=str7;
                        _eventTimeFromStr=str8;
                        _evetTimeToStr=str9;
                        _guestStr=str10;
                        _requestedDateStr=str11;
                        //_confirmedDateStr=str12;
                        _is_paidStr=str13;
                        _is_ConfirmedStr=str14;
                        _serviceprovider_useridStr=str15;
                        _firstNameStr=str16;
                        _lastNameStr=str17;
                        _contactStr=str18;
                        //_addressStr=str19;
                        _serviceNameStr=str20;
                        _establishedStr=str21;
                        _eventNameStr=str22;
                        
                        
                        //                            if ([_addressStr isEqual:[NSNull null]]) {
                        //                                _addressStr=@"--";
                        //                            }
                        //                            else{
                        //                                _addressStr=str19;
                        //                            }
                        
                        
                        //                            if ([_confirmedDateStr isEqual:[NSNull null]]) {
                        //                                _confirmedDateStr=@"--";
                        //                            }
                        //                            else{
                        //                                _confirmedDateStr=str12;
                        //                            }
                        //
                        
                        _bookid.text=_book_id_str;
                        _serviceproviderid.text=_service_provider_id_str;
                        _userEventId.text=_usereventidStr;
                        _userid.text=_user_idStr;
                        _eventTypeId.text=_eventTypeidStr;
                        _startDate.text=_eventDatefromStr;
                        _endDate.text=_eventDateToStr;
                        _startTime.text=_eventTimeFromStr;
                        _endTime.text=_evetTimeToStr;
                        _guestCount.text=_guestStr;
                        _requestedDate.text=_requestedDateStr;
                        // _confirmedDate.text=_confirmedDateStr;
                        _isPaid.text=_is_paidStr;
                        _isConfirmed.text=_is_ConfirmedStr;
                        _serviceProviderUserId.text=_serviceprovider_useridStr;
                        _firstname.text=_firstNameStr;
                        _lastname.text=_lastNameStr;
                        _contact.text=_contactStr;
                        //_address.text=_addressStr;
                        _serviceName.text=_serviceNameStr;
                        _eastablished.text=_establishedStr;
                        _eventName.text=_eventNameStr;
                        
                        NSString *name=[NSString stringWithFormat:@"%@ %@",_firstNameStr,_lastNameStr];
                        
                        _name.text=name;
                        
                        [[NSUserDefaults standardUserDefaults]setValue:self.userid.text forKey:@"user_id"];
                        NSLog(@"****user_id**** = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]);
                        
                        //                            if ([_is_ConfirmedStr isEqualToString:@"2"]) {
                        //                                NSLog(@"Pending...");
                        //                                _status.text = @"Pending";
                        //                                _status.textColor=[UIColor redColor];
                        //                            }
                        //                            if([_is_ConfirmedStr isEqualToString:@"1"] || [_is_paidStr isEqualToString:@"0"]) {
                        //                                NSLog(@"Confirmed...");
                        //                                _status.text = @"Confirmed";
                        //                                _status.textColor=[UIColor greenColor];
                        //                            }
                        //
                        //                            if([_is_ConfirmedStr isEqualToString:@"2"] || [_is_paidStr isEqualToString:@"1"]) {
                        //                                NSLog(@"Booked...");
                        //                                _status.text = @"Booked";
                        //                                _status.textColor=[UIColor blueColor];
                        //                            }
                        //                            if ([_is_ConfirmedStr isEqualToString:@"0"] || [_is_paidStr isEqualToString:@"0"]) {
                        //                                NSLog(@"Cancelled...");
                        //                                _status.text = @"Cancelled";
                        //                                _status.textColor=[UIColor blackColor];
                        //                            }
                        //                            if([_is_ConfirmedStr isEqualToString:@"3"] || [_is_ConfirmedStr isEqualToString:@"4"]) {
                        //                                NSLog(@"Cancelled by user...");
                        //                                _status.text = @"Cancelled by user";
                        //                                _status.textColor=[UIColor brownColor];
                        //                            }
                    }];
                }
            }
        }
    }];
    [task resume];
    
}


@end
