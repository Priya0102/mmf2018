//
//  MenuViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 11/15/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "MenuViewController.h"
#import "Menu.h"
#import "MenuTableViewCell.h"
@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _menuarr=[[NSMutableArray alloc]init];
    _menuidarr=[[NSMutableArray alloc]init];
    _menunamearr=[[NSMutableArray alloc]init];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [self getCatererMenu];
    
}
-(void)getCatererMenu{
    
    
    [_menuidarr removeAllObjects];
    [_menunamearr removeAllObjects];
    [_menuarr removeAllObjects];
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSString *urlstr=@"http://localhost/phpmyadmin/MMF/get_menu_name.php";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [req setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"dATA IS NIL");
        }
        else{
            NSLog(@"response menu ==%@",response);
            
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr=[outerdic objectForKey:@"menuname"];
            NSLog(@"caterer category Array=%@",arr);
            
            for(NSDictionary *temp in arr){
                Menu *f=[[Menu alloc]init];
                f.menuidStr=temp[@"menu_id"];
                f.menuNameStr=temp[@"menu_name"];
              
                
                if(f.menuidStr==(NSString *) [NSNull null])
                {
                    f.menuidStr=@"-";
                }
                [_menuarr addObject:f];
                
                [_tableview reloadData];
                
                NSLog(@"menu Name===%@",f.menuNameStr);
                
               
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
   
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _menuarr.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MenuTableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    Menu *a1=self.menuarr[indexPath.row];
    
    if (a1.menuidStr==(NSString *) [NSNull null]) {
        a1.menuidStr=@"-";
    }
    cell.menuid.text=a1.menuidStr;
    cell.menuName.text=a1.menuNameStr;
    
    return cell;
}




@end
