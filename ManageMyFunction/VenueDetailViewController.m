//
//  VenueDetailViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 11/2/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "VenueDetailViewController.h"
#import "VenueDetail.h"
#import "VenueDetailTableViewCell.h"
#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"
#import "VenueInfoViewController.h"


@interface VenueDetailViewController ()
@property (nonatomic, readonly) CGFloat offset;
@end

@implementation VenueDetailViewController{
    
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

    keyarr1= [[NSMutableArray alloc]init];
    keyarr=[[NSMutableArray alloc]init];
    varr = [[NSArray alloc] init];
    
  
    [self.tableview setSeparatorColor:[UIColor clearColor]];
    
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
                                                    
                                                    [[NSUserDefaults standardUserDefaults]setValue:areaid forKey:@"areaid"];
                                                    NSLog(@"***area ID = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"areaid"]);
                                                    
                                                    
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
}
-(IBAction)typeselectClicked:(id)sender {
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
        NSURL *url=[NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_hall_type.php"];
    
        NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
        [urlRequest setHTTPMethod:@"POST"];
    
    
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
                                        
                                        keyarr= (NSMutableArray*)[outerdic objectForKey:@"venuetype"];
                                        NSUInteger count=sizeof(keyarr);
                                        NSUInteger i=0;
                                        
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            NSString *str1=[temp objectForKey:@"venue_type_name"];
                                            NSString *vid=[temp objectForKey:@"venue_type_id"];
                                            
                                            if(count>i)
                                            {
                                                [keyarr1 addObject:str1];
                                                
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                    _venue_type.text=_venue_namestr;
                                                    _venue_type_id.text=_venuetypeid_str;
                                                    
                                                    
                                                    NSLog(@"Venue name%@  Venue id==%@",str1,vid);
                                                    
                                                    [_indicator stopAnimating];
                                                    
                                                    [[NSUserDefaults standardUserDefaults]setValue:vid forKey:@"venueid"];
                                                    NSLog(@"***Venue ID = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"venueid"]);
                                                    
                                                }];
                                                
                                                NSString *test=[keyarr1 objectAtIndex:i];
                                                
                                                //NSLog(@"venue====%@",test);
                                            }
                                            i++;
                                            
                                        }
                                        NSArray * arrImage = [[NSArray alloc] init];
                                        
                                        if(dropDown == nil) {
                                            CGFloat f = 120;
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

    
//    NSURLSessionConfiguration *defaultConfiguration=[NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *defaultSession=[NSURLSession sessionWithConfiguration:defaultConfiguration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
//    
//    NSURL *url=[NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_hall_type.php"];
//    
//    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
//    [urlRequest setHTTPMethod:@"POST"];
//    
//    NSURLSessionDataTask *task=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
//                                {
//                                    
//                                    if(data==nil)
//                                    {
//                                        NSLog(@"Data is nil");
//                                    }
//            else
//            {
//            NSLog(@"%@",response);
//            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//            
//            keyarr1= [[NSMutableArray alloc]init];
//            
//            keyarr= (NSMutableArray*)[outerdic objectForKey:@"venuetype"];
//            
//            NSUInteger count=sizeof(keyarr);
//            NSUInteger i=0;
//            //
//            for(NSDictionary *temp in keyarr)
//            {
//                NSString *str1=[temp objectForKey:@"venue_type_name"];
//                NSString *venueid=[temp objectForKey:@"venue_type_id"];
//                
//                if(count>i)
//                {
//                    [keyarr1 addObject:str1];
//                    
//                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//                        _venue_type.text=_venue_namestr;
//                        _venue_type_id.text=_venuetypeid_str;
//                        
//                        
//                        NSLog(@"Area name%@  Area id==%@",str1,venueid);
//                        
//                        //[_indicator stopAnimating];
//                        
//                    }];
//                    
//                    NSString *test=[keyarr1 objectAtIndex:i];
//                    
//                    NSLog(@"Area====%@",test);
//                }
//                i++;
//                
//            }
//    }
/*varr = [NSArray arrayWithObjects:@"Hall", @"Hotel",@"Conference Hall",nil];
    
    
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
    */
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
        
        NSLog(@"Capacity is**%@",guestBtnSelect.titleLabel.text);
    }
    
    if (areaBtnSelect.titleLabel.text!=NULL) {
        _area_namestr=areaBtnSelect.titleLabel.text;
        NSLog(@"Area is**%@",areaBtnSelect.titleLabel.text);
        
        NSInteger anIndex=[keyarr1 indexOfObject:(NSString*)_area_namestr];
        
        _areaid=_area_idarr[anIndex];
        NSDictionary *area_data=keyarr[anIndex];
        NSLog(@"Index path for area id==%@",area_data);
        
        _areaid=[area_data objectForKey:@"id"];
        
        NSLog(@"Area ID is==**%@",_areaid);
        
        [[NSUserDefaults standardUserDefaults]setValue:_areaid forKey:@"areaid"];
        NSLog(@"***Venue area ID = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"areaid"]);
        
        NSLog(@"***INDEX***%ld",(long)anIndex);
        if (NSNotFound==anIndex) {
            NSLog(@"not found");
        }
        if (typeBtnSelect.titleLabel.text!=NULL) {
            
            _venue_namestr=typeBtnSelect.titleLabel.text;
            NSLog(@"Venue Type name**%@",typeBtnSelect.titleLabel.text);
            
            NSInteger anIndex=[varr indexOfObject:(NSString*)_venue_namestr];
            
            _venuetypeid_str=[NSString stringWithFormat:@"%ld",(long)++anIndex];
            NSLog(@"Index path for Venue type ID==%@",_venuetypeid_str);
            
            ///[[NSUserDefaults standardUserDefaults]setValue:_venuetypeid_str forKey:@"venuetypeid"];
//            NSLog(@"***Venue type ID = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"venuetypeid"]);
            
            
            if (NSNotFound==anIndex) {
                NSLog(@"not found");
                
            }
        }
        
        NSLog(@"****Guest==%@", guestBtnSelect.titleLabel.text);
        NSLog(@"****Area===%@", areaBtnSelect.titleLabel.text);
        NSLog(@"****Venue Type ====%@", typeBtnSelect.titleLabel.text);
        
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

-(void)dataParsing{
    queue=dispatch_queue_create("images", DISPATCH_QUEUE_CONCURRENT);
    queue=dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    
    [_imgarray removeAllObjects];
    [_servicenamearr removeAllObjects];
    [_service_idarr removeAllObjects];
    [_addressarr removeAllObjects];
    [_areaarr removeAllObjects];
    [_cityarr removeAllObjects];
    [_capacityarr removeAllObjects];
    [_foodarr removeAllObjects];
    [_servicearr removeAllObjects];
    

    
     NSString *myst=[NSString stringWithFormat:@"city=%d&capacity1=%d&capacity2=%d&area=%d&venue_type=%d",1,0,5000,0,0];
    
    NSLog(@"sTRING VENUE===%@",myst);
    
     NSURL *url= [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_venue_data.php"];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
  
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
    
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
                                        
                                        NSArray *keyarr=[outerdic objectForKey:@"venues"];
                                        
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            NSString *str1=[[temp objectForKey:@"service_name"]description];
                                            NSString *str2=[[temp objectForKey:@"address"]description];
                                            NSString *str3=[temp objectForKey:@"area_name"];
                                            NSString *str4=[temp objectForKey:@"cover_images"];
                                            
                                            NSString *str5=[temp objectForKey:@"capacity"];
                                            
                                            NSString *str6=[[temp objectForKey:@"food_type_id"]description];
                                            NSString *str7=[temp objectForKey:@"service_provider_id"];
                                            
                                            
                                            
                                          
                                           // [_imgarray addObject:str4];
                                            
                                            NSLog(@"service name  %@",str1);
                                            
                                            VenueDetail *k1=[[VenueDetail alloc]init];
                                            k1.sevicename=str1;
                                            k1.address=str2;
                                            k1.location=str3;
                                            k1.img=str4;
                                            k1.capacity=str5;
                                            k1.food_type_id=str6;
                                            k1.service_provider_id=str7;
                                            
                                            
                                            [_servicenamearr addObject:k1];
                                            
                                            [[NSUserDefaults standardUserDefaults]setValue:str7 forKey:@"serviceproviderid"];
                                            NSLog(@"***Venue Service_Provider ID = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"serviceproviderid"]);
                                            
                                            
                                            [[NSUserDefaults standardUserDefaults]setValue:str1 forKey:@"servicename"];
                                            NSLog(@"***Venue service name = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"servicename"]);
                                            
                                            [[NSUserDefaults standardUserDefaults]setValue:str6 forKey:@"foodid"];
                                            NSLog(@"***food id = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"foodid"]);
                                            
                                            [_tableview reloadData];
                                        }
                                        [_tableview reloadData];
                                    }
                                    [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                }];
    [task resume];
    
    [_tableview reloadData];
    

}
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
    
    VenueDetailTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    VenueDetail *ktemp=[_servicenamearr objectAtIndex:indexPath.row];
    
    cell.service_name.text=ktemp.sevicename;
    cell.location.text=ktemp.location;
    cell.address.text=ktemp.address;
    cell.guest.text=ktemp.capacity;
    cell.food_type_id.text=ktemp.food_type_id;
    cell.service_provide_id.text=ktemp.service_provider_id;
 
//      NSString *tempimgstr=ktemp.img;
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
//    placeholderImage:[UIImage imageNamed:@"default.png"]];
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
  //  });
    
    NSLog(@"FOOD ID==%@",cell.food_type_id.text);
    
    if ([cell.food_type_id.text isEqual:@"1"]) {
        cell.vegImg.hidden=NO;
        cell.nonVegImg.hidden=YES;
    }
    else if ([cell.food_type_id.text isEqual:@"2"]){
        cell.vegImg.hidden=YES;
        cell.nonVegImg.hidden=NO;
    }

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if([[segue identifier]isEqualToString:@"showVenue"])
    {
        VenueInfoViewController *t=[segue destinationViewController];
        t.service_provider_id_str=_service_id_str;
        t.indxpath=_indxp;
        t.service_name_str=_service_name_str;
        t.capacity_str=_capacity_str;
        t.address_str=_address_str;
        t.foodidStr=_foodidstr;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    VenueDetailTableViewCell *cell=[_tableview cellForRowAtIndexPath:indexPath];
    
    _service_name_str=cell.service_name.text;
    _loc_str=cell.location.text;
    _city_str=cell.city.text;
    _address_str=cell.address.text;
    _capacity_str=cell.guest.text;
    _img=cell.img.image;
    _service_id_str=cell.service_provide_id.text;
    _foodidstr=cell.food_type_id.text;
    
    NSLog(@"******Service provider id****=  %@ Food id==%@",_service_id_str,_foodidstr);
    NSLog(@"****service name  %@",_service_name_str);
    
    _indxp=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    NSLog(@"%ld",(long)indexPath.row);
    
    [self performSegueWithIdentifier:@"showVenue"
                              sender:[self.tableview cellForRowAtIndexPath:indexPath]];
    
}

-(void)getFilterVenue
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
//    NSString *venueid=[[NSUserDefaults standardUserDefaults] stringForKey:@"venueid"];
//     
//     NSLog(@"venue  ID = %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"venueid"]);
     
//     NSString *areaid=[[NSUserDefaults standardUserDefaults] stringForKey:@"areaid"];
//     
//     NSLog(@"area  ID = %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"areaid"]);
     
 NSString *myst=[NSString stringWithFormat:@"city_id=%d&area_id=%@&venue_type_id=%@&capacity1=%@&capacity2=%@",1,_areaid,_venuetypeid_str,_capacity_str1,_capacity_str2];
 
 NSLog(@"POST CONTAINT filter....%@",myst);
 
 //    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[cd] %@",self.arealbl.text];
 //    self.filteredarray = [self.area_namearr filteredArrayUsingPredicate:bPredicate];
 //    NSLog(@"HERE %@",self.filteredarray);

 NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
 
 NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
 
 NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_filter_venue_new.php"];
 
 
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
 
 VenueDetail *o=[[VenueDetail alloc]init];
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

- (IBAction)filterBtnClicked:(id)sender {
    
    [self getFilterVenue];
    [_tableview reloadData];
    
    
    
}
@end
