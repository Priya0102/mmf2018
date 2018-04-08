//
//  CategoryViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 11/16/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "CategoryViewController.h"
#import "Category.h"
#import "CategoryTableViewCell.h"
@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _categoryarr=[[NSMutableArray alloc]init];
    _catidarr=[[NSMutableArray alloc]init];
    _catnamearr=[[NSMutableArray alloc]init];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [self getCatererCategory];
}


-(void)getCatererCategory{
    
    
    [_catidarr removeAllObjects];
    [_catnamearr removeAllObjects];
    [_categoryarr removeAllObjects];
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSString *urlstr=@"http://localhost/phpmyadmin/MMF/get_category_name.php";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [req setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"dATA IS NIL");
        }
        else{
            NSLog(@"response CATEGORY CATERER==%@",response);
            
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr=[outerdic objectForKey:@"caterercategory"];
            NSLog(@"caterer category Array=%@",arr);
            
            for(NSDictionary *temp in arr){
                Category *f=[[Category alloc]init];
                f.catidStr=temp[@"category_id"];
                f.catnameStr=temp[@"category_name"];
               
                
                if(f.catidStr==(NSString *) [NSNull null])
                {
                    f.catidStr=@"-";
                }
                
                [_categoryarr addObject:f];
                [_tableview reloadData];
                
                NSLog(@"Category Name===%@",f.catnameStr);
                
                [[NSUserDefaults standardUserDefaults]setValue:f.catidStr forKey:@"category_id"];
                
                NSLog(@"category_id = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"category_id"]);
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
    
    return _categoryarr.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CategoryTableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Category *a1=self.categoryarr[indexPath.row];
    
    if (a1.catidStr==(NSString *) [NSNull null]) {
        a1.catidStr=@"-";
    }
    cell.catid.text=a1.catidStr;
    cell.catName.text=a1.catnameStr;
    
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
