//
//  VenueInfoViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 7/10/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "VenueInfoViewController.h"
#import "VenueInfoTableViewCell.h"
#import "BookingViewController.h"
#import "WebViewController.h"
#import "VenueInfo.h"
#import "CheckBoxButton.h"
#import "Singleton.h"
#import "VenueInfoArray.h"
#import "DTCustomColoredAccessory.h"
#import <QuartzCore/QuartzCore.h>


#define kfacility_idKey    @"facility_id"
#define kunitKey           @"unit"
#define kquantityKey       @"quantity"
#define kpriceKey          @"price"
#define kcommentsKey       @"comments"
#define kfacility_nameKey  @"facility_name"
#define kvenueFacilityKey @"venuefacilityarray"
@interface VenueInfoViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property VenueInfoTableViewCell *cell;
@end


@implementation VenueInfoViewController
{
   // NSMutableArray *arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   // arr=[[NSMutableArray alloc]init];
    _service_name.text=_service_name_str;
    _address.text=_address_str;
    _capacity.text=_capacity_str;
    _deposit.text=_deposit_str;
    _service_provider_id.text=_service_provider_id_str;
    
    self.comments.layer.borderWidth = 2.0f;
    self.comments.layer.borderColor = [[UIColor grayColor] CGColor];
    
        _guestcount.delegate=self;
        _comments.delegate=self;
    

    [self.tableview setSeparatorColor:[UIColor clearColor]];
    [self setupScrollView:self.scroll];
    
    
    UIPageControl *pgCtr=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 264, 480,50)];
    [pgCtr setTag:12];
    pgCtr.numberOfPages=5;
    pgCtr.autoresizingMask=UIViewAutoresizingNone;
    [self.contentview addSubview:pgCtr];
    
    
    _viewpdf.layer.borderWidth = 1;
    _viewpdf.layer.borderColor = [[UIColor blueColor] CGColor];
    _viewpdf.layer.cornerRadius = 5;
    _viewpdf.clipsToBounds = YES;

    _changeTimeBtn.layer.borderWidth = 1;
    _changeTimeBtn.layer.borderColor = [[UIColor cyanColor] CGColor];
    _changeTimeBtn.layer.cornerRadius = 5;
    _changeTimeBtn.clipsToBounds = YES;

    _proceedBtn.layer.borderWidth = 1;
   // _proceedBtn.layer.borderColor = [[UIColor blackColor] CGColor];
    _proceedBtn.layer.cornerRadius = 5;
    _proceedBtn.clipsToBounds = YES;

    
    
//    self.start_date.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"startdate"];//storing for temprorary
//    self.end_date.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"enddate"];
//    self.start_time.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"startTime"];
//    self.end_time.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"endTime"];
//    
//    self.startTime.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"startTime"];
//    self.endTime.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"endTime"];
    
//    
//    _service_provider_id.text=_service_provider_id_str;
//    _service_name.text=_service_name_str;
    
    
//    [[NSUserDefaults standardUserDefaults]setValue:self.service_name.text forKey:@"servicename"];
//    NSLog(@"Service_Name = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"servicename"]);
    
//    [[NSUserDefaults standardUserDefaults]setValue:self.service_provider_id.text forKey:@"serviceproviderid"];
//    NSLog(@"Service_Provider ID = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"serviceproviderid"]);
//    
    
  //  NSLog(@"Venue Info Service provider id......%@",_service_provider_id_str);
    // Do any additional setup after loading the view.
     _que=[[NSOperationQueue alloc]init];
   // [self techparsing];

    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _venuefacility_arr=[[NSMutableArray alloc]init];
    _selectedFacility=[[NSMutableArray alloc]init];
    
    [self facilityParsing];
    [self venueinfoDetails];
    [self getTieupServcies];
    [self getTieupRoles];
    [self getVenueDetails];
    // [self techparsing];
    [self geteventDetails];
    
    
    
    if (!expandedSections)
    {
        expandedSections = [[NSMutableIndexSet alloc] init];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
   
}

-(void)venueinfoDetails
 {
     
    NSString *myst=[NSString stringWithFormat:@"service_provider_id=%@",_service_provider_id_str];
    
    NSLog(@"Venue SERVICE PROVIDER ID.......%@",myst);
   

    
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
         NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *urlstr=@"http://localhost/phpmyadmin/MMF/get_venue_info.php";
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [request setHTTPMethod:@"POST"];
         NSLog(@"service provider id aftr post===%@",_service_provider_id_str);
    [request setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];

    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    if(data==nil)
                                    {
                                        NSLog(@"Data is nil");
                                    }
                                    else
                                    {
                                        NSLog(@"Response venue===%@",response);
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        
                                        NSLog(@"Outer dic==venue===%@",outerdic);
                                        
                                        NSArray *arr=[outerdic objectForKey:@"venueinfo"];
                                        
                                        NSLog(@"Venu info keyarr==%@",[outerdic objectForKey:@"venueinfo"]);
                                        
                                        for(NSDictionary *temp in arr)
                                        {
                                            NSString *str1=[temp objectForKey:@"facilities"];
                                            NSString *str2=[temp objectForKey:@"established_year"];
                                            NSString *str3=[temp objectForKey:@"price_hour"];
                                            NSString *str4=[temp objectForKey:@"price_day"];
                                            NSString *str5=[temp objectForKey:@"day_start_time"];
                                            NSString *str6=[temp objectForKey:@"day_end_time"];
                                            NSString *str7=[temp objectForKey:@"opening_time"];
                                            NSString *str8=[temp objectForKey:@"closing_time"];
                                            NSString *str9=[temp objectForKey:@"capacity"];
                                            NSString *str10=[temp objectForKey:@"service_provider_id"];
                                            NSString *str11=[temp objectForKey:@"terms_conditions"];
                                            NSString *str12=[temp objectForKey:@"deposit"];
                                            NSString *str13=[temp objectForKey:@"service_name"];
                                            NSString *str14=[temp objectForKey:@"address"];
                                            NSString *str15=[temp objectForKey:@"pdf_name"];
                                            NSString *str16=[temp objectForKey:@"ext"];
                                            NSString *str17=[temp objectForKey:@"path"];
                                            NSString *str18=[temp objectForKey:@"cover_images"];
                                            NSLog(@"facilities=%@ \n established_year=%@ \n price_hour=%@ \n price_day=%@ \n day_start_time=%@ \n day_end_time=%@ \n opening_time=%@ \n closing_time=%@ \n capacity=%@ \n service_provider_id=%@ \n terms_conditions=%@ \n deposit=%@ \n service_name=%@\n address=%@ \n  pdf_name=%@ \n ext=%@ \n path=%@ \n cover_images=%@",str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str14,str15,str16,str17,str18);
                                          
                                            {
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{ _facilities_str=str1;
                                                _eastablished_yr_str=str2;
                                                _price_hr_str=str3;
                                                _price_day_str=str4;
                                                _day_starttime_str=str5;
                                                _day_endtime_str=str6;
                                                _opening_time_str=str7;
                                                _closing_time_str=str8;
                                                _capacity_str=str9;
                                                _service_provider_id_str=str10;
                                                _terms_conditons_str=str11;
                                                _deposit_str=str12;
                                                _service_name_str=str13;
                                                _address_str=str14;
//                                                _pdf_name_str=str15;
//                                                _ext_str=str16;
//                                                _path_str=str17;
                                    // _coverimages_str=str18;
                                                
                                            
                                            
                                            NSLog(@"SErvice name====%@",str13);
//                                                NSString *tempimgstr=str18;
//                                                [_cover_images sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
//                                                           placeholderImage:[UIImage imageNamed:@"1.png"]];
//                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//                                                    
//                                                    
                                                    _facilities.text=_facilities_str;
                                                    _established_year.text=_eastablished_yr_str;
                                                    _price_hour.text=_price_hr_str;
                                                    _price_day.text=_price_day_str;
                                                    _day_start_time.text=_day_starttime_str;
                                                    _day_end_time.text=_day_endtime_str;
                                                    _opening_time.text=_opening_time_str;
                                                    _closing_time.text=_closing_time_str;
                                                    _capacity.text=_capacity_str;
                                                    _service_provider_id.text=_service_provider_id_str;
                                                    _terms_conditons.text=_terms_conditons_str;
                                                    _deposit.text=_deposit_str;
                                                    _service_name.text=_service_name_str;
                                                    _address.text=_address_str;
                                                    //_cover_images.image=_coverimages_str;
//                                                    _pdf.text=_pdf_name_str;
//                                                    _ext.text=_ext_str;
//                                                    _path.text=_path_str;
//                                                    
//                                                    dispatch_async(dispatch_get_main_queue(), ^{
//                                                        
//                                                        if(_pdf.text==(NSString *) [NSNull null])
//                                                        {
//                                                           _pdf.text=@"not given";
//                                                        }
//                                                        if(_ext.text==(NSString *) [NSNull null])
//                                                        {
//                                                            _ext.text=@"not given";
//                                                        }
//                                                        if(_path.text==(NSString *) [NSNull null])
//                                                        {
//                                                            _path.text=@"not given";
//                                                        }
//                                                        
//                                                        
//                                                    });
//                                                    
                                                    
                                                }];
                                                
                                               
                                            }
                                        }
                                        
                                    }
                                    
                                }];
    [task resume];

}
 /*
-(void)techparsing
{
    
    NSBlockOperation *op2=[NSBlockOperation blockOperationWithBlock:^{
        
        
        //NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"service_provider_id"];
        NSString *myst=[NSString stringWithFormat:@"service_provider_id=%@",_service_provider_id_str];
        
        NSLog(@"SERVICE PROVIDER ID.......%@",myst);
        
        NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        NSString *urlstr=@"http://localhost/phpmyadmin/MMF/get_service_details.php";
        //NSString *urlstr=@"http://siddhantedu.com/iOSAPI/Symp/about.php";
        
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                    {
                                        
                                        if(data==nil)
                                        {
                                            NSLog(@"Data is nil");
                                            
                                        }
                                        
                                        else
                                        {
                                            
                                            
                                            NSLog(@"%@",response);
                                            
                                            
                                            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                            
                                            NSArray *arr=[outerdic objectForKey:@"venuedetails"];
                                            
                                            for(NSDictionary *temp in arr)
                                            {
                                                NSString *str1=[temp objectForKey:@"facilities"];
                                                NSString *str2=[temp objectForKey:@"price_hour"];
                                                NSString *str3=[temp objectForKey:@"price_day"];
                                                NSString *str4=[temp objectForKey:@"day_start_time"];
                                                NSString *str5=[temp objectForKey:@"day_end_time"];
                                                NSString *str6=[temp objectForKey:@"opening_time"];
                                                NSString *str7=[temp objectForKey:@"closing_time"];
                                                NSString *str8=[temp objectForKey:@"capacity"];
                                                NSString *str9=[temp objectForKey:@"service_provider_id"];
                                                NSString *str10=[temp objectForKey:@"venue"];
                                                NSString *str11=[temp objectForKey:@"event_name"];
                                                NSString *str12=[temp objectForKey:@"service_name"];
                                                NSString *str13=[temp objectForKey:@"address"];
                                                NSString *str14=[temp objectForKey:@"cover_images"];
                                                NSString *str15=[temp objectForKey:@"terms_conditions"];
                                                NSString *str16=[temp objectForKey:@"pdf_name"];
                                                NSString *str17=[temp objectForKey:@"ext"];
                                                NSString *str18=[temp objectForKey:@"path"];
                                                NSString *str19=[temp objectForKey:@"deposit"];
//                                                NSString *str20=[temp objectForKey:@"venue_type"];
//                                                NSString *str21=[temp objectForKey:@"event_name"];
                                                NSString *str22=[temp objectForKey:@"establishment"];
                                                
                                                
                                                
                                                NSLog(@"Venue type==%@ Event type=== %@ service name=%@",str10,str11,str12);
                                                
                                                {
                                                    
                                                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                        
                                                        _facilities_str=str1;
                                                        _price_hr_str=str2;
                                                        _price_day_str=str3;
                                                        _day_starttime_str=str4;
                                                        _day_endtime_str=str5;
                                                        _opening_time_str=str6;
                                                        _closing_time_str=str7;
                                                        _capacity_str=str8;
                                                        _service_provider_id_str=str9;
                                                        _venue_type_name_str=str10;
                                                        _event_name_str=str11;
                                                        _service_name_str=str12;
                                                        _address_str=str13;
                                                        _coverimages_str=str14;
                                                        _terms_conditons_str=str15;
                                                        _pdf_name_str=str16;
                                                        _ext_str=str17;
                                                        _path_str=str18;
                                                        // _deposit_str=str19;
                                                        
                                                        _eastablished_yr_str=str22;
                                                        
                                                        
                                                        if([_deposit_str isEqual:[NSNull null]])
                                                        {
                                                            _deposit_str=@"--";
                                                        }
                                                        else
                                                        {
                                                            _deposit_str=str19;
                                                        }
                                                        
                                                        
                                                        _facilities.text=_facilities_str;
                                                        _price_hour.text=_price_hr_str;
                                                        _price_day.text=_price_day_str;
                                                        _day_start_time.text=_day_starttime_str;
                                                        _day_end_time.text=_day_endtime_str;
                                                        _opening_time.text=_opening_time_str;
                                                        _closing_time.text=_closing_time_str;
                                                        _capacity.text=_capacity_str;
                                                        _service_provider_id.text=_service_provider_id_str;
                                                        _venue_type.text=_venue_type_name_str;
                                                        _event_type.text=_event_name_str;
                                                        _service_name.text=_service_name_str;
                                                        _address.text=_address_str;
                                                        // _cover_images.image=_coverimages_str;
                                                        _terms_conditons.text=_terms_conditons_str;
                                                        
                                                        // _terms_conditons.text=@"\u20AC";
                                        
                                                        
                                                        _deposit.text=_deposit_str;
                                                        _established_year.text=_eastablished_yr_str;
                                                        
                                                    }];
                                                    
                                                }
                                            }
                                        }
                                        
                                    }];
        
        [task resume];
        
    }];
    
    [_que addOperation:op2];
    
}
  */
-(void)getVenueDetails{
    
    
    NSString *myst=[NSString stringWithFormat:@"service_provider_id=%@",_service_provider_id_str];
    
    NSLog(@"Venue Type SERVICE PROVIDER ID.......%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSString *urlstr=@"http://localhost/phpmyadmin/MMF/get_venue_type.php";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"dATA IS NIL");
        }
        else{
            NSLog(@"response venues ==%@",response);
            
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr=[outerdic objectForKey:@"venues"];
            
            for(NSDictionary *temp in arr){
                NSString *str1=[temp objectForKey:@"venue_type_id"];
                NSString *str2=[temp objectForKey:@"venue_type_name"];
              
                NSLog(@" venue_type_id==%@ venue type name==%@",str1,str2);
                {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                       _venuetypeidStr =str1;
                        _venue_type_name_str=str2;
                        
                        
                        _venue_type_id.text=_venuetypeidStr;
                        _venue_type.text=_venue_type_name_str;
                       
                        
                    }];
                }
            }
        }
    }];
    
    [task resume];
    
}
-(void)geteventDetails{
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_events.php"];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        if (data==nil) {
            NSLog(@"dATA IS NIL");
        }
        else{
            NSLog(@"response events ==%@",response);
            
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr=[outerdic objectForKey:@"events"];
            
            for(NSDictionary *temp in arr){
                NSString *str1=[temp objectForKey:@"event_type_id"];
                NSString *str2=[temp objectForKey:@"event_name"];
                NSString *str3=[temp objectForKey:@"other_events"];
                
                
                NSLog(@"event_type_id==%@ event_name==%@ other_events=%@",str1,str2,str3);
                {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        _eventtypeidStr =str1;
                        _event_name_str=str2;
                        _othereventstr=str3;
                        
                        
                        _event_type_id.text=_eventtypeidStr;
                        _event_type.text=_event_name_str;
                        _otherevents.text=_othereventstr;
                        
                        
                    }];
                }
            }
        }
    }];
    
    [task resume];
    

                                
                                
                                
}
- (IBAction)proceedBtnClicked:(id)sender {
    
    NSLog(@"Proceed Button Clicked==%@",_proceedBtn);
    
    [[NSUserDefaults standardUserDefaults]setValue:self.guestcount.text forKey:@"guestcount"];
     NSLog(@"guest count = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"guestcount"]);
    
    [[NSUserDefaults standardUserDefaults]setValue:self.comments.text forKey:@"comments"];
    NSLog(@"Comments = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"comments"]);
    
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    
    NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"venuefacilityarr"];
    [_venuefacility_arr removeAllObjects];
    if (dataRepresentingSavedArray != nil)
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil)
            _venuefacility_arr = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        else
            _venuefacility_arr = [[NSMutableArray alloc] init];
    }
    [_selectedFacility removeAllObjects];
    for(VenueInfo *temp in _venuefacility_arr)
    {
        
        NSLog(@"VenuefacilityArray****= %@%@",temp.facility_name, temp.userquantity);
        
        if (temp.userquantity!=NULL) {
            [_selectedFacility addObject:temp];
        }
    }
    for(VenueInfo *temp in _selectedFacility)
    {
        
        NSLog(@"SelectedfacilityArray****= %@%@",temp.facility_name, temp.userquantity);
    
    }
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"venuefacilityarr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:_selectedFacility] forKey:@"venuefacilityarr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    

    
//    int value=[[NSUserDefaults standardUserDefaults] objectForKey:@"quantityNumber"];
//    NSLog(@"quantityNumber = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"quantityNumber"]);
    
//    if (_guestcount.text && _guestcount.text.length > 0){
//        
//        NSLog(@"proceed");
//           }
//    else{
//        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Enter number of guests." preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction* ok = [UIAlertAction
//                             actionWithTitle:@"OK"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * action)
//                             {
//                                 [alertView dismissViewControllerAnimated:YES completion:nil];
//                             }];
//        [alertView addAction:ok];
//        [self presentViewController:alertView animated:YES completion:nil];
//    
//    }
    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (!string.length)
    {
        return YES;
    }
    
    if ([string intValue])
    {
        return YES;
    }
    
    return NO;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if (_guestcount.text && _guestcount.text.length > 0){
        if([[segue identifier]isEqualToString:@"showBooking"])
        {
            BookingViewController *t=[segue destinationViewController];
            //        t.service_provider_id_str=_service_id_str;
            t.hotelNamestr=self.service_name_str;
            t.addressstr=self.address_str;
            t.pricedaystr=self.price_day_str;
            t.pricehourstr=self.price_hr_str;
            
            NSLog(@"IN DID SELECT...%@...%@  %@..%@",t.hotelNamestr,_address_str,_price_hr_str,_price_day_str);
        }

        NSLog(@"proceed");
    }
    else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Enter number of guests." preferredStyle:UIAlertControllerStyleAlert];
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

    
    
    
    if ([segue.identifier isEqualToString:@"showpdf"]) {
    
    WebViewController *wvc=[segue destinationViewController];

    wvc.myurl=@"http://localhost/phpmyadmin/MMF/1487309779309.pdf";
    //wvc.myurl=@"http://siddhantedu.com/iOSAPI/images/ITherm2017_Advance_Program.pdf";
    
    
}


}
-(void)setupScrollView:(UIScrollView *)scrMain{
    for (int i=1; i<=4; i++) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"cat1.jpeg"]];
        UIImage *image2=[UIImage imageNamed:[NSString stringWithFormat:@"cat2.jpg"]];
        UIImage *image3=[UIImage imageNamed:[NSString stringWithFormat:@"venue1.jpg"]];
        UIImage *image4=[UIImage imageNamed:[NSString stringWithFormat:@"venue2.jpg"]];
        UIImage *image5=[UIImage imageNamed:[NSString stringWithFormat:@"venue3.jpg"]];
        
        
        [_imgView setImage:image];
        _imgView.animationImages=@[image,image2,image3,image4,image5];
        _imgView.animationDuration=8.0;
        _imgView.tag=i+1;
        
        [_imgView startAnimating];
    }
    
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollingTimer) userInfo:nil repeats:YES];
}
-(void)scrollingTimer{
    
    UIScrollView *scrMain=(UIScrollView *)[self.view viewWithTag:1];
    UIPageControl *pgCtr=(UIPageControl*)[self.view viewWithTag:12];
    CGFloat contentOffset=self.scroll.contentOffset.x;
    
    
    int nextPage=(int)(contentOffset/self.scroll.frame.size.width)+1;
    
    if (nextPage!=5){
        [self.scroll scrollRectToVisible:CGRectMake(nextPage*self.scroll.frame.size.width,0,self.scroll.frame.size.width,self.scroll.frame.size.height)animated:YES];
        pgCtr.currentPage=nextPage;
    }else{
        [self.scroll scrollRectToVisible:CGRectMake(0,0,self.scroll.frame.size.width,self.scroll.frame.size.height)animated:YES];
        
        pgCtr.currentPage=0;
    }
}

-(void)facilityParsing{
    
    [_venuefacility_arr removeAllObjects];
 
    NSString *myst=[NSString stringWithFormat:@"service_provider_id=%@",self.service_provider_id.text];
    
    NSLog(@"##service provider id....%@",myst);
    
    
    
    
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
    
    
    NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_other_facilities.php"];
    //NSURL * url = [NSURL URLWithString:@"http://192.168.1.7/mmf_apis/get_services2.php"];//for booked and available button api
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    //_newurlpass=_urlstr;
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if(error)
    {
        NSLog(@"%@",error.description);
    }
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    if(data==nil)
                                    {
                                        NSLog(@"Data is nil");
                                        
                                    }
                                    
                                    else
                                    {
                                        
                                        NSLog(@"Response====%@",response);
                                        
                                        
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        
                                        NSArray *venuearr=[outerdic objectForKey:@"venuefacility"];
                                        
                                        for(NSDictionary *temp in venuearr)
                                        {
                                            NSString *str1=[temp objectForKey:@"facility_id"];
                                            NSString *str2=[temp objectForKey:@"unit"];
                                            NSString *str3=[temp objectForKey:@"quantity"];
                                            NSString *str4=[temp objectForKey:@"price"];
                                            NSString *str5=[temp objectForKey:@"comments"];
                                            NSString *str6=[temp objectForKey:@"id"];
                                            NSString *str7=[temp objectForKey:@"facility_name"];
                                            
                                            
                                            
                                            
                                            NSLog(@"Other Facility=%@ Unit=   %@   Quantity==%@ Price= %@  Comment=%@  id=%@ facility_name=%@",str1,str2,str3,str4,str5,str6,str7);
                                            VenueInfo *o=[[VenueInfo alloc]init];
                                            o.facility_id=str1;
                                            o.unit=str2;
                                            o.quantity=str3;
                                            o.price=str4;
                                            o.comments=str5;
                                            o.facility_id_no=str6;
                                            o.facility_name=str7;
                                            
                                          int aNumber=[str4 intValue]/[str3 intValue];
                                            
                                            o.price_per_unit = [NSString stringWithFormat:@"%ld",(long)aNumber];
                                            
                                            
                                            NSLog(@"Price per unit===%@,Facility name===%@",o.price_per_unit,o.facility_name);
                                            
//                                            Singleton *mySingleton = [[Singleton alloc]init];
//                                            mySingleton.venuefacilityarray = [[NSMutableArray alloc]init];
//                                            [mySingleton.venuefacilityarray addObject:o];
//                                            if ([str4 intValue] <[str3 intValue]) {
//                                                
//                                                
//                                                NSLog(@"quantity must not be less than price ");
//                                            }
                                            
                                            
                                            [_venuefacility_arr addObject:o];
                                            
                    
                                            [_tableview reloadData];
                                            
                        
                                        }
                                        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:_venuefacility_arr] forKey:@"venuefacilityarr"];
                                        [[NSUserDefaults standardUserDefaults] synchronize];
                                        [_tableview reloadData];
                                        
                                        [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                        }
                                
                                    [_tableview reloadData];
                                }];
    [task resume];
    
    
    [_tableview reloadData];
    
}
-(void)changeUserQuantity:(int)index :(NSString*)userQuantity{
    
   
    NSMutableArray * tempArray = [[NSMutableArray alloc]init];
    [tempArray removeAllObjects];
    
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"venuefacilityarr"];
    if (dataRepresentingSavedArray != nil)
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil)
            tempArray = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        else
            tempArray = [[NSMutableArray alloc] init];
    }
    if(tempArray.count>0)
    {
        VenueInfo *v =[tempArray objectAtIndex:index];
        v.userquantity=userQuantity;
        [tempArray removeObjectAtIndex:index];
        [tempArray insertObject:v atIndex: index];
        NSLog(@"changed user quntity==%@",v.userquantity);
       NSLog(@"index to change==%d",index);
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"venuefacilityarr"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:tempArray] forKey:@"venuefacilityarr"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    NSLog(@"Facility venue array==%@",tempArray);
    NSLog(@"temp array length==%ld",tempArray.count);

    

}
- (IBAction)checkBoxBtnClicked:(id)sender {
    
    UIButton *btn =(UIButton *)sender;
    VenueInfo *vinfo=self.venuefacility_arr[btn.tag];
    //[btn setUserInteractionEnabled:YES];
    if([[btn imageForState:UIControlStateNormal]isEqual:[UIImage imageNamed:@"tick.jpg"]])
        
    {
        [btn setImage:[UIImage imageNamed:@"untick.png"] forState:UIControlStateNormal];
        NSLog(@"gray tick clicked...");
        NSLog(@"Facility id:-...%@",vinfo.facility_id);
        NSString *str=[NSString stringWithFormat:@"%@",vinfo.facility_id];
        [_selectedFacility addObject:str];
        
        NSLog(@"after adding count is %lu",(unsigned long)_selectedFacility.count);
        
    }
    
    else
    {
        //[btn setUserInteractionEnabled:NO];
        [btn setImage:[UIImage imageNamed:@"tick.png"] forState:UIControlStateNormal];
        
        NSLog(@"blue tick clicked...");
        NSString *str=[NSString stringWithFormat:@"%@",vinfo.facility_id];
        if([_selectedFacility isEqual:[NSNull null]])
        {
            NSLog(@"Array is EMPTY");
        }
        else
        {
            [_selectedFacility removeObject:str];
            
            NSLog(@"after removing count is%lu",(unsigned long)_selectedFacility.count);
            
        }
    }
    NSLog(@"Btn Click...........%ld",(long)btn.tag);
}
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numOfSections = 0;
    if ([self.venuefacility_arr count] > 0)
    {
        _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        numOfSections                = 1;
        _tableview.backgroundView = nil;
    }
    else
    {
        UILabel *noDataLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _tableview.bounds.size.width, _tableview.bounds.size.height)];
        noDataLabel.text             = @"No extra facility available...";
        noDataLabel.textColor        = [UIColor grayColor];
        noDataLabel.textAlignment    = NSTextAlignmentCenter;
        //_tableview.backgroundView = noDataLabel;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return numOfSections;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _venuefacility_arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  VenueInfoTableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   
    VenueInfo *vinfo=[[VenueInfo alloc]init];
    vinfo=[_venuefacility_arr objectAtIndex:indexPath.row];

  NSLog(@"Facility indexpath==%@",_venuefacility_arr);
    
    cell.facility_name.text=vinfo.facility_name;
    cell.quantity.text=vinfo.quantity;
    cell.price.text=vinfo.price;
    cell.comments.text=vinfo.comments;
    cell.facility_id.text=vinfo.facility_id;
    cell.facility_id_no.text=vinfo.facility_id_no;
    cell.unit.text=vinfo.unit;
    
    if(vinfo.userquantity!=nil)
    {
        cell.quantity_no_txtfld.text = vinfo.userquantity;
    }
    else
    {
        cell.quantity_no_txtfld.text=NULL;
    }
    
    cell.checkBoxBtn.tag=indexPath.row;
    cell.tag=indexPath.row;
 
   return  cell;

}
*/
- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    
    if(section==0)
    {
        return YES;
    }
    else
        return NO;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numOfSections = 0;
    if ([self.venuefacility_arr count] > 0)
    {
        _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        numOfSections                = 1;
        _tableview.backgroundView = nil;
    }
    else
    {
        UILabel *noDataLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _tableview.bounds.size.width, _tableview.bounds.size.height)];
        noDataLabel.text             = @"No extra facility available...";
        noDataLabel.textColor        = [UIColor grayColor];
        noDataLabel.textAlignment    = NSTextAlignmentCenter;
        //_tableview.backgroundView = noDataLabel;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return numOfSections;

   // return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self tableView:tableView canCollapseSection:section])
    {
        if ([expandedSections containsIndex:section])
        {
            return _venuefacility_arr.count; // return rows when expanded
        }
        
        return 1; // only top row showing
    }
    
    // Return the number of rows in the section.
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    VenueInfoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    VenueInfo *vinfo=self.venuefacility_arr[indexPath.row];
 
 //VenueInfo *vinfo=[[VenueInfo alloc]init];
// vinfo=[_venuefacility_arr objectAtIndex:indexPath.row];
 
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            
            if(vinfo.facility_name==(NSString *) [NSNull null])
            {
                vinfo.facility_name=@"-";
            }
            if(vinfo.quantity==(NSString *) [NSNull null])
            {
                vinfo.quantity=@"-";
            }
            if(vinfo.price==(NSString *) [NSNull null])
            {
                vinfo.price=@"-";
            }
            if(vinfo.comments==(NSString *) [NSNull null])
            {
                vinfo.comments=@"-";
            }
            if(vinfo.facility_id==(NSString *) [NSNull null])
            {
                vinfo.facility_id=@"-";
            }
            if(vinfo.facility_id_no==(NSString *) [NSNull null])
            {
                vinfo.facility_id_no=@"-";
            }
            if(vinfo.unit==(NSString *) [NSNull null])
            {
                vinfo.unit=@"-";
                // cell.country.hidden=YES;
            }
            else
            {
               // NSString *name=[NSString stringWithFormat:@"%@ %@ %@",aut.salutation,aut.first_name,aut.last_name];
        cell.facility_name.text=vinfo.facility_name;

 
                [cell.quantity setHidden:NO];
                [cell.price setHidden:NO];
                [cell.comments setHidden:NO];
                [cell.facility_id setHidden:NO];
                [cell.facility_id_no setHidden:NO];
                [cell.unit setHidden:NO];
                [cell.btnread setHidden:YES];
               
 
                cell.quantity.text=vinfo.quantity;
                cell.price.text=vinfo.price;
                cell.comments.text=vinfo.comments;
                cell.facility_id.text=vinfo.facility_id;
                cell.facility_id_no.text=vinfo.facility_id_no;
                cell.unit.text=vinfo.unit;
            }
            
            
            if ([expandedSections containsIndex:indexPath.section])
            {
               // cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
               
            }
            else
            {
                cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
            }
        }
        else
        {
            
            
 if(vinfo.facility_name==(NSString *) [NSNull null])
 {
 vinfo.facility_name=@"-";
 }
 if(vinfo.quantity==(NSString *) [NSNull null])
 {
 vinfo.quantity=@"-";
 }
 if(vinfo.price==(NSString *) [NSNull null])
 {
 vinfo.price=@"-";
 }
 if(vinfo.comments==(NSString *) [NSNull null])
 {
 vinfo.comments=@"-";
 }
 if(vinfo.facility_id==(NSString *) [NSNull null])
 {
 vinfo.facility_id=@"-";
 }
 if(vinfo.facility_id_no==(NSString *) [NSNull null])
 {
 vinfo.facility_id_no=@"-";
 }
 if(vinfo.unit==(NSString *) [NSNull null])
 {
 vinfo.unit=@"-";
 // cell.country.hidden=YES;
 }
            else
            {
               // NSString *name=[NSString stringWithFormat:@"%@ %@ %@",aut.salutation,aut.first_name,aut.last_name];
               cell.facility_name.text=vinfo.facility_name;
 
 [cell.quantity setHidden:NO];
 [cell.price setHidden:NO];
 [cell.comments setHidden:NO];
 [cell.facility_id setHidden:NO];
 [cell.facility_id_no setHidden:NO];
 [cell.unit setHidden:NO];
 [cell.btnread setHidden:YES];

                
 cell.quantity.text=vinfo.quantity;
 cell.price.text=vinfo.price;
 cell.comments.text=vinfo.comments;
 cell.facility_id.text=vinfo.facility_id;
 cell.facility_id_no.text=vinfo.facility_id_no;
 cell.unit.text=vinfo.unit;

            }
        }
    }
 
    if(indexPath.section==1)
    {
        cell.facility_name.text=_facilities_str;
        [cell.facility_name setNumberOfLines:8];
        [cell.facility_name setTextAlignment:NSTextAlignmentJustified];
        [cell.facility_name setFont:[UIFont systemFontOfSize:12]];
        //   cell.authorname.font=[UIFont systemFontOfSize:cell.country];
        [cell.quantity setHidden:NO];
        [cell.price setHidden:NO];
        [cell.comments setHidden:NO];
        [cell.facility_id setHidden:NO];
        [cell.facility_id_no setHidden:NO];
        [cell.unit setHidden:NO];
        [cell.btnread setHidden:NO];
    }
    
    return cell;
}
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if ([self tableView:tableView canCollapseSection:indexPath.section])
 {
 if (!indexPath.row)
 {
 // only first row toggles exapand/collapse
 [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
 NSInteger section = indexPath.section;
 BOOL currentlyExpanded = [expandedSections containsIndex:section];
 NSInteger rows;
 
 NSMutableArray *tmpArray = [NSMutableArray array];
 
 if (currentlyExpanded)
 {
 rows = [self tableView:tableView numberOfRowsInSection:section];
 [expandedSections removeIndex:section];
 
 }
 else
 {
 [expandedSections addIndex:section];
 rows = [self tableView:tableView numberOfRowsInSection:section];
 }
 
 for (int i=1; i<rows; i++)
 {
 NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i
 inSection:section];
 [tmpArray addObject:tmpIndexPath];
 }
 
 UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
 
 if (currentlyExpanded)
 {
 [tableView deleteRowsAtIndexPaths:tmpArray
 withRowAnimation:UITableViewRowAnimationTop];
 
 cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
 
 }
 else
 {
 [tableView insertRowsAtIndexPaths:tmpArray
 withRowAnimation:UITableViewRowAnimationTop];
 //cell.accessoryView =  [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
 
 }
 }
 }
 }
 
 
 -(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 if(section==1)
 {
 return @"Facilities";
 }
 return 0;
 }

 - (IBAction)readClick:(id)sender {
 
 
// self.btnrea.layer.masksToBounds=YES;
// self.btnRead.layer.borderColor=[UIColor blueColor].CGColor;
// self.btnRead.layer.borderWidth=1.1;
// self.btnRead.layer.cornerRadius=10;//    AbstractViewController *abs=[[AbstractViewController alloc]init];
 //    abs.absstrstr=_abstractstr;
 //    NSLog(@"%@",_abstractstr);
 }


-(void)getTieupServcies
{
    
    NSString *myst=[NSString stringWithFormat:@"service_provider_id=%@",_service_provider_id_str];
    
    NSLog(@"Tie up venue SERVICE PROVIDER ID.......%@",myst);
    
    
    
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *urlstr=@"http://localhost/phpmyadmin/MMF/get_tieup_services.php";
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [request setHTTPMethod:@"POST"];
    NSLog(@"service provider id aftr post===%@",_service_provider_id_str);
    [request setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    if(data==nil)
                                    {
                                        NSLog(@"Data is nil");
                                    }
                                    else
                                    {
                                        NSLog(@"Response tieup venue===%@",response);
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        
                                        NSLog(@"Outer dic==venue===%@",outerdic);
                                        
                                        NSArray *arr=[outerdic objectForKey:@"getservices"];
                                        
                                        NSLog(@"Venu info keyarr==%@",[outerdic objectForKey:@"getservices"]);
                                        
                                        for(NSDictionary *temp in arr)
                                        {
                                            NSString *str1=[temp objectForKey:@"mapped_service_provider_id"];
                                            NSString *str2=[temp objectForKey:@"role_id"];
                                            NSString *str3=[temp objectForKey:@"service_name"];
                                            NSString *str4=[temp objectForKey:@"address"];
                                            NSString *str5=[temp objectForKey:@"contact"];
                                            NSString *str6=[temp objectForKey:@"role_name"];
                                          
                    
                                            
                                            {
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{ _mappedServiceProviderIdStr=str1;
                                                    _roleidStr=str2;
                                                    _tieupserviceNameStr=str3;
                                                    _tieupAddressStr=str4;
                                                    _tieupContactStr=str5;
                                                    _roleNameStr=str6;
                                                  
                                                    
                                                    _mapped_service_provider_id.text=_mappedServiceProviderIdStr;
                                                    _role_id.text=_roleidStr;
                                                    _servicename.text=_tieupserviceNameStr;
                                                    _tieup_address.text=_tieupAddressStr;
                                                    _tieup_contact.text=_tieupContactStr;
                                                    _role_name.text=_roleNameStr;
                                                                                                
                                                    
                                                }];
                                                
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                }];
    [task resume];
    
}
-(void)getTieupRoles
{
    
    NSString *myst=[NSString stringWithFormat:@"service_provider_id=%@",_service_provider_id_str];
    
    NSLog(@"Tie up venue SERVICE PROVIDER ID.......%@",myst);
    
    
    
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *urlstr=@"http://localhost/phpmyadmin/MMF/get_tieup_roles.php";
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [request setHTTPMethod:@"POST"];
    NSLog(@"service provider id aftr post===%@",_service_provider_id_str);
    [request setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    if(data==nil)
                                    {
                                        NSLog(@"Data is nil");
                                    }
                                    else
                                    {
                                        NSLog(@"Response tieup venue===%@",response);
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        
                                        NSLog(@"Outer dic==venue===%@",outerdic);
                                        
                                        NSArray *arr=[outerdic objectForKey:@"getrole"];
                                        
                                        NSLog(@"Venue tie-up keyarr==%@",[outerdic objectForKey:@"getrole"]);
                                        
                                        for(NSDictionary *temp in arr)
                                        {
                                            
                                            NSString *str1=[temp objectForKey:@"role_id"];
                                            NSString *str2=[temp objectForKey:@"role_name"];
                                            
                                            
                                            
                                            {
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                    _roleidStr=str1;
                                                    _roleNameStr=str2;
                                                    
                                                    
                                                    
                                                    _role_id.text=_roleidStr;
                                                           _tieuprole_name.text=_roleNameStr;
                                                    
                                                    
                                                }];
                                                
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                }];
    [task resume];
    
}


@end
