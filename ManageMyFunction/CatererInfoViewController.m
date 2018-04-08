//
//  CatererInfoViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 11/3/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "CatererInfoViewController.h"
#import "CatererInfoTableViewCell.h"
#import "CatererInfo.h"
#import "CuisineViewController.h"
@interface CatererInfoViewController ()

@end

@implementation CatererInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _service_name.text=_service_name_str;
    _address.text=_address_str;
    _capacity.text=_capacity_str;
   // _deposit.text=_deposit_str;
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
    
    
//    _viewpdf.layer.borderWidth = 1;
//    _viewpdf.layer.borderColor = [[UIColor blueColor] CGColor];
//    _viewpdf.layer.cornerRadius = 5;
//    _viewpdf.clipsToBounds = YES;
    
    _changeTimeBtn.layer.borderWidth = 1;
    _changeTimeBtn.layer.borderColor = [[UIColor cyanColor] CGColor];
    _changeTimeBtn.layer.cornerRadius = 5;
    _changeTimeBtn.clipsToBounds = YES;
    
    _proceedBtn.layer.borderWidth = 1;
    // _proceedBtn.layer.borderColor = [[UIColor blackColor] CGColor];
    _proceedBtn.layer.cornerRadius = 5;
    _proceedBtn.clipsToBounds = YES;
    
    
    
     self.catererarr=[[NSMutableArray alloc]init];
    
    [self catererinfo];
    
}
-(void)catererinfo{
    
    CatererInfo *a1=[[CatererInfo alloc]init];
    
    NSString *myst=[NSString stringWithFormat:@"service_provider_id=%@",_service_provider_id_str];
    
    NSLog(@"Caterer SERVICE PROVIDER ID.......%@",myst);
   
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_caterer_info.php"];
    
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
                                          
                                          NSArray *profile=[responseDict objectForKey:@"catererinfo"];
                                          
                                          NSLog(@"Caterer info array==%@",profile);
                                          for(NSDictionary * dict in profile)
                                          {
                                              
                                              a1.serviceproviderid=dict[@"service_provider_id"];
                                              a1.servicename=[dict objectForKey:@"service_name"];
                                              a1.establishedyr=[dict objectForKey:@"established_year"];
                                              a1.address=[dict objectForKey:@"address"];
                                              a1.contact=[dict objectForKey:@"contact"];
                                              a1.coverimges=[dict objectForKey:@"cover_images"];
                                              a1.termsconditions=[dict objectForKey:@"terms_conditions"];
                                              a1.foodtypeid=[dict objectForKey:@"food_type_id"];
                                              a1.advancepayment=dict[@"advance_payment"];
                                              a1.morningStartTime=dict[@"morning_start_time"];
                                              a1.morningEndTime=dict[@"morning_end_time"];
                                              a1.eveningStartTime=dict[@"evening_start_time"];
                                              a1.eveningEndTime=dict[@"evening_end_time"];
                                              a1.capacity=dict[@"capacity"];
                                              a1.provideHomeservice=dict[@"provide_homeservice"];
                                              a1.minpersons=dict[@"min_persons"];
                                              a1.priceforminperson=dict[@"price_for_min_persons"];
                                              a1.foodtype=dict[@"food_type"];

                                              
                                              [self.catererarr addObject:a1];
                                              
                                              
                                          }
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              
                                              if(a1.servicename==(NSString *) [NSNull null])
                                              {
                                                  a1.servicename=@"not given";
                                              }
                                              if(a1.foodtype==(NSString *) [NSNull null])
                                              {
                                                  a1.foodtype=@"not given";
                                              }
                                              if(a1.contact==(NSString *) [NSNull null])
                                              {
                                                  a1.contact=@"";
                                              }
                                              if(a1.address==(NSString *) [NSNull null])
                                              {
                                                  a1.address=@"not given";
                                              }
                                              if(a1.coverimges==(NSString *) [NSNull null])
                                              {
                                                  a1.coverimges=@"not given";
                                              }
                                              if(a1.foodtypeid==(NSString *) [NSNull null])
                                              {
                                                  a1.foodtypeid=@"";
                                              }
                                              if(a1.minpersons==(NSString *) [NSNull null])
                                              {
                                                  a1.minpersons=@"";
                                              }
                                              if(a1.priceforminperson==(NSString *) [NSNull null])
                                              {
                                                  a1.priceforminperson=@"---";
                                              }
                                              if(a1.termsconditions==(NSString *) [NSNull null])
                                              {
                                                  a1.termsconditions=@"---";
                                              }
                                              
                                           
                                              
                                              self.service_provider_id.text=a1.serviceproviderid;
                                              NSLog(@"serviceproviderid==%@",self.service_provider_id.text);
                                              self.service_name.text=a1.servicename;
                                              self.established_year.text=a1.establishedyr;
                                              self.address.text=a1.address;
                                              //self.cover_images.image=a1.coverimges;
                                              self.terms_conditons.text=a1.termsconditions;
                                              self.foodtypeid.text=a1.foodtypeid;
                                              self.foodtype.text=a1.foodtype;
                                              self.contact.text=a1.contact;
                                              self.advancepayment.text=a1.advancepayment;
                                              self.morning_start_time.text=a1.morningStartTime;
                                              self.morning_end_time.text=a1.morningEndTime;
                                              self.evening_start_time.text=a1.eveningStartTime;
                                              self.evening_end_time.text=a1.eveningEndTime;
                                              self.capacity.text=a1.capacity;
                                              self.providehomeservie.text=a1.provideHomeservice;
                                              self.min_person.text=a1.minpersons;
                                              self.priceforminperson.text=a1.priceforminperson;
                                              
                                              
                                          });
                                      }];
    
    [dataTask resume];
    


}
-(void)setupScrollView:(UIScrollView *)scrMain{
    for (int i=1; i<=4; i++) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"caterer4.png"]];
        UIImage *image2=[UIImage imageNamed:[NSString stringWithFormat:@"caterer1.jpg"]];
        UIImage *image3=[UIImage imageNamed:[NSString stringWithFormat:@"caterer2.jpg"]];
        UIImage *image4=[UIImage imageNamed:[NSString stringWithFormat:@"caterer3.jpg"]];
         UIImage *image5=[UIImage imageNamed:[NSString stringWithFormat:@"caterer4.jpg"]];
        
        
        [_imgView setImage:image];
        
//        _imgView.animationImages=@[image,image2,image3,image4,image5];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if([[segue identifier]isEqualToString:@"showCuisine"])
    {
        CuisineViewController *t=[segue destinationViewController];
        t.serviceprovideridStr=_service_provider_id_str;
      
       
    }
    
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
////    
////    VenueDetailTableViewCell *cell=[_tableview cellForRowAtIndexPath:indexPath];
////    
////    
////    _service_provider_id_str=cell.service_provider_id.text;
////
////    
//    NSLog(@"******Service provider id****=  %@ Food id==%@",_service_provider_id_str);
//    
//    
//    _indxp=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
//    
//    NSLog(@"%ld",(long)indexPath.row);
//    
//    [self performSegueWithIdentifier:@"showCuisine"
//                              sender:[self.tableview cellForRowAtIndexPath:indexPath]];
//    
//}

@end
