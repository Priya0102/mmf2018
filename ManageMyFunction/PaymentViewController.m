//
//  PaymentViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 8/31/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "PaymentViewController.h"
#import "Payment.h"
#import "PaymentTableViewCell.h"
#import "WalletViewController.h"
#import "OnlineTransViewController.h"
#import "CashViewController.h"
#import "CheckViewController.h"



@interface PaymentViewController ()

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    
    self.tableview.separatorColor=[UIColor clearColor];
    
    _paymentmodearr=[[NSMutableArray alloc]init];
    
    NSURLSessionConfiguration *defaultConfiguration=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession=[NSURLSession sessionWithConfiguration:defaultConfiguration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url=[NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/payment_mode.php"];
    
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask *datatask=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error==nil) {
            NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSError *er=nil;
            NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
            
            if (er) {
                
            }
            NSArray *payment=[responseDict objectForKey:@"paymentmode"];
            for (NSDictionary *dict in payment) {
                Payment *a1=[[Payment alloc]init];
                
                a1.paymentModeTypeStr=[dict objectForKey:@"payment_mode_type"];
                a1.paymentModeIdStr=[dict objectForKey:@"payment_mode_id"];
               
                
                [self.paymentmodearr addObject:a1];
            }
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableview reloadData];
        });
    }];
    [datatask resume];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tableview reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.paymentmodearr.count;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PaymentTableViewCell *cell=[self.tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Payment *a1=self.paymentmodearr[indexPath.row];
    
//    if (a1.paymentModeIdStr==(NSString *) [NSNull null]) {
//        a1.paymentModeIdStr=@"-";
//    }

    
    cell.paymentModeId.text=a1.paymentModeIdStr;;
    cell.paymentModeType.text=a1.paymentModeTypeStr;
   
    
    return cell;
    
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier]isEqualToString:@"showCheque"]) {
        CheckViewController *ch=[segue destinationViewController];
        ch.paymentIdStr=_paymentmodeIdStr;
        ch.paymentTypeStr=_paymentModetypeStr;
        
    }
    if ([[segue identifier]isEqualToString:@"showCash"]) {
        CashViewController *ca=[segue destinationViewController];
        ca.paymentIdStr=_paymentmodeIdStr;
        ca.paymentTypeStr=_paymentModetypeStr;
        
    }
    if ([[segue identifier]isEqualToString:@"showWallet"]) {
        WalletViewController *w=[segue destinationViewController];
        
        w.paymentIdStr=_paymentmodeIdStr;
        w.paymentTypeStr=_paymentModetypeStr;
    }
    if ([[segue identifier]isEqualToString:@"showOnline"]) {
        OnlineTransViewController *o=[segue destinationViewController];
        o.paymentIdStr=_paymentmodeIdStr;
        o.paymentTypeStr=_paymentModetypeStr;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
    
    PaymentTableViewCell *cell=[_tableview cellForRowAtIndexPath:indexPath];
    
    _paymentmodeIdStr=cell.paymentModeId.text;
    _paymentModetypeStr=cell.paymentModeType.text;
   
    
    
    NSLog(@"paymentModeType  %@    lbl  %@",_paymentmodeIdStr,cell.paymentModeType.text);
    
   // Payment *sess=[_paymentmodearr objectAtIndex:indexPath.row];
    
    Payment *sess=self.paymentmodearr[indexPath.row];
    NSString *tempstr=sess.paymentModeIdStr;
    
    NSLog(@"%@******",tempstr);
    
    
    if([tempstr isEqualToString:@"1"])
    {
        [self performSegueWithIdentifier:@"showOnline" sender:nil];
    }
    else if([tempstr isEqualToString:@"2"])
    {
        [self performSegueWithIdentifier:@"showCheque" sender:nil];
    }
    
    else if([tempstr isEqualToString:@"3"])
    {
        
        [self performSegueWithIdentifier:@"showCash" sender:nil];
    }
    else if([tempstr isEqualToString:@"4"])
    {
        
        [self performSegueWithIdentifier:@"showWallet" sender:nil];
    }
}
@end
