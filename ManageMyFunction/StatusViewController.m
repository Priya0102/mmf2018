//
//  StatusViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 8/31/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "StatusViewController.h"
#import "NIDropDown.h"
#import <QuartzCore/QuartzCore.h>
#import "Attendee.h"
#import "Status.h"
#import "StatusTableViewCell.h"
#import "BookingDetailsViewController.h"
#import "BookedStatusViewController.h"
#import "BookingConfirmedViewController.h"
#import "CancelledViewController.h"
#import "WebViewController.h"
#import "CancelledUserViewController.h"
#import "BlockedTableViewCell.h"
#import "Blocked.h"

#define IDIOM UI_USER_INTERFACE_IDIOM()
#define IPAD UIUserInterfaceIdiomPad
#define kViolet [UIColor colorWithRed:170/255.0 green:114/255.0 blue:219/255.0 alpha:1.0]


@interface StatusViewController ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>
{
    NSMutableArray *keyarr1,*keyarr2;
}

@property (strong, nonatomic) NSDateFormatter *dateFormatter2,*dateFormatter1;

@property (strong, nonatomic) NSArray *datesWithEvent;
@property (strong, nonatomic) NSMutableArray *datesWithEventArr;

@end

@implementation StatusViewController
@synthesize venueBtnClicked;
//@synthesize showAllSections;

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // Initially we don't want all of our sections to be visible,
    // so we set the showAllSections to NO.
   // showAllSections = NO;
    
   _textView.editable=NO;
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
   
    
    _datesWithEventArr=[[NSMutableArray alloc]init];
    
    self.dateFormatter1 = [[NSDateFormatter alloc] init];
    self.dateFormatter1.dateFormat = @"dd-MM-yyyy";
    
    self.dateFormatter2 = [[NSDateFormatter alloc] init];
    self.dateFormatter2.dateFormat = @"yyyy-MM-dd";
  
    
    _statusArray=[[NSMutableArray alloc]init];
    _startDateArray=[[NSMutableArray alloc]init];
    _contactArray=[[NSMutableArray alloc]init];
    _firstNameArray=[[NSMutableArray alloc]init];
    _lastNameArray=[[NSMutableArray alloc]init];
    _serviceprovideridArray=[[NSMutableArray alloc]init];
    _bookidArray=[[NSMutableArray alloc]init];
    _useridArray=[[NSMutableArray alloc]init];
    _allstatusArr=[[NSMutableArray alloc]init];
    _blockedArray=[[NSMutableArray alloc]init];
    
    _alldate=[[NSMutableArray alloc]init];
  
     _que=[[NSOperationQueue alloc]init];
    self.calendar.selectionColor = [UIColor colorWithRed:0.203 green:0.666 blue:0.862 alpha:1.000];
    self.calendar.fontHeaderColor = [UIColor colorWithRed:0.203 green:0.666 blue:0.862 alpha:1.000];
    
    _calendar.allowsMultipleSelection=YES;
    _calendar.dataSource=self;
    _calendar.delegate=self;
    

    venueBtnClicked.layer.borderWidth = 1;
    venueBtnClicked.layer.borderColor = [[UIColor blackColor] CGColor];
    venueBtnClicked.layer.cornerRadius = 5;
    venueBtnClicked.clipsToBounds=YES;
    
    Attendee *a1=[[Attendee alloc]init];
    
    self.myprofile=[[NSMutableArray alloc]init];
    
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    
    NSString *myst=[NSString stringWithFormat:@"username=%@",savedValue];
    NSLog(@"Username===%@",myst);
    
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
                                          NSString *text = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
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
                                              if(a1.username==(NSString *) [NSNull null])
                                              {
                                                  a1.username=@"---";
                                              }
                                              
                                              _welcome_lbl.text=[@"Welcome, " stringByAppendingFormat:@"%@  %@ %s ",a1.first_name, a1.last_name,"! Here are your Bookings."];
                                              
                                              
                                          });
                                      }];
    
    [dataTask resume];
}
//- (void)viewDidUnload {
//   
//    venueBtnClicked = nil;
//    [self venueBtnClicked:nil];
//    [super viewDidUnload];
//}
- (NSArray *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventColorsForDate:(NSDate *)date
{
    
    return @[[UIColor yellowColor],appearance.eventDefaultColor,[UIColor yellowColor],appearance.eventDefaultColor];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tableview reloadData];

}


-(void)getCalendarCount{
    
NSBlockOperation *op2=[NSBlockOperation blockOperationWithBlock:^{
    
    NSLog(@"calender count service id = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"serviceproviderid"]);
    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults] objectForKey:@"serviceproviderid"];
    NSString *myst=[NSString stringWithFormat:@"service_provider_id=%@",savedvalue2];
    NSLog(@"SERVICE PROVIDER ID for calender count####.......%@",myst);
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
   NSString *urlstr=@"http://localhost/phpmyadmin/MMF/vm_dates.php";
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    if(data==nil)
                                    {
                                        NSLog(@"Data vm dates is nil");
                                    }
                                    else
                                    {
                                        NSLog(@"response vm_dates===***%@",response);
                                    NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        NSArray *arr=[outerdic objectForKey:@"pending"]; //pending
                                        NSLog(@"Array Pending==%@",arr);
                                        
                                        
                                        for(NSDictionary *temp in arr)
                                        {
                                            NSString *str1=[temp objectForKey:@"start_date"];
                                            NSString *str2=[temp objectForKey:@"end_date"];
                                            NSString *str3=[temp objectForKey:@"count"];
                                            
                                            
                                            [self.datesWithEventArr addObject:str1];
                                            //[self.datesWithEventArr addObject:str2];//showing dot for end date
                                            
                                           
                                            NSLog(@"Pending Start date===%@ Pending End date==%@ COUNT==%@",str1,str2,str3);
                                        
                                            {
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                    _eventDateFromstr=str1;
                                                    _eventDateTostr=str2;
                                                    _countstr=str3;
                                                }];
                                            }
                                        }
                                        _datesWithEvent=[_datesWithEventArr copy];
                                       
                                       NSLog(@"Date event pending ==%@",_datesWithEvent);
                                        
                                        NSArray *arr2=[outerdic objectForKey:@"confirmed"];//confirmed
                                        NSLog(@"Arrr confirmed==%@",arr2);
                                        
                                        for(NSDictionary *temp in arr2)
                                        {
                                            NSString *str1=[temp objectForKey:@"start_date"];
                                            NSString *str2=[temp objectForKey:@"end_date"];
                                            NSString *str3=[temp objectForKey:@"count"];
                      
                                            [self.datesWithEventArr addObject:str1];
                                            
                                            NSLog(@"Confirmed Start date===%@ Confirmed End date==%@ COUNT==%@",str1,str2,str3);
                                            {
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                    _eventDateFromstr=str1;
                                                    _eventDateTostr=str2;
                                                    _countstr=str3;
                                                    
                                                }];
                                            }
                                        }
                                        _datesWithEvent=[_datesWithEventArr copy];
                                        NSLog(@"Date event confirmed ==%@",_datesWithEvent);
                                        
                                        
                                        NSArray *arr3=[outerdic objectForKey:@"blocked"];//blocked
                                        NSLog(@"Arrr blocked==%@",arr3);
                                        
                                        for(NSDictionary *temp in arr3)
                                        {
                                            NSString *str1=[temp objectForKey:@"start_date"];
                                            NSString *str2=[temp objectForKey:@"end_date"];
                                            NSString *str3=[temp objectForKey:@"count"];
                                            
                                            [self.datesWithEventArr addObject:str1];
                                            
                                            NSLog(@"Blocked start date===%@ Blocked end date==%@ Count==%@",str1,str2,str3);
                                            {
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                    _eventDateFromstr=str1;
                                                    _eventDateTostr=str2;
                                                    _countstr=str3;
                                                    
                                                }];
                                            }
                                        }
                                         _datesWithEvent=[_datesWithEventArr copy];
                                        NSLog(@"Date event blocked ==%@",_datesWithEvent);
                                        
                                        
                                        NSArray *arr4=[outerdic objectForKey:@"booked"];//booked
                                        NSLog(@"Arrr booked==%@",arr4);
                                        
                                        for(NSDictionary *temp in arr4)
                                        {
                                            NSString *str1=[temp objectForKey:@"start_date"];
                                            NSString *str2=[temp objectForKey:@"end_date"];
                                            NSString *str3=[temp objectForKey:@"count"];
                                            
                                            [self.datesWithEventArr addObject:str1];
                                        
                                             NSLog(@"Booked start date===%@ Booked end date==%@ Count==%@",str1,str2,str3);
                                           
                                            {
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                    _eventDateFromstr=str1;
                                                    _eventDateTostr=str2;
                                                    _countstr=str3;
                                                   
                                                }];
                                            }
                                        }
                                        _datesWithEvent=[_datesWithEventArr copy];
                                        NSLog(@"Date event booked ==%@",_datesWithEvent);
                                        
                                        NSLog(@"booked date=%@",_datesWithEvent);
                                        
                                        
                                        NSArray *arr5=[outerdic objectForKey:@"cancelled"];//cancelled
                                        NSLog(@"Arrr cancelled==%@",arr5);
                                        
                                        for(NSDictionary *temp in arr5)
                                        {
                                            NSString *str1=[temp objectForKey:@"start_date"];
                                            NSString *str2=[temp objectForKey:@"end_date"];
                                            NSString *str3=[temp objectForKey:@"count"];
                                            
                                             [self.datesWithEventArr addObject:str1];
                                            
                                            NSLog(@"cancelled start date===%@ cancelled end date==%@ Count==%@",str1,str2,str3);
                                            {
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                    _eventDateFromstr=str1;
                                                    _eventDateTostr=str2;
                                                    _countstr=str3;
                                                    
                                                }];
                                            }
                                        }
                                        _datesWithEvent=[_datesWithEventArr copy];
                                        NSLog(@"Date event cancelled ==%@",_datesWithEvent);
                                        
                                        
                                        NSArray *arr6=[outerdic objectForKey:@"cancelled_user"];//cancelled by user
                                        NSLog(@"Arrr cancelled_user==%@",arr6);
                                        
                                        for(NSDictionary *temp in arr6)
                                        {
                                            NSString *str1=[temp objectForKey:@"start_date"];
                                            NSString *str2=[temp objectForKey:@"end_date"];
                                            NSString *str3=[temp objectForKey:@"count"];
                                            
                                             [self.datesWithEventArr addObject:str1];
                                            
                                            NSLog(@"cancelled_user start date===%@ cancelled_user end date==%@ Count==%@",str1,str2,str3);
                                            {
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                    _eventDateFromstr=str1;
                                                    _eventDateTostr=str2;
                                                    _countstr=str3;
                                                    
                                                }];
                                            }
                                        }
                                          _datesWithEvent=[_datesWithEventArr copy];
                                        NSLog(@"Date event cancelled user ==%@",_datesWithEvent);
                                        
                                        
                                   [_calendar reloadData];
                                    }
                                    [_calendar reloadData];
                                }];
 
    [task resume];
}];
    [_que addOperation:op2];
    [_calendar reloadData];
}

#pragma mark - <FSCalendarDataSource>

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
       NSLog(@"numberOfEventsForDate...%@",_datesWithEvent);
    
    NSString *dateString = [self.dateFormatter2 stringFromDate:date];
    if ([_datesWithEvent containsObject:dateString]) {
        return 1;
    }

    return 0;
}

#pragma mark - <FSCalendarDelegateAppearance>

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventColorForDate:(NSDate *)date
{
    NSLog(@"eventColorForDate...");
    NSString *dateString = [self.dateFormatter2 stringFromDate:date];
    if ([_datesWithEvent containsObject:dateString]) {
        return [UIColor redColor];
    }
    return nil;
}

- (NSArray *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
{
    
    NSString *dateString = [self.dateFormatter2 stringFromDate:date];
    if ([_datesWithEvent containsObject:dateString]) {
        NSLog(@"eventDefaultColorsForDate...==red");
        return @[[UIColor redColor],appearance.eventDefaultColor,[UIColor redColor]];
    }
    return nil;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter1 stringFromDate:date]);
    
    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedDates addObject:[self.dateFormatter1 stringFromDate:obj]];
    }];
    NSLog(@"selected dates is %@",selectedDates);
    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
        [calendar setCurrentPage:date animated:YES];
    }

        if (selectedDates.count>0) {
            NSString *selectedDate=selectedDates[0];
            NSLog(@"SELECTED DATE==%@",selectedDate);
            NSUserDefaults *currentUserDefault = [NSUserDefaults standardUserDefaults];
            [currentUserDefault setObject:selectedDate forKey:@"SelectedDates"];
            [currentUserDefault synchronize];
            NSLog(@"calling status parsing");
         [self statusParsing];
        [self blockedDateParsing];
        }
        else{
             NSLog(@"NONSELECTED DATE...");
        }

        
    
}

-(void)statusParsing{
    [_allstatusArr removeAllObjects];
    
    NSString *savedvalue = [[NSUserDefaults standardUserDefaults]stringForKey:@"SelectedDates"];
    
    NSLog(@"***Selected Date*** = %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"SelectedDates"]);
    NSLog(@"Status selected Service_Provider ID = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"serviceproviderid"]);
    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults] objectForKey:@"serviceproviderid"];
    
    NSString *myst=[NSString stringWithFormat:@"service_provider_id=%@&event_date_from=%@",savedvalue2,savedvalue];
    
    NSLog(@"Service provider id status parsing and event date from====%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url=[NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/status_calender2.php"];
    
    
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *err=nil;
    if(err){
        NSLog(@"%@",err.description);
    }
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"dATE IS NIL");
        }
        else{
            
            
            NSLog(@"Status Response==%@",response);
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            NSArray *statusarr=[outerdic objectForKey:@"status"];
            NSLog(@"Status ARRAY=%@",statusarr);
            
            for (NSDictionary *temp in statusarr) {
                
                Status *s=[[Status alloc]init];
                s.firstnamestr=temp[@"first_name"];
                s.lastnamestr=temp[@"last_name"];
                s.start_date=temp[@"event_date_from"];
                s.contactstr=temp[@"contact"];
                s.serviceprovideridstr=temp[@"service_provider_id"];
                s.bookidstr=temp[@"book_id"];
                s.useridstr=temp[@"user_id"];
                s.isConfirmedStr=temp[@"is_confirmed"];
                s.isPaidStr=temp[@"is_paid"];
                
                [_allstatusArr addObject:s];
                [_tableview reloadData];
            }
            [_tableview reloadData];
            
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableview reloadData];
        });
    }];
    [task resume];
    [_tableview reloadData];
    
    
}
-(void)blockedDateParsing{
    [_blockedArray removeAllObjects];
    
    NSString *savedvalue = [[NSUserDefaults standardUserDefaults]stringForKey:@"SelectedDates"];
    
    NSLog(@"***Selected Date*** = %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"SelectedDates"]);
    NSLog(@"Status selected Service_Provider ID = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"serviceproviderid"]);
    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults] objectForKey:@"serviceproviderid"];
    
    NSString *myst=[NSString stringWithFormat:@"service_provider_id=%@&event_date_from=%@",savedvalue2,savedvalue];
    
    NSLog(@"Service provider id blocked parsing and event date from====%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url=[NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/blocked_dates.php"];
    
    
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *err=nil;
    if(err){
        NSLog(@"%@",err.description);
    }
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"dATE IS NIL");
        }
        else{
            
            
            NSLog(@"Status Response==%@",response);
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            NSArray *statusarr=[outerdic objectForKey:@"blocked"];
            NSLog(@"Status ARRAY=%@",statusarr);
            
            for (NSDictionary *temp in statusarr) {
                
                Blocked *s=[[Blocked alloc]init];
                s.servicenamestr=temp[@"service_name"];
                s.startDatestr=temp[@"event_date_from"];
                s.endDatestr=temp[@"event_date_to"];
                s.startTimestr=temp[@"event_time_from"];
                s.endTimestr=temp[@"event_time_to"];
                s.blockidstr=temp[@"blocked_id"];
                s.serviceprovideridstr=temp[@"service_provider_id"];
                s.commentsStr=temp[@"comments"];
               
                
                [_blockedArray addObject:s];
                
                [[NSUserDefaults standardUserDefaults]setValue:s.blockidstr forKey:@"blocked_id"];
                
                [_tableview reloadData];
            }
            [_tableview reloadData];
            
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableview reloadData];
        });
    }];
    [task resume];
    [_tableview reloadData];
    
    
}


    

/*-(void)statusParsing{
 

    [_allstatusArr removeAllObjects];

    NSString *savedvalue = [[NSUserDefaults standardUserDefaults]stringForKey:@"SelectedDates"];
    
     NSLog(@"***Selected Date*** = %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"SelectedDates"]);
    NSLog(@"Status selected Service_Provider ID = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"serviceproviderid"]);
    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults] objectForKey:@"serviceproviderid"];
    
    NSString *myst=[NSString stringWithFormat:@"service_provider_id=%@&event_date_from=%@",savedvalue2,savedvalue];
    
    NSLog(@"Service provider id status parsing and event date from====%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url=[NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/status_calender.php"];


    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *err=nil;
    if(err){
        NSLog(@"%@",err.description);
    }
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"dATE IS NIL");
        }
        else{
            
            
            NSLog(@"Status Response==%@",response);
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            NSArray *statusarr=[outerdic objectForKey:@"confirmed"];
            NSLog(@"CONFIRMED ARRAY=%@",statusarr);
            
            for (NSDictionary *temp in statusarr) {
          
                Status *s=[[Status alloc]init];
                s.firstnamestr=temp[@"first_name"];
                s.lastnamestr=temp[@"last_name"];
                s.start_date=temp[@"event_date_from"];
                s.contactstr=temp[@"contact"];
                s.serviceprovideridstr=temp[@"service_provider_id"];
                s.bookidstr=temp[@"book_id"];
                s.useridstr=temp[@"user_id"];
                s.isConfirmedStr=temp[@"is_confirmed"];
                s.isPaidStr=temp[@"is_paid"];
                
                [_allstatusArr addObject:s];
                [_tableview reloadData];
            }
            NSArray *statusarr1=[outerdic objectForKey:@"pending"];
            NSLog(@"Pending ARRAY=%@",statusarr1);
            
            for (NSDictionary *temp in statusarr1) {
             
                Status *s=[[Status alloc]init];
                s.firstnamestr=temp[@"first_name"];
                s.lastnamestr=temp[@"last_name"];
                s.start_date=temp[@"event_date_from"];
                s.contactstr=temp[@"contact"];
                s.serviceprovideridstr=temp[@"service_provider_id"];
                s.bookidstr=temp[@"book_id"];
                s.useridstr=temp[@"user_id"];
                s.isConfirmedStr=temp[@"is_confirmed"];
                s.isPaidStr=temp[@"is_paid"];
                
                if(s.isPaidStr==(NSString *) [NSNull null])
                {
                    s.isPaidStr=@"-";
                }
                
                
                [_allstatusArr addObject:s];
                [_tableview reloadData];
                
            }
            NSArray *statusarr2=[outerdic objectForKey:@"booked"];
            NSLog(@"Booked ARRAY=%@",statusarr2);
            
            for (NSDictionary *temp in statusarr2) {
                
                Status *s=[[Status alloc]init];
                s.firstnamestr=temp[@"first_name"];
                s.lastnamestr=temp[@"last_name"];
                s.start_date=temp[@"event_date_from"];
                s.contactstr=temp[@"contact"];
                s.serviceprovideridstr=temp[@"service_provider_id"];
                s.bookidstr=temp[@"book_id"];
                s.useridstr=temp[@"user_id"];
                s.isConfirmedStr=temp[@"is_confirmed"];
                s.isPaidStr=temp[@"is_paid"];
                
                [_allstatusArr addObject:s];
                [_tableview reloadData];
                
            }
            NSArray *statusarr3=[outerdic objectForKey:@"cancelled"];
            NSLog(@"Cancelled ARRAY=%@",statusarr3);
            
            for (NSDictionary *temp in statusarr) {
                
                Status *s=[[Status alloc]init];
                s.firstnamestr=temp[@"first_name"];
                s.lastnamestr=temp[@"last_name"];
                s.start_date=temp[@"event_date_from"];
                s.contactstr=temp[@"contact"];
                s.serviceprovideridstr=temp[@"service_provider_id"];
                s.bookidstr=temp[@"book_id"];
                s.useridstr=temp[@"user_id"];
                s.isConfirmedStr=temp[@"is_confirmed"];
                s.isPaidStr=temp[@"is_paid"];
                
                [_allstatusArr addObject:s];
                [_tableview reloadData];
                
            }
            NSArray *statusarr4=[outerdic objectForKey:@"cancelled_user"];
            NSLog(@"Cancelled user ARRAY=%@",statusarr4);
            
            for (NSDictionary *temp in statusarr) {
                Status *s=[[Status alloc]init];
                s.firstnamestr=temp[@"first_name"];
                s.lastnamestr=temp[@"last_name"];
                s.start_date=temp[@"event_date_from"];
                s.contactstr=temp[@"contact"];
                s.serviceprovideridstr=temp[@"service_provider_id"];
                s.bookidstr=temp[@"book_id"];
                s.useridstr=temp[@"user_id"];
                s.isConfirmedStr=temp[@"is_confirmed"];
                
                [_allstatusArr addObject:s];
                [_tableview reloadData];
           
             
            }
            [_tableview reloadData];
            
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{

            [self.tableview reloadData];
        });
     }];
    [task resume];
    [_tableview reloadData];
    
    
}
 */
- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    [self.view layoutIfNeeded];
}
- (IBAction)venueBtnClicked:(id)sender {
    
    
    //self.user.hidden=NO;
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];

    NSString *myst=[NSString stringWithFormat:@"username=%@",savedValue];
    NSLog(@"********Username===%@",myst);
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    
    
    NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_service_info.php"];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if(error)
    {
    }
    NSURLSessionDataTask *task=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    if(data==nil)
                                    {
                                        NSLog(@"Data is nil");
                                    }
                                    else
                                    {
                                         NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                        NSLog(@"%@",response);
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        keyarr1= [[NSMutableArray alloc]init];
                                        keyarr2=[[NSMutableArray alloc]init];
                                        
                                        NSArray *keyarr= (NSArray*)[outerdic objectForKey:@"venueservice"];
                                        
                                       // NSUInteger count=sizeof(keyarr);
                                        NSUInteger count = [keyarr count];
                                        NSUInteger i=0;
                                        
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            NSString *str1=[temp objectForKey:@"service_provider_id"];
                                            NSString *str2=[temp objectForKey:@"service_name"];
                                            NSString *str3=[temp objectForKey:@"user"];
                                            
                                            if(count>i)
                                            {
                                                [keyarr1 addObject:str2];
                                                [keyarr2 addObject:str1];
                                                
                                               
                                                
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                    _serviceproviderid.text=_service_provider_id_str;
                                                    _venueLbl.text=_venue_Str;
                                                    _user.text=_user_str;
                                                    
                                                    NSLog(@"****Service Provider id==%@  Venue Service name==%@ User==%@",str1,str2,str3);
                                                    
                                                    [[NSUserDefaults standardUserDefaults]setValue:str1 forKey:@"serviceproviderid"];
                                                    NSLog(@"Service_Provider ID = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"serviceproviderid"]);
                                                    
                                                    [[NSUserDefaults standardUserDefaults]setValue:str2 forKey:@"servicename"];
                                                    NSLog(@"Venue servicename = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"servicename"]);
                                                    
                                                    [self getCalendarCount];
                                                    
                                                    
                                         
                                                }];
                                                
                                                //NSString *test=[keyarr1 objectAtIndex:i];
                                            }
                                            i++;
                                        }
                                        NSArray * arrImage = [[NSArray alloc] init];
                                        
                                        if(dropDown2 == nil) {
                                            CGFloat f = 80;
                                            dropDown2 = [[NIDropDown alloc]showDropDown:sender :&f :keyarr1 :arrImage :@"down"];
                                            
                                            dropDown2.delegate = self;
                                        }
                                        else {
                                            [dropDown2 hideDropDown:sender];
                                            [self rel];
                                        }
                                    }
                                       
                                }];
    
    
    [task resume];

}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
    
    NSUInteger i = [keyarr1 indexOfObject:self.venueBtnClicked.titleLabel.text];
    NSLog(@"INTEGER==%lu",(unsigned long)i);
    NSLog(@"VENUE LBL==%@",self.venueBtnClicked.titleLabel.text);
    NSString *serviceId = keyarr2[i];
 
    
   NSLog(@"venue====%@",self.venueBtnClicked.titleLabel);

    
    [[NSUserDefaults standardUserDefaults]setValue:serviceId forKey:@"serviceproviderid"];
    NSLog(@"venue selected Service_Provider name = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"serviceproviderid"]);
    
}

-(void)rel{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        // If the showAllSections is NO, then we want only two sections.
        // Otherwise, we want our table to have four sections.
        //if (!showAllSections) {
            return 2;
//        }
//        else{
//            return 2;
//        }
    }
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        if (section==0) {
            return _allstatusArr.count;
        }else if(section==1){
       return _blockedArray.count;
        }
        return 0;
}

// Add header titles in sections.
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSString *headerTitle = @"";
//    
//    if (section == 0) {
//        headerTitle = @"Blocked Dates";
//    }
//    else{
//        if (showAllSections) {
//                       headerTitle = @"Status";
//        } // else
//    } // else
//    
//    return headerTitle;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        switch (indexPath.section) {
            case 0:
            {
      
        StatusTableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        Status *s=[_allstatusArr objectAtIndex:indexPath.row];
//                if([_allstatusArr count] > 0 && [_allstatusArr count] > indexPath.row){
//                    
//                    s=[_allstatusArr objectAtIndex:indexPath.row];
                
                
        cell.contact.text=s.contactstr;
        cell.startDate.text=s.start_date;
        cell.userid.text=s.useridstr;
        cell.bookid.text=s.bookidstr;
        cell.service_provider_id.text=s.serviceprovideridstr;
        cell.isConfirmed.text=s.isConfirmedStr;
        cell.isPaid.text=s.isPaidStr;
        
        NSString *name=[NSString stringWithFormat:@"%@ %@",s.firstnamestr,s.lastnamestr];
        
        cell.name.text=name;
      
        NSLog(@"Contact===%@,isConfirmed===%@ ispaid==%@",cell.contact.text,cell.isConfirmed.text,cell.isPaid.text);
        
                
        if ([cell.isConfirmed.text isEqualToString:@"2"] && [cell.isPaid.text isEqualToString:@"0"]){
            NSLog(@"Pending.......");
            cell.isConfirmed.text=@"Pending";
            cell.isConfirmed.backgroundColor = [UIColor redColor];
            cell.isConfirmed.textColor=[UIColor whiteColor];
            cell.isConfirmed.layer.cornerRadius = 5;
            cell.isConfirmed.layer.masksToBounds = YES;
        }
        if ([cell.isConfirmed.text isEqualToString:@"1"] && [cell.isPaid.text isEqualToString:@"0"]){
            NSLog(@"Confirmed........");
            cell.isConfirmed.text=@"Confirmed";
            cell.isConfirmed.backgroundColor = [UIColor greenColor];
            cell.isConfirmed.textColor=[UIColor whiteColor];
            cell.isConfirmed.layer.cornerRadius = 5;
            cell.isConfirmed.layer.masksToBounds = YES;
        }
       
        if ([cell.isConfirmed.text isEqualToString:@"1"] && [cell.isPaid.text isEqualToString:@"1"]){
            NSLog(@"Booked.......");
            cell.isConfirmed.text=@"Booked";
            cell.isConfirmed.backgroundColor = [UIColor blueColor];
            cell.isConfirmed.textColor=[UIColor whiteColor];
            cell.isConfirmed.layer.cornerRadius = 5;
            cell.isConfirmed.layer.masksToBounds = YES;
        }
        if ([cell.isConfirmed.text isEqualToString:@"0"]){
        //if ([cell.isConfirmed.text isEqualToString:@"0"] && [cell.isPaid.text isEqualToString:@"0"]){
            NSLog(@"Cancelled.......");
            cell.isConfirmed.text=@"Cancelled";
            cell.isConfirmed.backgroundColor = [UIColor darkGrayColor];
            cell.isConfirmed.textColor=[UIColor whiteColor];
            cell.isConfirmed.layer.cornerRadius = 5;
            cell.isConfirmed.layer.masksToBounds = YES;
        }
        if ([cell.isConfirmed.text isEqualToString:@"3"] || [cell.isConfirmed.text isEqualToString:@"4"]){
            NSLog(@"Cancelled by user.......");
            cell.isConfirmed.text=@"Cancelled By User";
            cell.isConfirmed.backgroundColor = [UIColor colorWithRed:83.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1.0];
            cell.isConfirmed.textColor=[UIColor whiteColor];
            cell.isConfirmed.layer.cornerRadius = 5;
            cell.isConfirmed.layer.masksToBounds = YES;
        }

        return  cell;
       
       
        }
         case 1:
            {
           
            BlockedTableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            
            Blocked *s=[_blockedArray objectAtIndex:indexPath.row];
            
            cell.serviceName.text=s.servicenamestr;
            cell.startDate.text=s.startDatestr;
            cell.startTime.text=s.startTimestr;
            cell.endDate.text=s.endDatestr;
            cell.endTime.text=s.endTimestr;

            [cell.unblockBtn addTarget:self action:@selector(unblockBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            
            return  cell;
        }
              default:
                break;
        }
        return 0;
}
-(void)unblockBtnClicked:(id)sender{

    
    UIAlertController *alert=[UIAlertController
                              alertControllerWithTitle:@"ALERT" message:@"Are you sure you want to Unblock dates?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                   [self unblockParsing];
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
    

}

-(void)unblockParsing{
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
                 [self presentViewController:alertView animated:YES completion:nil];
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
                 [self presentViewController:alertView animated:YES completion:nil];
            }
        });
        
        
    }];
    
    [dataTask resume];
    

}
/*
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    else{
        StatusTableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:CellIdentifier];
        
        Status *s=self.allstatusArr[indexPath.row];
        
        cell.contact.text=s.contactstr;
        cell.startDate.text=s.start_date;
        cell.userid.text=s.useridstr;
        cell.bookid.text=s.bookidstr;
        cell.service_provider_id.text=s.serviceprovideridstr;
        cell.isConfirmed.text=s.isConfirmedStr;
        cell.isPaid.text=s.isPaidStr;
        
        NSString *name=[NSString stringWithFormat:@"%@ %@",s.firstnamestr,s.lastnamestr];
        
        cell.name.text=name;
        
        NSLog(@"Contact===%@,isConfirmed===%@ ispaid==%@",cell.contact.text,cell.isConfirmed.text,cell.isPaid.text);
        
        
        if ([cell.isConfirmed.text isEqualToString:@"2"] && [cell.isPaid.text isEqualToString:@"0"]){
            NSLog(@"Pending.......");
            cell.isConfirmed.text=@"Pending";
            cell.isConfirmed.backgroundColor = [UIColor redColor];
            cell.isConfirmed.textColor=[UIColor whiteColor];
            cell.isConfirmed.layer.cornerRadius = 5;
            cell.isConfirmed.layer.masksToBounds = YES;
        }
        if ([cell.isConfirmed.text isEqualToString:@"1"] && [cell.isPaid.text isEqualToString:@"0"]){
            NSLog(@"Confirmed........");
            cell.isConfirmed.text=@"Confirmed";
            cell.isConfirmed.backgroundColor = [UIColor greenColor];
            cell.isConfirmed.textColor=[UIColor whiteColor];
            cell.isConfirmed.layer.cornerRadius = 5;
            cell.isConfirmed.layer.masksToBounds = YES;
        }
        
        if ([cell.isConfirmed.text isEqualToString:@"1"] && [cell.isPaid.text isEqualToString:@"1"]){
            NSLog(@"Booked.......");
            cell.isConfirmed.text=@"Booked";
            cell.isConfirmed.backgroundColor = [UIColor blueColor];
            cell.isConfirmed.textColor=[UIColor whiteColor];
            cell.isConfirmed.layer.cornerRadius = 5;
            cell.isConfirmed.layer.masksToBounds = YES;
        }
        if ([cell.isConfirmed.text isEqualToString:@"0"]){
            //if ([cell.isConfirmed.text isEqualToString:@"0"] && [cell.isPaid.text isEqualToString:@"0"]){
            NSLog(@"Cancelled.......");
            cell.isConfirmed.text=@"Cancelled";
            cell.isConfirmed.backgroundColor = [UIColor darkGrayColor];
            cell.isConfirmed.textColor=[UIColor whiteColor];
            cell.isConfirmed.layer.cornerRadius = 5;
            cell.isConfirmed.layer.masksToBounds = YES;
        }
        if ([cell.isConfirmed.text isEqualToString:@"3"] || [cell.isConfirmed.text isEqualToString:@"4"]){
            NSLog(@"Cancelled by user.......");
            cell.isConfirmed.text=@"Cancelled By User";
            cell.isConfirmed.backgroundColor = [UIColor colorWithRed:83.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1.0];
            cell.isConfirmed.textColor=[UIColor whiteColor];
            cell.isConfirmed.layer.cornerRadius = 5;
            cell.isConfirmed.layer.masksToBounds = YES;
        }
        
        return  cell;
        
        

    }
    // We don't want our cells to have any selection style.
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    
//    NSString *dataToShow = [[tableView objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
//    NSString *detailText = [[subtitleData objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
//    
   // [[cell textLabel] setText:dataToShow];
    [[cell textLabel] setTextColor:[UIColor blackColor]];
    
   // [[cell detailTextLabel] setText:detailText];
    
    // Format the cell that works as our toggle button.
    if ([indexPath section] == 0 && [indexPath row] == 2) {
        [[cell textLabel] setTextColor:[UIColor redColor]];
        
        // The "View extended info" cell should have different selection style.
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    
    return cell;
}


// Set the row height.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
 */
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0 && indexPath.row == 0)
//        return 50.0;
//    return 100;
//}


        
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([[segue identifier]isEqualToString:@"showBookingDetailsPending"])
    {
        BookingDetailsViewController *b=[segue destinationViewController];
        b.service_provider_id_str=_service_provider_id_str;;
        b.book_id_str=_bookidstr;
        b.is_ConfirmedStr=_isConfirmedstr;
        b.is_paidStr=_isPaidstr;
        b.statusStr=_statusStr;
    }
    if([[segue identifier]isEqualToString:@"showBookingDetailsConfirmed"])
    {
        BookingConfirmedViewController *bc=[segue destinationViewController];
        bc.service_provider_id_str=_service_provider_id_str;;
        bc.book_id_str=_bookidstr;
        bc.is_ConfirmedStr=_isConfirmedstr;
        bc.is_paidStr=_isPaidstr;
        bc.statusStr=_statusStr;
        
        
        NSLog(@"%@",_statusStr);
    }
    if([[segue identifier]isEqualToString:@"showBooked"])
    {
        BookedStatusViewController *bb=[segue destinationViewController];
        bb.service_provider_id_str=_service_provider_id_str;;
        bb.book_id_str=_bookidstr;
        bb.is_ConfirmedStr=_isConfirmedstr;
        bb.is_paidStr=_isPaidstr;
        bb.statusStr=_statusStr;
    }
    if([[segue identifier]isEqualToString:@"showCancelled"])
    {
        CancelledViewController *c=[segue destinationViewController];
        c.service_provider_id_str=_service_provider_id_str;;
        c.book_id_str=_bookidstr;
        c.is_ConfirmedStr=_isConfirmedstr;
        c.is_paidStr=_isPaidstr;
        c.statusStr=_statusStr;
    }
    if([[segue identifier]isEqualToString:@"showCancelledByUser"])
    {
        CancelledUserViewController *cuvc=[segue destinationViewController];
        cuvc.service_provider_id_str=_service_provider_id_str;;
        cuvc.book_id_str=_bookidstr;
        cuvc.is_ConfirmedStr=_isConfirmedstr;
        cuvc.is_paidStr=_isPaidstr;
        cuvc.statusStr=_statusStr;
    }
    
    
    WebViewController *wvc=[segue destinationViewController];
    if ([segue.identifier isEqualToString:@"showAnveshak"]) {
        
        wvc.myurl=@"http://www.anveshak.com/";
    }
//    else{
//        wvc.myurl=@"info@managemyfunction.com";
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    StatusTableViewCell *cell=[_tableview cellForRowAtIndexPath:indexPath];
    
    _firstNamestr=cell.firstname.text;
    _lastNamestr=cell.lastname.text;
    _contactStr=cell.contact.text;
    _useridstr=cell.userid.text;
    _startDateStr=cell.startDate.text;
    _bookidstr=cell.bookid.text;
    _service_provider_id_str=cell.service_provider_id.text;
    _isConfirmedstr=cell.isConfirmed.text;
    _isPaidstr=cell.isPaid.text;

    NSLog(@"start time=%@    lastname=%@",_firstNamestr,cell.lastname.text);
    
    NSLog(@"******Service provider id****=  %@",cell.service_provider_id.text);
    
     Status *s=self.allstatusArr[indexPath.row];
     NSString *tempstr=s.isConfirmedStr;
     NSString *tempstr2=s.isPaidStr;
     NSLog(@"temp str==%@",tempstr);
    
    if([tempstr isEqualToString:@"2"] && [tempstr2 isEqualToString:@"0"])
    {
        [self performSegueWithIdentifier:@"showBookingDetailsPending" sender:nil];
      //  [self performSegueWithIdentifier:@"showBookingDetailsPending" sender:[self.tableview cellForRowAtIndexPath:indexPath]];
    }
    else if([tempstr isEqualToString:@"1"] && [tempstr2 isEqualToString:@"0"])
    {
        [self performSegueWithIdentifier:@"showBookingDetailsConfirmed" sender:nil];
        //[self performSegueWithIdentifier:@"showBookingDetailsConfirmed" sender:[self.tableview cellForRowAtIndexPath:indexPath]];
    }
    else if([tempstr isEqualToString:@"1"] && [tempstr2 isEqualToString:@"1"])
    {
        [self performSegueWithIdentifier:@"showBooked" sender:nil];
        //[self performSegueWithIdentifier:@"showBooked" sender:[self.tableview cellForRowAtIndexPath:indexPath]];
    }
    else if([tempstr isEqualToString:@"0"] && [tempstr2 isEqualToString:@"0"])
    {
        [self performSegueWithIdentifier:@"showCancelled" sender:nil];
       // [self performSegueWithIdentifier:@"showCancelled" sender:[self.tableview cellForRowAtIndexPath:indexPath]];
    }
    else if([tempstr isEqualToString:@"3"]|| [tempstr2 isEqualToString:@"4"])
    {
        [self performSegueWithIdentifier:@"showCancelledByUser" sender:nil];
    }
    
    
}
    
  
@end
