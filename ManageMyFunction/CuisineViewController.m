//
//  CuisineViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 11/16/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "CuisineViewController.h"
#import "Cuisine.h"
#import "CuisineTableViewCell.m"
@interface CuisineViewController ()

@end

@implementation CuisineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _cusnamearr=[[NSMutableArray alloc]init];
    _cusidarr=[[NSMutableArray alloc]init];
    _cuisinearr=[[NSMutableArray alloc]init];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _service_pro_id.text=_serviceprovideridStr;
    
    [self getCuisineName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getCuisineName{
    
    [_cuisinearr removeAllObjects];
    [_cusidarr removeAllObjects];
    [_cusnamearr removeAllObjects];
    
    NSString *myst=[NSString stringWithFormat:@"service_provider_id=%@",self.service_pro_id.text];
    
    NSLog(@"##service provider id....%@",myst);
    
    
    
    
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
    
    
    NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_cusine_name.php"];
    
    
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
                                        
                                        NSArray *venuearr=[outerdic objectForKey:@"cuisinename"];
                                        
                                        for(NSDictionary *temp in venuearr)
                                        {
                                            NSString *str1=[temp objectForKey:@"cuisine_id"];
                                            NSString *str2=[temp objectForKey:@"cuisine_name"];
                                
                                            
                                            
                                            
                                            NSLog(@"cuisinename=%@ cuisine_name=   %@ ",str1,str2);
                                             Cuisine *o=[[Cuisine alloc]init];
                                            o.cuisineidStr=str1;
                                            o.cuisineNameStr=str2;
                                         
                                            [_cuisinearr addObject:o];
                                            
                                            
                                            [_tableview reloadData];
                                            
                                            
                                        }
                                       
                                        [[NSUserDefaults standardUserDefaults] synchronize];
                                        [_tableview reloadData];
                                        
                                        [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                    }
                                    
                                    [_tableview reloadData];
                                }];
    [task resume];
    
    
    [_tableview reloadData];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _cuisinearr.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CuisineTableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Cuisine *a1=self.cuisinearr[indexPath.row];
    
    if (a1.cuisineidStr==(NSString *) [NSNull null]) {
        a1.cuisineidStr=@"-";
    }
    cell.cusineid.text=a1.cuisineidStr;
    cell.cusineName.text=a1.cuisineNameStr;
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
