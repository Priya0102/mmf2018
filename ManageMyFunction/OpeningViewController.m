//
//  OpeningViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 7/10/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "OpeningViewController.h"
#import "OpeningTableViewCell.h"
#import "VenueInfoViewController.h"
#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"
#import "VenueViewController.h"
//#import <SDWebImage/UIImageView+WebCache.h>
#import "Opening.h"
@interface OpeningViewController ()

@property (nonatomic, readonly) CGFloat offset;


@end

@implementation OpeningViewController{
    
float fadeAlpha;
NSMutableArray *keyarr1,*keyarr2,*keyarr;
    NSArray *varr;
}
@synthesize guestBtnSelect;
@synthesize typeBtnSelect;
@synthesize areaBtnSelect;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    _event_lbl.text=_eventStr;
    _capacity1.text=_capacity_str1;
    _capacity_str1=@"0";
    _capacity_str2=@"5000";
    _venuetypeid_str=@"0";
    _areaid=@"0";
    _city_idstr=@"0";
    
    _allvenueBtn.layer.borderWidth = 1;
    _allvenueBtn.layer.borderColor = [[UIColor cyanColor] CGColor];
    _allvenueBtn.layer.cornerRadius = 5;
    _allvenueBtn.clipsToBounds = YES;
    
    
    
    self.start_date.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"startdate"];//storing for temprorary
    self.end_date.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"enddate"];
    self.start_time.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"startTime"];
    self.end_time.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"endTime"];
    
    //_event_lbl.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"eventName"];
    
    keyarr1= [[NSMutableArray alloc]init];
    keyarr=[[NSMutableArray alloc]init];
    varr = [[NSArray alloc] init];
    
    [_indicator startAnimating];
    [self.tableview setSeparatorColor:[UIColor clearColor]];

//    if (guestBtnSelect.titleLabel.text!=NULL) {
//        _capacity_str =guestBtnSelect.titleLabel.text;
//        _capacitiesarr = [_capacity_str componentsSeparatedByString:@"-"];
//        _capacity_str1=_capacitiesarr[0];
//        _capacity_str2=_capacitiesarr[1];
//    }
//    if (areaBtnSelect.titleLabel.text!=NULL) {
//        _area_namestr=areaBtnSelect.titleLabel.text;
//    }
//    if (typeBtnSelect.titleLabel.text!=NULL) {
//        _venue_namestr=typeBtnSelect.titleLabel.text;
//    }
    fadeAlpha = 0.5f;
    guestBtnSelect.layer.borderWidth = 1;
    guestBtnSelect.layer.borderColor = [[UIColor blackColor] CGColor];
    guestBtnSelect.layer.cornerRadius = 5;
    
    typeBtnSelect.layer.borderWidth = 1;
    typeBtnSelect.layer.borderColor = [[UIColor blackColor] CGColor];
    typeBtnSelect.layer.cornerRadius = 5;
    
    areaBtnSelect.layer.borderWidth = 1;
    areaBtnSelect.layer.borderColor = [[UIColor blackColor] CGColor];
    areaBtnSelect.layer.cornerRadius = 5;
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _servicenamearr=[[NSMutableArray alloc]init];
    _addressarr=[[NSMutableArray alloc]init];
    _areaarr=[[NSMutableArray alloc]init];
    _cityarr=[[NSMutableArray alloc]init];
    _capacityarr=[[NSMutableArray alloc]init];
    _imgarray=[[NSMutableArray alloc]init];
    _foodarr=[[NSMutableArray alloc]init];
    _service_idarr=[[NSMutableArray alloc]init];
    _servicearr=[[NSMutableArray alloc]init];
    _availablearr=[[NSMutableArray alloc]init];
    
    NSLog(@"+++++++Service ID...%@",_service_id_str);
     [self dataParsing];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Set the current view controller to the one embedded (in the storyboard).
    self.currentViewController = self.childViewControllers.firstObject;
}
- (void)viewDidUnload {
   // [guestBtnSelect release];
     guestBtnSelect = nil;
    [self setGuestBtnSelect:nil];
    
     areaBtnSelect=nil;
    [self setAreaBtnSelect:nil];
    [super viewDidUnload];
}
-(IBAction)guestselectClicked:(id)sender {
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"50-100", @"100-500", @"500-1000",@"1000-2000",@"2000-5000", nil];
    
    NSArray * arrImage = [[NSArray alloc] init];
    
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        
        NSLog(@"Sender Value===%@",arr);
        
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}
-(void)dealloc{
    
}

-(IBAction)areaselectClicked:(id)sender {
    
    
    [_imgarray removeAllObjects];
    [_servicenamearr removeAllObjects];
    [_service_idarr removeAllObjects];
    [_addressarr removeAllObjects];
    [_areaarr removeAllObjects];
    [_cityarr removeAllObjects];
    [_capacityarr removeAllObjects];
    [_foodarr removeAllObjects];
    [_servicearr removeAllObjects];
    [_availablearr removeAllObjects];
 
    NSString *myst=[NSString stringWithFormat:@"city_id=%d",1];
    NSLog(@"CITY ID.......%@",myst);
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_area.php"];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask *task=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    if(data==nil)
                                    {
                                        NSLog(@"Data is nil");
                                    }
                                    else
                                    {
                                        NSLog(@"%@",response);
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        
                                        
                                        keyarr1= [[NSMutableArray alloc]init];
                                     
                                         keyarr= (NSMutableArray*)[outerdic objectForKey:@"areas"];
                                        
//                                    NSArray *keyarr= (NSArray*)[outerdic objectForKey:@"areas"];
                                        
                                        NSUInteger count=sizeof(keyarr);
                                        NSUInteger i=0;
                                        //
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            NSString *str1=[temp objectForKey:@"area_name"];
                                            NSString *areaid=[temp objectForKey:@"id"];
                                            
                                            if(count>i)
                                            {
                                                [keyarr1 addObject:str1];
                                                
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                    _arealbl.text=_area_namestr;
                                                    _area_id.text=_area_idstr;
                                                    
                                                    
                                                    NSLog(@"Area name%@  Area id==%@",str1,areaid);
                                                    
//                                                    NSUInteger index = 0;
//                                                    for(NSString *string in keyarr)
//                                                    {
//                                                        NSLog(@"%@ is at index %lu", string, (unsigned long)index);
//                                                        
//                                                        index++;
//                                                    }
//                                                    
                                                    
                                                    
                                                    [_indicator stopAnimating];
                                                    
                                                }];
                                        
                                                NSString *test=[keyarr1 objectAtIndex:i];
                                                
                                                NSLog(@"Area====%@",test);
                                            }
                                            i++;
                                            
                                        }
                                        NSArray * arrImage = [[NSArray alloc] init];
                                        
                                        if(dropDown == nil) {
                                            CGFloat f = 200;
                                            dropDown = [[NIDropDown alloc]showDropDown:sender :&f :keyarr1 :arrImage :@"down"];
                                            dropDown.delegate = self;
                                        }
                                        else {
                                            [dropDown hideDropDown:sender];
                                            [self rel];
                                        }
                                     // [self getFilterVenue];
                                    }
                                    
                                }];
    
    
    [task resume];
    
    
//    NSString *myst2=[NSString stringWithFormat:@"city_id=%@&event_name=%@&area_id=%@",self.city_id.text,self.event_lbl.text,self.area_id.text];
//    
//    NSLog(@"POST CONTAINT AREA id....%@",myst);
//    
//    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
//    
//
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
//    
//    NSURL * url2 = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_filter_area.php"];
//    
//    
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url2];
//    //_newurlpass=_urlstr;
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[myst2 dataUsingEncoding:NSUTF8StringEncoding]];
//    NSError *error=nil;
//    if(error)
//    {
//        NSLog(@"%@",error.description);
//    }
//    
//    
//    NSURLSessionDataTask *task2=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
//                                {
//                                    
//                                    if(data==nil)
//                                    {
//                                        NSLog(@"Data is nil");
//                                        
//                                    }
//                                    
//                                    else
//                                    {
//                                        
//                                        
//                                        NSLog(@"%@",response);
//                                        
//                                        
//                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//                                        
//                                        NSArray *panelarr=[outerdic objectForKey:@"venuefilter"];
//                                        
//                                        for(NSDictionary *temp in panelarr)
//                                        {
//                                            NSString *str1=[temp objectForKey:@"service_name"];
//                                            NSString *str2=[temp objectForKey:@"address"];
//                                            NSString *str3=[temp objectForKey:@"area_name"];
//                                            NSString *str4=[temp objectForKey:@"service_provider_id"];
//                                            NSString *str5=[temp objectForKey:@"cover_images"];
//                                            NSString *str6=[temp objectForKey:@"city_id"];
//                                            NSString *str7=[temp objectForKey:@"capacity"];
//                                            NSString *str8=[temp objectForKey:@"food_type_id"];
//                                            NSString *str9=[temp objectForKey:@"role_id"];
//                                            NSString *str10=[temp objectForKey:@"established_year"];
//                                            NSString *str11=[temp objectForKey:@"contact"];
//                                            NSString *str12=[temp objectForKey:@"area_id"];
//                                            NSString *str13=[temp objectForKey:@"is_active"];
//                                            NSString *str14=[temp objectForKey:@"allow_other_caterer"];
//                                            // NSString *str15=[temp objectForKey:@"available"];
//                                            
//                                            NSLog(@"Service_name=%@ Address=%@   Area_name==%@ Service_provider_id= %@  cover_images= %@  city_id=%@  capacity=%@  food_type_id=%@  roleid=%@ established_year=%@ contact=%@ area_id=%@ is_active=%@ allow_other_caterer=%@",str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str14);
//                                           
//                                            
//                                            [_servicearr addObject:str1];
//                                            [_addressarr addObject:str2];
//                                            [_areaarr addObject:str3];
//                                            [_service_idarr addObject:str4];
//                                            // [_imgarray addObject:str5];
//                                            [_city_idarr addObject:str6];
//                                            [_capacityarr addObject:str7];
//                                            [_foodarr addObject:str8];
//                                            [_role_id_arr addObject:str9];
//                                            [_established_arr addObject:str10];
//                                            [_contact_arr addObject:str11];
//                                            [_area_idarr addObject:str12];
//                                            [_isActivearr addObject:str13];
//                                           // [_availablearr addObject:str15];
//                                            
//                                            [_allow_other_catererarr addObject:str14];
//                                            
//                                            Opening *o=[[Opening alloc]init];
//                                            o.sevicename=str1;
//                                            o.address=str2;
//                                            o.area_name=str3;
//                                            o.service_provider_id=str4;
//                                            o.img=str5;
//                                            o.city_id=str6;
//                                            o.capacity=str7;
//                                            o.food_type_id=str8;
//                                            o.role_id=str9;
//                                            o.established_year=str10;
//                                            o.contact=str11;
//                                            o.area_id=str12;
//                                            o.isActive=str13;
//                                            o.allowOtherCaterer=str14;
//                                            //o.available=str15;
//                                            
//                                            [_servicenamearr addObject:o];
//                                            [_tableview reloadData];
//                                            
//                                            
//                                            //                                                                if([_imgarray isEqual:[NSNull null]])
//                                            //                                                                                    {
//                                            //                                                                                        _imgarray=@"--";
//                                            //                                                                                    }
//                                            //                                                                                    else
//                                            //                                                                                    {
//                                            //                                                                                       // _imgarray=_img;
//                                            //                                                                                    }
//                                            
//                                            //NSString *tempimgstr=str5;
//                                            // [_imgarray sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
//                                            //                                                       placeholderImage:[UIImage imageNamed:@"default.png"]];
//                                        }
//                                        
//                                        [_tableview reloadData];
//                                        //
//                                        [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
//                                        dispatch_async(dispatch_get_main_queue(), ^{
//                                            [_tableview reloadData];
//                                        });
//                                    }
//                                    //}
//                                    [_tableview reloadData];
//                                }];
//    [task2 resume];
//    
//
    
}
//-(IBAction)typeselectClicked:(id)sender {
//    
//    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"venue_type_id"];
//    
//    NSString *myst=[NSString stringWithFormat:@"venue_type_id=%@",savedvalue2];
//    NSLog(@"Venue Type ID.......%@",myst);
//    
//    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
//    
//    NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_venuetype.php"];
//    
//    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
//    [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    NSURLSessionDataTask *task=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
//                                {
//                                    
//                                    if(data==nil)
//                                    {
//                                        NSLog(@"Data is nil");
//                                    }
//                                    else
//                                    {
//                                        NSLog(@"%@",response);
//                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//                                        
//                                        
//                                        keyarr2= [[NSMutableArray alloc]init];
//                                        
//                                        NSArray *keyarr= (NSArray*)[outerdic objectForKey:@"venues"];
//                                        
//                                        NSUInteger count=sizeof(keyarr);
//                                        NSUInteger i=0;
//                                        //
//                                        for(NSDictionary *temp in keyarr)
//                                        {
//                                            NSString *str1=[temp objectForKey:@"venue_type_name"];
//                                            NSString *venueid=[temp objectForKey:@"venue_type_id"];
//                                            
//                                            if(count>i)
//                                            {
//                                                [keyarr2 addObject:str1];
//                                                
//                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//                                                    _venue_type.text=_venue_namestr;
//                                                    _venue_type_id.text=_venuetypeid_str;
//                                                    
//                                                    
//                                                    NSLog(@"Venue Type name%@  Venue Type id==%@",str1,venueid);
//                                                    
//                                                    [_indicator stopAnimating];
//                                                    
//                                                }];
//                                                
//                                                NSString *test=[keyarr2 objectAtIndex:i];
//                                                
//
//                                            }
//                                            i++;
//                                            
//                                        }
//                                        NSArray * arrImage = [[NSArray alloc] init];
//                                        
//                                        if(dropDown == nil) {
//                                            CGFloat f = 200;
//                                            dropDown = [[NIDropDown alloc]showDropDown:sender :&f :keyarr2 :arrImage :@"down"];
//                                            dropDown.delegate = self;
//                                        }
//                                        else {
//                                            [dropDown hideDropDown:sender];
//                                            [self rel];
//                                        }
//                                        
//                                    }
//                                    
//                                }];
//    
//    
//    [task resume];
//
//}
//
//
-(IBAction)typeselectClicked:(id)sender {
    
    
    varr = [NSArray arrayWithObjects:@"Hall", @"Hotel", @"Conference Hall",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    
    
    
    if(dropDown == nil) {
        CGFloat f = 120;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :varr :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
    //[self getFilterVenue];
}

- (void)niDropDownDelegateMethod: (NIDropDown *) sender {
    
    [self rel];
    
    if (guestBtnSelect.titleLabel.text!=NULL) {
        
    _capacity_str =guestBtnSelect.titleLabel.text;
    _capacitiesarr = [_capacity_str componentsSeparatedByString:@"-"];
    _capacity_str1=_capacitiesarr[0];
    _capacity_str2=_capacitiesarr[1];
        
         NSLog(@"Capacity str1==%@",_capacity_str1);
         NSLog(@"Capacity str2==%@",_capacity_str2);
        
    NSLog(@"Capacity is not null**%@",guestBtnSelect.titleLabel.text);
    }
    
    if (areaBtnSelect.titleLabel.text!=NULL) {
    _area_namestr=areaBtnSelect.titleLabel.text;
        NSLog(@"Area is not null**%@",areaBtnSelect.titleLabel.text);
        
        NSInteger anIndex=[keyarr1 indexOfObject:(NSString*)_area_namestr];
        
        _areaid=_area_idarr[anIndex];
        NSDictionary *area_data=keyarr[anIndex];
        NSLog(@"Index path for area id==%@",area_data);
      
        _areaid=[area_data objectForKey:@"id"];
        
        NSLog(@"Area ID is==**%@",_areaid);
     
        NSLog(@"***INDEX***%ld",(long)anIndex);
        if (NSNotFound==anIndex) {
            NSLog(@"not found");
        }
     /*   NSNumber *num=[NSNumber numberWithInteger:56];//this is used to get index of item in NSArray
        NSInteger anIndex=[myArray indexOfObject:num];
        if(NSNotFound == anIndex) {
            NSLog(@"not found");}
     */

    if (typeBtnSelect.titleLabel.text!=NULL) {
        
    _venue_namestr=typeBtnSelect.titleLabel.text;
        NSLog(@"Venue is not null**%@",typeBtnSelect.titleLabel.text);
        
        NSInteger anIndex=[varr indexOfObject:(NSString*)_venue_namestr];
        
        _venuetypeid_str=[NSString stringWithFormat:@"%ld",(long)++anIndex];
        NSLog(@"Index path for Venue type ID==%@",_venuetypeid_str);
        if (NSNotFound==anIndex) {
            NSLog(@"not found");
            
        }
    }
    
    NSLog(@"Guest==%@", guestBtnSelect.titleLabel.text);
    NSLog(@"Area===%@", areaBtnSelect.titleLabel.text);
    NSLog(@"Venue Type ====%@", typeBtnSelect.titleLabel.text);

    }
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}


-(void)viewWillAppear:(BOOL)animated
{
//    
//   [self dataParsing];
//    [_tableview reloadData];
}
-(void)dataParsing
{
    [_imgarray removeAllObjects];
    [_servicenamearr removeAllObjects];
    [_service_idarr removeAllObjects];
    [_addressarr removeAllObjects];
    [_areaarr removeAllObjects];
    [_cityarr removeAllObjects];
    [_capacityarr removeAllObjects];
    [_foodarr removeAllObjects];
    [_servicearr removeAllObjects];

    [_availablearr removeAllObjects];
    
    queue=dispatch_queue_create("images", DISPATCH_QUEUE_CONCURRENT);
    queue=dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    
    NSString *myst=[NSString stringWithFormat:@"start_date=%@&end_date=%@&start_time=%@&end_time=%@&city=%@&event=%@&capacity1=%@&capacity2=%@&area=%@&venue_type=%@",self.start_date.text,self.end_date.text,self.start_time.text,self.end_time.text,_city_str,_eventStr,_capacity_str1,_capacity_str2,_areaid,_venuetypeid_str];
    
        NSLog(@"POST CONTAINT....%@",myst);
    
 

    
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];

    
  // NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_services.php"];
     NSURL * url = [NSURL URLWithString:@"http://192.168.1.11/mmf_apis/get_services1.php"];//for booked and available button api
    
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
                                        
                                        
                                        NSLog(@"%@",response);
                                        
                                        
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        
                                        NSArray *panelarr=[outerdic objectForKey:@"venues"];
                                        
                                        for(NSDictionary *temp in panelarr)
                                        {
                                            NSString *str1=[temp objectForKey:@"service_name"];
                                            NSString *str2=[temp objectForKey:@"address"];
                                            NSString *str3=[temp objectForKey:@"area_name"];
                                            NSString *str4=[temp objectForKey:@"service_provider_id"];
                                            
                                            NSString *str5=[temp objectForKey:@"cover_images"];
                                            
                                            //NSString *str6=[temp objectForKey:@"city_name"];
                                            NSString *str7=[temp objectForKey:@"capacity"];
                                            NSString *str8=[temp objectForKey:@"food_type_id"];
                                            //NSString *str9=[temp objectForKey:@"role_id"];
                                            NSString *str10=[temp objectForKey:@"available"];
                                            
                                            
                                            
                                            NSLog(@"Service_name=%@ Address=   %@   Area_name==%@ Service_provider_id= %@  %@  %@  %@ Available=%@",str1,str2,str3,str4,str5,str7,str8,str10);
                                            

                                            
                                            [_servicearr addObject:str1];
                                            [_addressarr addObject:str2];
                                            [_areaarr addObject:str3];
                                            [_service_idarr addObject:str4];
                                           // [_imgarray addObject:str5];
                                            //[_cityarr addObject:str6];
                                            [_capacityarr addObject:str7];
                                            [_foodarr addObject:str8];
                                            //[_role_id_arr addObject:str9];
                                            [_availablearr addObject:str10];
                                            

                                            
                                            Opening *o=[[Opening alloc]init];
                                            o.sevicename=str1;
                                            o.address=str2;
                                            o.area_name=str3;
                                            o.service_provider_id=str4;
                                            o.img=str5;
                                            //o.city_name=str6;
                                            o.capacity=str7;
                                            o.food_type_id=str8;
                                            //o.role_id=str9;
                                            o.available=str10;
                                            
                                    
                                            
                                            [_servicenamearr addObject:o];
                                            [_tableview reloadData];
                                            
                                            
                                           
                                            
                                            //                                                                if([_imgarray isEqual:[NSNull null]])
                                            //                                                                                    {
                                            //                                                                                        _imgarray=@"--";
                                            //                                                                                    }
                                            //                                                                                    else
                                            //                                                                                    {
                                            //                                                                                       // _imgarray=_img;
                                            //                                                                                    }
                                            
                                            //NSString *tempimgstr=str5;
                                            // [_imgarray sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
                                            //                                                       placeholderImage:[UIImage imageNamed:@"default.png"]];
                                        }
                                        
                                         [_tableview reloadData];
                                        //
                                        [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                        //                                            dispatch_async(dispatch_get_main_queue(), ^{
                                        //                                                [_tableview reloadData];
                                        //                                            });
                                    }
                                    //}
                                    [_tableview reloadData];
                                }];
    [task resume];
    
//
    
    [_tableview reloadData];
}

/*-(void)getFilterVenue
{
//    [_imgarray removeAllObjects];
//    [_servicenamearr removeAllObjects];
//    [_service_idarr removeAllObjects];
//    [_addressarr removeAllObjects];
//    [_areaarr removeAllObjects];
//    [_cityarr removeAllObjects];
//    [_capacityarr removeAllObjects];
//    [_foodarr removeAllObjects];
//    [_servicearr removeAllObjects];
//    
    
    
//    queue=dispatch_queue_create("images", DISPATCH_QUEUE_CONCURRENT);
//    queue=dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    
    NSString *myst=[NSString stringWithFormat:@"city_id=%@&event_name=%@&area_id=%@&venue_type_id=%@&allow_other_caterer=%@&capacity1=%@&capacity2=%@",self.city_id.text,self.event_lbl.text,self.area_id.text,self.venue_type_id.text,self.allow_other_caterer.text,self.capacity1.text,self.capacity2.text];
    
    NSLog(@"POST CONTAINT filter....%@",myst);
    
//    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[cd] %@",self.arealbl.text];
//    self.filteredarray = [self.area_namearr filteredArrayUsingPredicate:bPredicate];
//    NSLog(@"HERE %@",self.filteredarray);
//
//    
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
   // NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
     NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_filter_venue.php"];

    
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
                                        
                                        
                                        NSLog(@"%@",response);
                                        
                                        
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        
                                        NSArray *panelarr=[outerdic objectForKey:@"venuefilter"];
                                        
                                        for(NSDictionary *temp in panelarr)
                                        {
                                            NSString *str1=[temp objectForKey:@"service_name"];
                                            NSString *str2=[temp objectForKey:@"address"];
                                            NSString *str3=[temp objectForKey:@"area_name"];
                                            NSString *str4=[temp objectForKey:@"service_provider_id"];
                                            NSString *str5=[temp objectForKey:@"cover_images"];
                                            NSString *str6=[temp objectForKey:@"city_id"];
                                            NSString *str7=[temp objectForKey:@"capacity"];
                                            NSString *str8=[temp objectForKey:@"food_type_id"];
                                            NSString *str9=[temp objectForKey:@"role_id"];
                                            NSString *str10=[temp objectForKey:@"established_year"];
                                            NSString *str11=[temp objectForKey:@"contact"];
                                            NSString *str12=[temp objectForKey:@"area_id"];
                                            NSString *str13=[temp objectForKey:@"is_active"];
                                            NSString *str14=[temp objectForKey:@"allow_other_caterer"];
                                           // NSString *str15=[temp objectForKey:@"available"];
                                            
                                            NSLog(@"Service_name=%@ Address=%@   Area_name==%@ Service_provider_id= %@  cover_images= %@  city_id=%@  capacity=%@  food_type_id=%@  roleid=%@ established_year=%@ contact=%@ area_id=%@ is_active=%@ allow_other_caterer=%@",str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str14);
                                            
                                            //                                            if([str4 isEqualToString:_tempsessionid])
                                            //                                            {
                                            
                                            // NSLog(@"STIRNG....%@",str1);
                                            
                                            [_servicearr addObject:str1];
                                            [_addressarr addObject:str2];
                                            [_areaarr addObject:str3];
                                            [_service_idarr addObject:str4];
                                            // [_imgarray addObject:str5];
                                            [_city_idarr addObject:str6];
                                            [_capacityarr addObject:str7];
                                            [_foodarr addObject:str8];
                                            [_role_id_arr addObject:str9];
                                            [_established_arr addObject:str10];
                                            [_contact_arr addObject:str11];
                                            [_area_idarr addObject:str12];
                                            [_isActivearr addObject:str13];
                                            [_availablearr addObject:str14];
                                            
                                            [_allow_other_catererarr addObject:str14];
                                            
                                            Opening *o=[[Opening alloc]init];
                                            o.sevicename=str1;
                                            o.address=str2;
                                            o.area_name=str3;
                                            o.service_provider_id=str4;
                                            o.img=str5;
                                            o.city_id=str6;
                                            o.capacity=str7;
                                            o.food_type_id=str8;
                                            o.role_id=str9;
                                            o.established_year=str10;
                                            o.contact=str11;
                                            o.area_id=str12;
                                            o.isActive=str13;
                                            o.allowOtherCaterer=str14;
                                            //o.available=str15;
                                            
                                            [_servicenamearr addObject:o];
                                            [_tableview reloadData];
                                            
                                            
                                            //                                                                if([_imgarray isEqual:[NSNull null]])
                                            //                                                                                    {
                                            //                                                                                        _imgarray=@"--";
                                            //                                                                                    }
                                            //                                                                                    else
                                            //                                                                                    {
                                            //                                                                                       // _imgarray=_img;
                                            //                                                                                    }
                                            
                                            //NSString *tempimgstr=str5;
                                            // [_imgarray sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
                                            //                                                       placeholderImage:[UIImage imageNamed:@"default.png"]];
                                        }
                                        
                                        [_tableview reloadData];
                                        //
                                        [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                                        [_tableview reloadData];
                                                                                    });
                                    }
                                    //}
//                                    NSString* filter = @"%K CONTAINS[cd] %@";
//                                    NSPredicate* predicate = [NSPredicate predicateWithFormat:filter, @"area_name", @"a"];
//                                    
//                                    self.filteredarray = [self.servicenamearr filteredArrayUsingPredicate:predicate];
//                                    for(Opening *a in self.filteredarray)
//                                    {
//                                        NSLog(@"first name is %@",a.area_name);
//                                        
//                                        
//                                    }
                                   
                                    [_tableview reloadData];
                                }];
    [task resume];
    
    
}
*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _servicenamearr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OpeningTableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.service_name.text=[_servicearr objectAtIndex:indexPath.row];
    cell.address.text=[_addressarr objectAtIndex:indexPath.row];
    //cell.city.text=[_cityarr objectAtIndex:indexPath.row];
    cell.location.text=[_addressarr objectAtIndex:indexPath.row];
    cell.guest.text=[_capacityarr objectAtIndex:indexPath.row];
    cell.food_type_id.text=[_foodarr objectAtIndex:indexPath.row];
    cell.service_provide_id.text=[_service_idarr objectAtIndex:indexPath.row];
    
    cell.available_status.text=[_availablearr objectAtIndex:indexPath.row];
    
    NSLog(@"Service Name===%@",cell.service_name.text);
    
    NSLog(@"Status Available===%@",cell.available_status.text);

        [_indicator stopAnimating];
//    NSString *kImgLink=[_imgarray objectAtIndex:indexPath.row];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // retrive image on global queue
//        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:     [NSURL URLWithString:kImgLink]]];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            
//            // assign cell image on main thread
//            cell.img.image = img;
//        });
//    });
    
//
   NSString *available=[_availablearr objectAtIndex:indexPath.row];

    NSLog(@"Available=====%@",available);
    if ([available isEqualToString:@"1"]){
        NSLog(@"Available.......");
        cell.available_status.text=@"Available";
        cell.available_status.backgroundColor = [UIColor greenColor];
        cell.available_status.layer.cornerRadius = 5;
        cell.available_status.layer.masksToBounds = YES;
    }
    else{
        
        NSLog(@"Booked .....");
        cell.available_status.text=@"Booked";
        cell.available_status.backgroundColor = [UIColor redColor];
        cell.available_status.layer.cornerRadius = 5;
        cell.available_status.layer.masksToBounds = YES;
    }
    return  cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if([[segue identifier]isEqualToString:@"showVenueInfo"])
    {
        VenueInfoViewController *t=[segue destinationViewController];
        t.service_provider_id_str=_service_id_str;
        t.indxpath=_indxp;

    }
    if([[segue identifier]isEqualToString:@"showAllVenueInfo"])
    {
        VenueViewController *t=[segue destinationViewController];
//        t.service_provider_id_str=_service_id_str;
//        t.indxpath=_indxp;
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    OpeningTableViewCell *cell=[_tableview cellForRowAtIndexPath:indexPath];
    
    _service_name_str=cell.service_name.text;
    _loc_str=cell.location.text;
    _city_str=cell.city.text;
    _address_str=cell.address.text;
    _capacity_str=cell.guest.text;
    _img=cell.img.image;
    _service_id_str=cell.service_provide_id.text;
    
     NSLog(@"******Service provider id****=  %@",cell.service_provide_id.text);
    NSLog(@" service name  %@    lbl  %@",_service_name_str,cell.service_name.text);
 
    [self performSegueWithIdentifier:@"showVenueInfo"
                              sender:[self.tableview cellForRowAtIndexPath:indexPath]];
    
}
- (IBAction)filterBtnClicked:(id)sender {
    
       [self dataParsing];
       [_tableview reloadData];

    
    
}

@end
