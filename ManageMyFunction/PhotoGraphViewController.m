//
//  PhotoGraphViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 11/2/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "PhotoGraphViewController.h"
#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"
#import "Photographer.h"
#import "PhotographTableViewCell.h"
#import "PhotoDetailViewController.h"
@interface PhotoGraphViewController ()

@end

@implementation PhotoGraphViewController{
    
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
    // Do any additional setup after loading the view.
//    _event_lbl.text=_eventStr;
//    _capacity1.text=_capacity_str1;
//    _capacity_str1=@"0";
//    _capacity_str2=@"5000";
//    _venuetypeid_str=@"0";
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
}
- (void)niDropDownDelegateMethod: (NIDropDown *) sender {
    
    [self rel];
    
//    if (guestBtnSelect.titleLabel.text!=NULL) {
//        
//        _capacity_str =guestBtnSelect.titleLabel.text;
//        _capacitiesarr = [_capacity_str componentsSeparatedByString:@"-"];
//        _capacity_str1=_capacitiesarr[0];
//        _capacity_str2=_capacitiesarr[1];
//        
//        NSLog(@"Capacity str1==%@",_capacity_str1);
//        NSLog(@"Capacity str2==%@",_capacity_str2);
//        
//        NSLog(@"Capacity is not null**%@",guestBtnSelect.titleLabel.text);
//    }
    
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
//        if (foodtypeBtnSelect.titleLabel.text!=NULL) {
//            
//            _venue_namestr=foodtypeBtnSelect.titleLabel.text;
//            NSLog(@"Venue is not null**%@",foodtypeBtnSelect.titleLabel.text);
//            
//            NSInteger anIndex=[varr indexOfObject:(NSString*)_venue_namestr];
//            
//            _venuetypeid_str=[NSString stringWithFormat:@"%ld",(long)++anIndex];
//            NSLog(@"Index path for Venue type ID==%@",_venuetypeid_str);
//            if (NSNotFound==anIndex) {
//                NSLog(@"not found");
//                
//            }
//        }
        
       // NSLog(@"Guest==%@", guestBtnSelect.titleLabel.text);
        NSLog(@"Area===%@", areaBtnSelect.titleLabel.text);
      //  NSLog(@"Venue Type ====%@", foodtypeBtnSelect.titleLabel.text);
        
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
    
    
    
    NSString *myst=[NSString stringWithFormat:@"city=%@&area=%d",_city_str,0];
    
    NSURL * url= [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_photograph_data.php"];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    // _newurlpass=_urlstr;
    // NSLog(@"%@",_newurlpass);
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
                                        
                                        NSArray *keyarr=[outerdic objectForKey:@"photographer"];
                                        
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            NSString *str1=[[temp objectForKey:@"service_name"]description];
                                            NSString *str2=[[temp objectForKey:@"address"]description];
                                            NSString *str3=[[temp objectForKey:@"area_name"]description];
                                            NSString *str4=[temp objectForKey:@"cover_images"];
                                            
                                            NSString *str5=[[temp objectForKey:@"contact"]description];
                                            
                                            NSString *str6=[temp objectForKey:@"service_provider_id"];
                                            
                                            
                                            
                                            
                                            // [_imgarray addObject:str4];
                                            
                                            NSLog(@"service name  %@ location area===%@",str1,str3);
                                            
                                            Photographer *k1=[[Photographer alloc]init];
                                            k1.sevicename=str1;
                                            k1.address=str2;
                                            k1.area_name=str3;
                                            k1.img=str4;
                                            k1.contact=str5;
                                        
                                            k1.service_provider_id=str6;
                                            
                                            
                                            [_servicenamearr addObject:k1];
                                            
                                            [[NSUserDefaults standardUserDefaults]setValue:str6 forKey:@"serviceproviderid"];
                                            NSLog(@"***Venue Service_Provider ID = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"serviceproviderid"]);
                                            
                                            
                                            [[NSUserDefaults standardUserDefaults]setValue:str1 forKey:@"servicename"];
                                            NSLog(@"***Venue service name = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"servicename"]);
                                            
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
    
    PhotographTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Photographer *ktemp=[_servicenamearr objectAtIndex:indexPath.row];
    
    cell.service_name.text=ktemp.sevicename;
    cell.location.text=ktemp.area_name;
    cell.address.text=ktemp.address;
    cell.contact.text=ktemp.contact;
    cell.service_provide_id.text=ktemp.service_provider_id;
    
    return cell;
}

    
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if([[segue identifier]isEqualToString:@"showPhoto"])
    {
        PhotoDetailViewController *t=[segue destinationViewController];
        t.service_provider_id_str=_service_id_str;
        t.indxpath=_indxp;
        t.service_name_str=_service_name_str;
        t.address_str=_address_str;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    PhotographTableViewCell *cell=[_tableview cellForRowAtIndexPath:indexPath];
    
    _service_name_str=cell.service_name.text;
    _loc_str=cell.location.text;
    _address_str=cell.address.text;
    _contact_str=cell.contact.text;
    _img=cell.img.image;
    _service_id_str=cell.service_provide_id.text;
    
    NSLog(@"******Service provider id****=  %@",_service_id_str);
    NSLog(@"****service name  %@",_service_name_str);
    
    _indxp=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    NSLog(@"%ld",(long)indexPath.row);
    
    [self performSegueWithIdentifier:@"showPhoto"
                              sender:[self.tableview cellForRowAtIndexPath:indexPath]];
    
}
- (IBAction)filterBtnClicked:(id)sender {
    
    //[self getFilterVenue];
    [_tableview reloadData];
    
    
    
}
@end
