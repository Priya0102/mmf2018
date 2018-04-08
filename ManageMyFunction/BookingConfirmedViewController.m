//
//  BookingConfirmedViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 10/5/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "BookingConfirmedViewController.h"
#import "BookingConfirmedTableViewCell.h"
#import "ConfirmedOtherDetailTableViewCell.h"
#import "ConfirmedFacility.h"
#import "ConfirmedOtherDetail.h"
#import "RecieptViewController.h"
@interface BookingConfirmedViewController ()

@end

@implementation BookingConfirmedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getEventAmount];
    [self getBookingDetails];
    [self getPaymentDetails];
    [self getOtherFacility];
    [super viewWillAppear:YES];
    [self.tableview reloadData];
    
    [self getOtherDetailsOfVenue];
    [self.tableview2 reloadData];
    
    
    _status.text=_statusStr;
    _serviceproviderid.text=_service_provider_id_str;
    _bookid.text=_book_id_str;
    

    
    [[NSUserDefaults standardUserDefaults]setValue:self.bookid.text forKey:@"book_id"];
    NSLog(@"book_id = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"book_id"]);
    
    [[NSUserDefaults standardUserDefaults]setValue:self.serviceproviderid.text forKey:@"service_provider_id"];
    NSLog(@"service_provider_id = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"service_provider_id"]);
    
    
    _otherfaciltyarr=[[NSMutableArray alloc]init];
    _otherdetailarr=[[NSMutableArray alloc]init];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _tableview2.delegate=self;
    _tableview2.dataSource=self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getBookingDetails];
    [self getPaymentDetails];
    [self getOtherFacility];
    [super viewWillAppear:YES];
    [self.tableview reloadData];
    
    [self getOtherDetailsOfVenue];
    [self.tableview2 reloadData];
    
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
                        
                    }];
                }
            }
        }
    }];
    [task resume];
    
}
-(void)getPaymentDetails{
    
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"];
    NSLog(@"bOOK ID=%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"]);
    
    NSString *myst=[NSString stringWithFormat:@"book_id=%@",savedvalue];
    NSLog(@"bOOK ID**=%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSString *urlstr=@"http://localhost/phpmyadmin/MMF/get_payment_details.php";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"dATA IS NIL");
        }
        else{
            NSLog(@"response payment details==%@",response);
            
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr=[outerdic objectForKey:@"payment_details"];
            for(NSDictionary *temp in arr){
                NSString *str1=[temp objectForKey:@"book_id"];
                NSString *str2=[temp objectForKey:@"payment_mode_id"];
                NSString *str3=[temp objectForKey:@"payment_type_id"];
                NSString *str4=[temp objectForKey:@"payment_date"];
                NSString *str5=[temp objectForKey:@"amount"];
                NSString *str6=[temp objectForKey:@"payment_type_name"];
                NSString *str7=[temp objectForKey:@"payment_mode_type"];
                NSString *str8=[temp objectForKey:@"cheque_no"];
                NSString *str9=[temp objectForKey:@"transaction_id"];
                NSString *str10=[temp objectForKey:@"bank_name"];
                
                NSLog(@"PAYMENT book id==%@",str1);
                {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        _book_id_str=str1;
                        _paymentmodeidStr=str2;
                        _paymenttypeidStr=str3;
                        _paymentDateStr=str4;
                        _amountStr=str5;
                        _paymentTypeNameStr=str6;
                        _paymentModeTypeStr=str7;
                        _chequeStr=str8;
                        _transactionidStr=str9;
                        _bankNameStr=str10;
                        
                        _bookid.text=_book_id_str;
                        _paymentModeId.text=_paymentmodeidStr;
                        _paymentTypeId.text=_paymenttypeidStr;
                        _paymentDate.text=_paymentDateStr;
                        _amount.text=_amountStr;
                        _paymentTypeName.text=_paymentTypeNameStr;
                        _paymentModeType.text=_paymentModeTypeStr;
                        _cheque.text=_chequeStr;
                        _transaction_id.text=_transactionidStr;
                        _bankName.text=_bankNameStr;
                        
                        
                    }];
                }
            }
        }
    }];
    
    [task resume];
    
}
-(void)getOtherFacility{
    
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"];
    NSLog(@"bOOK ID=%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"]);
    
    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"user_id"];
    NSLog(@"User ID=%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"user_id"]);
    
    NSString *myst=[NSString stringWithFormat:@"book_id=%@&user_id=%@",savedvalue,savedvalue2];
    NSLog(@"bOOK ID & User ID**=%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSString *urlstr=@"http://localhost/phpmyadmin/MMF/get_other_facility.php";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"dATA IS NIL");
        }
        else{
            NSLog(@"response other facility==%@",response);
            
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr=[outerdic objectForKey:@"other_facility"];
            NSLog(@"oTHER fACILITY Array=%@",arr);
            
            for(NSDictionary *temp in arr){
                ConfirmedFacility *f=[[ConfirmedFacility alloc]init];
                f.otherfacilityIdStr=temp[@"other_facility_id"];
                f.facilityNameStr=temp[@"facility_name"];
                f.bookIdStr=temp[@"book_id"];
                f.quantityStr=temp[@"quantity"];
                f.priceStr=temp[@"price"];
                
                [_otherfaciltyarr addObject:f];
                [_tableview reloadData];
            }
            [_tableview reloadData];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableview reloadData];
        });
        
    }];
    
    [task resume];
    [_tableview reloadData];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if(tableView == self.tableview){
        return  1;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.tableview) {
        return _otherfaciltyarr.count;
    }
    return _otherdetailarr.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (tableView==self.tableview) {
        BookingConfirmedTableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        ConfirmedFacility *f=self.otherfaciltyarr[indexPath.row];
        
        cell.otherFacilityId.text=f.otherfacilityIdStr;
        cell.facilityName.text=f.facilityNameStr;
        cell.bookId.text=f.bookIdStr;
        cell.quantity.text=f.quantityStr;
        cell.price.text=f.priceStr;
        
    }
    
    else if (tableView==self.tableview2){
        ConfirmedOtherDetailTableViewCell *cell=[_tableview2 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        ConfirmedOtherDetail *o=self.otherdetailarr[indexPath.row];
        
        cell.bookid.text=o.bookIdStr;
        cell.serviceproviderid.text=o.serviceProvideridStr;
        cell.otherDetailsId.text=o.otherdetailsIdStr;
        cell.otherDetailInfo.text=o.otherdetailsInfoStr;
        cell.otherDetailsType.text=o.otherdetailstypeStr;
        cell.eventTypeId.text=o.eventTypeIdstr;
    }
    return cell;
}
-(void)getOtherDetailsOfVenue{
    
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"];
    NSLog(@"bOOK ID=%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"]);
    
    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"service_provider_id"];
    NSLog(@"service_provider_id ID=%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"service_provider_id"]);
    
    NSString *myst=[NSString stringWithFormat:@"book_id=%@&service_provider_id=%@",savedvalue,savedvalue2];
    NSLog(@"bOOK ID & service_provider_id ID**=%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSString *urlstr=@"http://localhost/phpmyadmin/MMF/get_other_detailsofvenue.php";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"dATA IS NIL");
        }
        else{
            NSLog(@"response other details of venue==%@",response);
            
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr=[outerdic objectForKey:@"detailsofvenue"];
            NSLog(@"oTHER detailsofvenue Array=%@",arr);
            
            for(NSDictionary *temp in arr){
                ConfirmedOtherDetail *o=[[ConfirmedOtherDetail alloc]init];
                o.bookIdStr=temp[@"book_id"];
                o.serviceProvideridStr=temp[@"service_provider_id"];
                o.otherdetailsIdStr=temp[@"other_details_id"];
                o.otherdetailstypeStr=temp[@"other_details_type"];
                o.otherdetailsInfoStr=temp[@"other_details_info"];
                o.eventTypeIdstr=temp[@"event_type_id"];
                
                
                [_otherdetailarr addObject:o];
                [_tableview2 reloadData];
            }
            [_tableview2 reloadData];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableview2 reloadData];
        });
        
    }];
    
    [task resume];
    [_tableview2 reloadData];
    
    
}

 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
//    RecieptViewController *rvc=[segue destinationViewController];
//
//    rvc.serviceNameStr=_serviceName.text;
//    rvc.addressStr=_address.text;
//    rvc.contactStr=_contact.text;
//    rvc.nameStr=_name.text;
//    rvc.contactCustomerStr=_contact.text;
//    rvc.eventNameStr=_eventName.text;
//    rvc.eventAddressStr=_address.text;
//    rvc.startTimeStr=_startTime.text;
//    rvc.endTimeStr=_endTime.text;
//    rvc.startDateStr=_startDate.text;
//    rvc.endDateStr=_endDate.text;
//    rvc.totalAmountStr=_totalAmount.text;
    
  
}
- (IBAction)totalAmountChanged:(id)sender {
     
     UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Change amount"
     message: @"Please enter amount"
     preferredStyle:UIAlertControllerStyleAlert];
     [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
     textField.placeholder = @"Enter amount";
     textField.textColor = [UIColor blueColor];
     textField.clearButtonMode = UITextFieldViewModeWhileEditing;
     textField.borderStyle = UITextBorderStyleRoundedRect;
     }];
     [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
     textField.placeholder = @"Enter Comment";
     textField.textColor = [UIColor blueColor];
     textField.clearButtonMode = UITextFieldViewModeWhileEditing;
     textField.borderStyle = UITextBorderStyleRoundedRect;
     
     }];
     [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
     NSArray * textfields = alertController.textFields;
     UITextField * namefield = textfields[0];
     UITextField * passwordfiled = textfields[1];
     NSLog(@"%@:%@",namefield.text,passwordfiled.text);
     
     //[self getEventAmount];
     [self getEventComment];
     }]];
     
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
     NSLog(@"Canelled");
     }];
     [alertController addAction:cancelAction];
     [self presentViewController:alertController animated:YES completion:nil];
     
     
     }
- (IBAction)depositAmountChanged:(id)sender {
     UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Change amount"
     message: @"Please enter amount"
     preferredStyle:UIAlertControllerStyleAlert];
     [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
     textField.placeholder = @"Enter amount";
     textField.textColor = [UIColor blueColor];
     textField.clearButtonMode = UITextFieldViewModeWhileEditing;
     textField.borderStyle = UITextBorderStyleRoundedRect;
     }];
     [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
     textField.placeholder = @"Enter Comment";
     textField.textColor = [UIColor blueColor];
     textField.clearButtonMode = UITextFieldViewModeWhileEditing;
     textField.borderStyle = UITextBorderStyleRoundedRect;
     
     }];
     [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
     NSArray * textfields = alertController.textFields;
     UITextField * namefield = textfields[0];
     UITextField * passwordfiled = textfields[1];
     NSLog(@"%@:%@",namefield.text,passwordfiled.text);
     
    // [self getEventAmount];
     [self getEventComment];
     }]];
     
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
     NSLog(@"Canelled");
     }];
     [alertController addAction:cancelAction];
     [self presentViewController:alertController animated:YES completion:nil];
     }
- (IBAction)advancePaymentChanged:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Change amount"
                                                                              message: @"Please enter amount"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter amount";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter Comment";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
        UITextField * passwordfiled = textfields[1];
        NSLog(@"%@:%@",namefield.text,passwordfiled.text);
        
        //[self getEventAmount];
        [self getEventComment];
    }]];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Canelled");
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}
-(void)getEventAmount{
        
        NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"];
        NSLog(@"bOOK ID=%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"]);
        
        NSString *myst=[NSString stringWithFormat:@"book_id=%@",savedvalue];
        NSLog(@"bOOK ID**=%@",myst);
        
        NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        NSString *urlstr=@"http://localhost/phpmyadmin/MMF/get_event_amount.php";
        NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data==nil) {
                NSLog(@"dATA IS NIL");
            }
            else{
                NSLog(@"response amountdetails ==%@",response);
                
                NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSArray *arr=[outerdic objectForKey:@"amountdetails"];
                
                for(NSDictionary *temp in arr){
                    NSString *str1=[temp objectForKey:@"book_id"];
                    NSString *str2=[temp objectForKey:@"amount_type"];
                    NSString *str3=[temp objectForKey:@"event_amount_id"];
                    NSString *str4=[temp objectForKey:@"id"];
                    NSString *str5=[temp objectForKey:@"price"];
                    
                    NSLog(@"PAYMENT book id==%@",str1);
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            _book_id_str=str1;
                            _amountTypeStr=str2;
                            _eventAmountIdStr=str3;
                            _idStr=str4;
                            _priceStr=str5;
                            
                            _bookid.text=_book_id_str;
                            _amountType.text=_amountTypeStr;
                            _eventAmountId.text=_eventAmountIdStr;
                            _idlbl.text=_idStr;
                            _price.text=_priceStr;
                            
                            NSString *tempstr=_eventAmountIdStr;
                            NSLog(@"event amount id=%@",_eventAmountIdStr);
                          
                            NSLog(@"temp str==%@",tempstr);
                            
                            if([tempstr isEqualToString:@"1"])
                            {
                                _totalAmount.text=_priceStr;
                                 NSLog(@"totalAmount==%@",_priceStr);
                                
                                [[NSUserDefaults standardUserDefaults]setValue:_totalAmount.text forKey:@"totalamount"];
                                NSLog(@"CONFIRMED total amount= %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"totalamount"]);
                                
                            }
                           else if([tempstr isEqualToString:@"5"])
                            {
                                _advanceamount.text=_priceStr;
                                 NSLog(@"ADVANCE Amount==%@",_priceStr);
                                
                                [[NSUserDefaults standardUserDefaults]setValue:_advanceamount.text forKey:@"advanceamount"];
                                NSLog(@"CONFIRMED advance amount= %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"advanceamount"]);
                            }
                           else if([tempstr isEqualToString:@"3"])
                           {
                               _depositamount.text=_priceStr;
                               NSLog(@"dEPOSIT Amount==%@",_depositamount.text);
                               
                               [[NSUserDefaults standardUserDefaults]setValue:_depositamount.text forKey:@"depositamount"];
                               NSLog(@"CONFIRMED deposit amount= %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"depositamount"]);
                           }
                            
                            NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
                            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                            
                            int number1 = [[formatter numberFromString:_totalAmount.text] intValue];
                            int number2 = [[formatter numberFromString:_advanceamount.text] intValue];
                            
                            NSString *netresult = [NSString stringWithFormat:@"%d", number1 - number2];
                            NSLog(@"net result==%@",netresult);
                            
                            [[NSUserDefaults standardUserDefaults]setValue:netresult forKey:@"netamount"];
                            
                            NSLog(@"NET amount= %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"netamount"]);
                            
                        }];
                    }
                }
            }
        }];
        
        [task resume];
        
        
    }
-(void)getEventComment{
    
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"];
    NSLog(@"*bOOK ID=%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"]);
    
    NSString *myst=[NSString stringWithFormat:@"book_id=%@",savedvalue];
    NSLog(@"**bOOK ID**=%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSString *urlstr=@"http://localhost/phpmyadmin/MMF/get_event_comment.php";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"dATA IS NIL");
        }
        else{
            NSLog(@"response amountdetails ==%@",response);
            
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr=[outerdic objectForKey:@"getcomment"];
            
            for(NSDictionary *temp in arr){
                NSString *str1=[temp objectForKey:@"book_id"];
                NSString *str2=[temp objectForKey:@"comment_type"];
                NSString *str3=[temp objectForKey:@"event_comment_id"];
                NSString *str4=[temp objectForKey:@"id"];
                NSString *str5=[temp objectForKey:@"comments"];
                
                NSLog(@"Comment book id==%@",str1);
                {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        _book_id_str=str1;
                        _commentTypeStr=str2;
                        _eventCommentIdStr=str3;
                        _idStr=str4;
                        _commentStr=str5;
                        
                        _bookid.text=_book_id_str;
                        
                        
                        _commentType.text=_commentTypeStr;
                        _eventCommentId.text=_eventCommentIdStr;
                        _commentidlbl.text=_idStr;
                        _comments.text=_commentStr;
                        
                        
                        
                    }];
                }
            }
        }
    }];
    
    [task resume];
    
    
}
   
@end
