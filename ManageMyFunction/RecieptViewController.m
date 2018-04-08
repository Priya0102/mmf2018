//
//  RecieptViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 8/31/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "RecieptViewController.h"
#import "RecieptTableViewCell.h"
#import "ReceiptFacility.h"
@interface RecieptViewController ()

@end

@implementation RecieptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _serviceName.text=_serviceNameStr;
    _address.text=_addressStr;
    _contact.text=_contactStr;
    _name.text=_nameStr;
    _contactCustomer.text=_contactCustomerStr;
    _eventName.text=_eventNameStr;
    _eventAddress.text=_eventAddressStr;
    _startTime.text=_startTimeStr;
    _endTime.text=_endTimeStr;
    _startDate.text=_startDateStr;
    _endDate.text=_endDateStr;
    _totalAmount.text=_totalAmountStr;
    
    [self getReceiptDetails];
    [self getOtherFacility];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _otherfaciltyarr=[[NSMutableArray alloc]init];
}
-(void)getReceiptDetails{
    
        
        NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"];
        NSLog(@"*bOOK ID=%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"]);
        
        NSString *myst=[NSString stringWithFormat:@"book_id=%@",savedvalue];
        NSLog(@"**bOOK ID**=%@",myst);
        
        NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        NSString *urlstr=@"http://localhost/phpmyadmin/MMF/get_receipt_number.php";
        NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data==nil) {
                NSLog(@"dATA IS NIL");
            }
            else{
                NSLog(@"response receipt_details ==%@",response);
                
                NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSArray *arr=[outerdic objectForKey:@"receipt_details"];
                
                for(NSDictionary *temp in arr){
                    NSString *str1=[temp objectForKey:@"book_id"];
                    NSString *str2=[temp objectForKey:@"id"];
                    NSString *str3=[temp objectForKey:@"receipt_no"];
                            NSLog(@"recipt book id==%@",str1);
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            _bookidStr=str1;
                            _idStr=str2;
                            _recieptNumberStr=str3;
                        
                            
                            _bookid.text=_bookidStr;
                            _reciept_id.text=_idStr;
                            _reciept_number.text=_recieptNumberStr;
                            
                        }];
                    }
                }
            }
        }];
        
        [task resume];
 
}
-(void)getOtherFacility{
    
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"];
    NSLog(@"Reciept bOOK ID=%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"]);
    
    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"user_id"];
    NSLog(@"Reciept User ID=%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"user_id"]);
    
    NSString *myst=[NSString stringWithFormat:@"book_id=%@&user_id=%@",savedvalue,savedvalue2];
    NSLog(@"bOOK ID & User ID**=%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSString *urlstr=@"http://localhost/phpmyadmin/MMF/get_other_facility.php";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"dATA IS NIL");
        }
        else{
            NSLog(@"response other facility==%@",response);
            
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr=[outerdic objectForKey:@"other_facility"];
            
            NSLog(@"Reciept oTHER fACILITY Array=%@",arr);
            
            for(NSDictionary *temp in arr){
                   ReceiptFacility *f=[[ReceiptFacility alloc]init];
              f.otherfacilityIdStr=temp[@"other_facility_id"];
                f.facilityNameStr=temp[@"facility_name"];
                f.bookIdStr=temp[@"book_id"];
                f.quantityStr=temp[@"quantity"];
                f.priceStr=temp[@"price"];
                
                [_otherfaciltyarr addObject:f];
                [_tableview reloadData];
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
   
        return _otherfaciltyarr.count;
    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        RecieptTableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        ReceiptFacility *f=self.otherfaciltyarr[indexPath.row];
        
        cell.otherFacilityId.text=f.otherfacilityIdStr;
        cell.facilityName.text=f.facilityNameStr;
        cell.bookId.text=f.bookIdStr;
        cell.quantity.text=f.quantityStr;
        cell.price.text=f.priceStr;
   
    return cell;
}
-(void)viewWillAppear:(BOOL)animated
{
   
    [self getOtherFacility];
    [super viewWillAppear:YES];
    [self.tableview reloadData];
  
    
}


@end
