//
//  WalletViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 8/31/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "WalletViewController.h"
#import "Wallet.h"
#import "WalletTableViewCell.h"
@interface WalletViewController ()

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
     _bookid.text=_bookidStr;
     _payment_mode_Id.text=_paymentIdStr;
     _payment_mode_Type.text=_paymentTypeStr;
     _amountTxt.text=_amountTypeStr;
    
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    
    self.tableview.separatorColor=[UIColor clearColor];
    
    _paymenttypearr=[[NSMutableArray alloc]init];
    
    
    NSURLSessionConfiguration *defaultConfiguration=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession=[NSURLSession sessionWithConfiguration:defaultConfiguration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url=[NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/payment_type.php"];
    
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask *datatask=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error==nil) {
            NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSError *er=nil;
            NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
            
            if (er) {
                
            }
            NSArray *payment=[responseDict objectForKey:@"paymenttype"];
            for (NSDictionary *dict in payment) {
                Wallet *a1=[[Wallet alloc]init];
                
                a1.paymentTypeStr=[dict objectForKey:@"payment_type_name"];
                a1.paymentTypeIdStr=[dict objectForKey:@"payment_type_id"];
                
                
                [self.paymenttypearr addObject:a1];
                
                
                [[NSUserDefaults standardUserDefaults]setValue:a1.paymentTypeIdStr forKey:@"paymenttype_id"];
                NSLog(@"****paymenttype_id**** = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"paymenttype_id"]);
                
                
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
    return self.paymenttypearr.count;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WalletTableViewCell *cell=[self.tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Wallet *a1=self.paymenttypearr[indexPath.row];
    
    cell.paymentId.text=a1.paymentTypeIdStr;
    cell.paymentType.text=a1.paymentTypeStr;
    cell.selectBtn.tag=indexPath.row;
    
    NSLog(@"SELECT BUTTON TAG==%ld",(long)cell.selectBtn.tag);
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Wallet *c=[_paymenttypearr objectAtIndex:indexPath.row];
    _paymentIdStr=c.paymentTypeIdStr;
    NSLog(@"DID SELECT===%@",_paymentIdStr);
    
    
    if ([_paymentIdStr isEqual:@"1"]) {
        NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"advanceamount"];
        _amountTxt.text=savedvalue;
        
        NSLog(@"BUTTON TAPPED advance Amount==%@",_amountTxt.text);
    }
    else if ([_paymentIdStr isEqual:@"2"]) {
        NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"totalamount"];
        _amountTxt.text=savedvalue;
        
        NSLog(@"BUTTON TAPPED total Amount==%@",_amountTxt.text);
    }
    else if ([_paymentIdStr isEqual:@"3"])  {
        NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"depositamount"];
        _amountTxt.text=savedvalue;
        
        NSLog(@"BUTTON TAPPED Deposit Amount==%@",_amountTxt.text);
    }
    else if ([_paymentIdStr isEqual:@"6"]) {
        NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"netamount"];
        _amountTxt.text=savedvalue;
        
        NSLog(@"BUTTON TAPPED Net Amount==%@",_amountTxt.text);
        
    }
    else if ([_paymentIdStr isEqual:@"4"]){
        _amountTxt.text=0;
        
        
    }
    else if ([_paymentIdStr isEqual:@"5"]){
        _amountTxt.text=0;
    }
    
    
    
}



- (IBAction)submitButtonClicked:(id)sender {
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Are you sure you want to submit payment?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [self submitWalletPayment];
                                    
                                    
                                    NSLog(@"you pressed Yes, please button");
                                    //[self.navigationController popViewControllerAnimated:YES];
                                    
                                    // call method whatever u need
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   //What we write here????????**
                                   NSLog(@"you pressed No, thanks button");
                                   // call method whatever u need
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)submitWalletPayment{
    
    
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"];
    NSLog(@"Book id*** = %@", [[NSUserDefaults standardUserDefaults]stringForKey:@"book_id"]);
    
    NSString *myst=[NSString stringWithFormat:@"book_id=%@&payment_type_id=%@&transaction_id=%@&bank_name=%@",savedvalue,_paymentIdStr,self.transactionId.text,self.banknameTxt.text];
    
    
    NSLog(@"Submit Cheque Payment DETAILS**=%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *urlstr=@"http://localhost/phpmyadmin/MMF/insert_wallet_payment.php";
    
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil)
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
        }
        NSError *er=nil;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
        if(er)
        {
        }
        self.success=[responseDict objectForKey:@"success"];
        self.message=[responseDict objectForKey:@"message"];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([self.success isEqualToString:@"1"])
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Success" message:self.message preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alertView dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                
                [alertView addAction:ok];
                [self presentViewController:alertView animated:YES completion:nil];
            }
            else
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Failure" message:@"Not updated successfully" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alertView dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                
                [alertView addAction:ok];
                [self presentViewController:alertView animated:YES completion:nil];
            }
        });
        
        
    }];
    
    [task resume];
}


@end
