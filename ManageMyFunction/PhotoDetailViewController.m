//
//  PhotoDetailViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 11/3/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "PhotoDetailViewController.h"

@interface PhotoDetailViewController ()

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _serviceName.text=_service_name_str;
    _address.text=_address_str;
    _service_provider_id.text=_service_provider_id_str;
    
    [self setupScrollView:self.scroll];
    
    
    UIPageControl *pgCtr=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 264, 480,50)];
    [pgCtr setTag:12];
    pgCtr.numberOfPages=5;
    pgCtr.autoresizingMask=UIViewAutoresizingNone;
    [self.contentview addSubview:pgCtr];
    
    [self getPhotographerDetails];
    
}
-(void)setupScrollView:(UIScrollView *)scrMain{
    for (int i=1; i<=4; i++) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"photo1.jpeg"]];
        UIImage *image2=[UIImage imageNamed:[NSString stringWithFormat:@"photo2.jpeg"]];
        UIImage *image3=[UIImage imageNamed:[NSString stringWithFormat:@"photo3.jpeg"]];
        UIImage *image4=[UIImage imageNamed:[NSString stringWithFormat:@"photo4.jpeg"]];
        
        
        
        [_imgView setImage:image];
        _imgView.animationImages=@[image,image2,image3,image4];
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
    
    if (nextPage!=4){
        [self.scroll scrollRectToVisible:CGRectMake(nextPage*self.scroll.frame.size.width,0,self.scroll.frame.size.width,self.scroll.frame.size.height)animated:YES];
        pgCtr.currentPage=nextPage;
    }else{
        [self.scroll scrollRectToVisible:CGRectMake(0,0,self.scroll.frame.size.width,self.scroll.frame.size.height)animated:YES];
        
        pgCtr.currentPage=0;
    }
}

-(void)getPhotographerDetails{
    
    NSString *myst=[NSString stringWithFormat:@"service_provider_id=%@",_service_provider_id_str];
    
    NSLog(@"SERVICE PROVIDER ID.......%@",myst);
    
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *urlstr=@"http://localhost/phpmyadmin/MMF/get_photographer_info.php";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"Data is nil");
        }
        else{
            NSLog(@"RESPONSE Photographer DETAILS===%@",response);
            
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            NSArray *arr=[outerdic objectForKey:@"photoinfo"];
            
            NSLog(@"Photo info arr==%@",arr);
            
            for (NSDictionary *temp in arr) {
                NSString *str1=[temp objectForKey:@"service_provider_id"];
                NSString *str2=[temp objectForKey:@"established_year"];
                NSString *str3=[temp objectForKey:@"morning_start_time"];
                NSString *str4=[temp objectForKey:@"morning_end_time"];
                NSString *str5=[temp objectForKey:@"evening_start_time"];
                NSString *str6=[temp objectForKey:@"evening_end_time"];
                NSString *str7=[temp objectForKey:@"terms_and_conditions"];
                NSString *str8=[temp objectForKey:@"package_name"];
                NSString *str9=[temp objectForKey:@"high_resolution_photos"];
                NSString *str10=[temp objectForKey:@"low_resolution_photos"];
                NSString *str11=[temp objectForKey:@"short_film"];
                NSString *str12=[temp objectForKey:@"long_film"];
                NSString *str13=[temp objectForKey:@"no_of_days"];
                NSString *str14=[temp objectForKey:@"no_of_hours_per_day"];
                NSString *str15=[temp objectForKey:@"medium_of_delivery"];
                NSString *str16=[temp objectForKey:@"no_of_photographers"];
                NSString *str17=[temp objectForKey:@"delivery_charges"];
                NSString *str18=[temp objectForKey:@"price"];
                NSString *str19=[temp objectForKey:@"comments"];
                NSString *str20=[temp objectForKey:@"service_name"];
                NSString *str21=[temp objectForKey:@"address"];
                NSString *str22=[temp objectForKey:@"short_film_size"];
                NSString *str23=[temp objectForKey:@"long_film_size"];
                NSString *str24=[temp objectForKey:@"cover_images"];
                NSString *str25=[temp objectForKey:@"event_type_id"];
                NSString *str26=[temp objectForKey:@"event_name"];
                NSString *str27=[temp objectForKey:@"pdf_name"];
                NSString *str28=[temp objectForKey:@"ext"];
                NSString *str29=[temp objectForKey:@"path"];
                
                                   NSLog(@"book_id=%@ \n service_provider_id=%@ \n user_event_id=%@ \n user_id=%@ \n event_type_id=%@ \n event_date_from=%@ \n event_date_to=%@ \n event_time_from=%@ \n event_time_to=%@ \n no_of_guests=%@ \n requested_date=%@ \n confirmed_date=%@ \n is_paid=%@\n is_confirmed=%@ \n  service_provider_user_id=%@ \n first_name=%@ \n last_name=%@ \n contact=%@ \n address=%@ \n Service Name==%@ \n Established yr==%@ \n event_name=%@",str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str14,str15,str16,str17,str18,str19,str20,str21,str22);
               
                {
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        _service_provider_id_str=str1;
                        _eastablished_yr_str=str2;
                        _morningstart_time=str3;
                        _morningend_time=str4;
                        _eveningstart_time=str5;
                        _eveningend_time=str6;
                        _terms_conditons_str=str7;
                        _packagenameStr=str8;
                        _highResoStr=str9;
                        _lowResoStr=str10;
                        _shortfilmSte=str11;
                        _longFilmStr=str12;
                        _no_of_daysSStr=str13;
                        _no_of_hrs_str=str14;
                        _mediundelStr=str15;
                        _no_of_photograph_str=str16;
                        _deliveryChardesStr=str17;
                        _priceStr=str18;
                        _commentStr=str19;
                        _service_name_str=str20;
                        _address_str=str21;
                        _shortfilmsize_str=str22;
                        _lonffilmsize_str=str23;
                        _coverimgStr=str24;
                        _eventtypeidStr=str25;
                        _eventNameStr=str26;
                        _pdfnamestr=str27;
                        _extStr=str28;
                        _pathStr=str29;
                        
                        
                        
                        
                        _service_provider_id.text=_service_provider_id_str;
                        _eastablished_year.text=_eastablished_yr_str;
                        _morning_start_time.text=_morningstart_time;
                        _morning_end_time.text=_morningend_time;
                        _evening_start_time.text=_eveningstart_time;
                        _evening_end_time.text=_eveningend_time;
                        _terms_conditions.text=_terms_conditons_str;
                        _package_name.text=_packagenameStr;
                        _high_resolution_photos.text=_highResoStr;
                        _low_resolution_photos.text=_lowResoStr;
                        _short_film.text=_shortfilmSte;
                        _long_film.text=_longFilmStr;
                        _no_of_days.text=_no_of_daysSStr;
                        _no_of_hours_per_day.text=_no_of_hrs_str;
                        _medium_of_delivery.text=_mediundelStr;
                        _no_of_photographers.text=_no_of_photograph_str;
                        _delivery_charges.text=_deliveryChardesStr;
                        _price.text=_priceStr;
                        _comments.text=_commentStr;
                        _serviceName.text=_service_name_str;
                        _address.text=_address_str;
                        _short_film_size.text=_shortfilmsize_str;
                        _long_film_size.text=_lonffilmsize_str;
                        //_coverImages.image=_coverimgStr;
                       // _event_type_id.text=_eventtypeidStr;
                        //_event_name.text=_eventNameStr;
                        _pdf_name.text=_pdfnamestr;
                        _ext.text=_extStr;
                        _path.text=_pathStr;
                        
//                
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            
//                            if(str24==(NSString *) [NSNull null])
//                            {
//                                _coverimgStr=@"-";
//                            }
//                            if(_eventtypeidStr==(NSString *) [NSNull null])
//                            {
//                                _eventtypeidStr=@"-";
//                            }
//                            if(_event_name.text==(NSString *) [NSNull null])
//                            {
//                                _eventNameStr=@"-";
//                            }
//                        });
                        
                   
                    }];
                }
            }
        
        }
    }];
    [task resume];
    

    
    
    
}

@end
