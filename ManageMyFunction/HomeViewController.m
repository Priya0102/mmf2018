

#import "HomeViewController.h"
#import "NewUserViewController.h"
#import "ForgotViewController.h"
#import "BookingViewController.h"
#import "StatusViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self testInternetConnection];
   
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Cannot connect to internet" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alertView addAction:ok];
        
        
    }
    UIView *paddingview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, self.firstname.frame.size.height)];
    self.firstname.leftView=paddingview;
    self.firstname.leftViewMode=UITextFieldViewModeAlways;
    
    UIView *paddingview2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, self.lastname.frame.size.height)];
    self.lastname.leftView=paddingview2;
    self.lastname.leftViewMode=UITextFieldViewModeAlways;
    
    self.loginbtn.layer.masksToBounds=YES;
    self.loginbtn.layer.borderColor=[UIColor whiteColor].CGColor;
    self.loginbtn.layer.borderWidth=1.1;
    self.loginbtn.layer.cornerRadius=10;
    self.loginbtn.layer.shadowColor=[UIColor redColor].CGColor;
    

   
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"ManageMyFunction"
                                                                             attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" "
                                                                             attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                                                                          NSBackgroundColorAttributeName: [UIColor whiteColor]}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"2017"]];
    
  /* NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    
    
    NSString *myst=[NSString stringWithFormat:@"user=%@",savedValue];
    NSLog(@"MY USER NAME==...%@",myst);
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    
    NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/user_role.php"];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error == nil)
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog(@"data=%@",text);
            self.role_id=text;
        }
        NSError *er=nil;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
        if(er)
        {
            
        }
        self.role_id=[responseDict objectForKey:@"status"];
    }];
    
    
    [dataTask resume];
    

    */
  
    
}

- (IBAction)loginclicked:(id)sender {
    
      NSLog(@"Login Button Clicked==%@",_loginbtn);
    
    UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame=CGRectMake(self.view.window.center.x,self.view.window.center.y, 40.0, 40.0);
    indicator.center=self.view.center;
    [self.view addSubview:indicator];
    
    
    indicator.tintColor=[UIColor redColor];
    indicator.backgroundColor=[UIColor blackColor];
    [indicator bringSubviewToFront:self.view];
    // [UIApplication sharedApplication].networkActivityIndicatorVisible=true;
    [indicator startAnimating];
    if(self.firstname.text.length==0 && self.lastname.text.length==0)
    {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Enter username and password" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alertView addAction:ok];
        [indicator stopAnimating];
        
        [self presentViewController:alertView animated:YES completion:nil];
        
    }
    if(self.firstname.text.length==0)
    {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please enter your email-id" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alertView addAction:ok];
        [indicator stopAnimating];
        
        [indicator stopAnimating];
        
        [self presentViewController:alertView animated:YES completion:nil];
    }
    if(self.lastname.text.length==0)
    {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please enter your password" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alertView addAction:ok];
        [indicator stopAnimating];
        
        [self presentViewController:alertView animated:YES completion:nil];
    }
    
    
    if(self.firstname.text.length>0 && self.lastname.text.length>0)
    {
        NSString *myst=[NSString stringWithFormat:@"username=%@&password=%@",self.firstname.text,self.lastname.text];
        self.email=self.lastname.text;
        
        
        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        
       NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/login.php"];//local
        
        
        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSError *error=nil;
        NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              if(error == nil)
                                              {
                                                  NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                  
                                                  if ([httpResponse statusCode]!=200)
                                                  {
                                                      return;
                                                  }
                                                  
                                                  NSString *text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                  NSError *er=nil;
                                                  NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
                                                  if(er)
                                                  {
                                                  }
                                                
                                                  self.failure=[responseDict objectForKey:@"message"];
                                                  self.result=[[responseDict objectForKey:@"success"]stringValue];
                                                  self.main_role=[responseDict objectForKey:@"main_role"];
                                                  
                                                
                                              }
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  if([self.result isEqualToString:@"1"])
                                                  {
                                                      [[NSUserDefaults standardUserDefaults] setObject:self.firstname.text forKey:@"username"];
                                                      [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"isLoggedIn"];
                                                      
                                                      [[NSUserDefaults standardUserDefaults] synchronize];
                                                      
                                                      [indicator stopAnimating];
                                                      if (self.main_role!=NULL) {
                                                        
                                                           int mainRole=[self.main_role intValue];
                                                          
                                                          NSLog(@"Main role===%@",self.main_role);
                                                         
                                                          switch (mainRole) {
                                                              case 1:
                                                                  [self performSegueWithIdentifier:@"user" sender:self];
                                                                  break;
                                                                  
                                                              case 2:
                                                                  [self performSegueWithIdentifier:@"venuemanager" sender:self];
                                                                  break;
                                                                  
                                                              case 3:
                                                                  [self performSegueWithIdentifier:@"admin" sender:self];
                                                                  break;
                                                                  
                                                              default:
                                                                  break;
                                                          }
                                                      }
                                                     
                                                      
                                                  }
                                                  else
                                                  {
                                                      UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:self.failure preferredStyle:UIAlertControllerStyleAlert];
                                                      
                                                      UIAlertAction* ok = [UIAlertAction
                                                                           actionWithTitle:@"OK"
                                                                           style:UIAlertActionStyleDefault
                                                                           handler:^(UIAlertAction * action)
                                                                           {
                                                                               [alertView dismissViewControllerAnimated:YES completion:nil];
                                                                           }];
                                                      
                                                      [alertView addAction:ok];
                                                      [indicator stopAnimating];
                                                      [self presentViewController:alertView animated:YES completion:nil];
                                                  }
                                              });
                                              
                                          }];
        [dataTask resume];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
     NSLog(@"prepareForSegue: %@", segue.identifier);
    
    if([segue.identifier isEqualToString:@"ToProfile"])
    {
        //ProfileViewController *controller=segue.destinationViewController;
        //controller.email=self.email;
    }
    if([segue.identifier isEqualToString:@"showSignUp"])
    {
        NewUserViewController *n=[segue destinationViewController];

    }
    if([segue.identifier isEqualToString:@"showForgotPassword"])
    {
        ForgotViewController *f=[segue destinationViewController];

    }
   
//    if([segue.identifier isEqualToString:@"showBookingNext"])
//    {
//        BookingViewController *b=[segue destinationViewController];
//        
//    }
//    if([segue.identifier isEqualToString:@"showVenueManager"])
//    {
//        StatusViewController *s=[segue destinationViewController];
//        
//    }
}
- (IBAction)forgotpassword:(id)sender {
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.firstname resignFirstResponder];
    [self.lastname resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

- (void)testInternetConnection
{
    __weak typeof(self) weakSelf = self;
    Reachability *internetReachable = [Reachability reachabilityForInternetConnection];
    // NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    internetReachable = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    internetReachable.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            //Make sure user interaction on whatever control is enabled
        });
    };
    
    // Internet is not reachable
    internetReachable.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"No Internet Connection" message:@"Please connect to the internet." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alertView dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            
            [alertView addAction:ok];
            [self presentViewController:alertView animated:YES completion:nil];
            //Make sure user interaction on whatever control is disabled
        });
    };
    
    [internetReachable startNotifier];
}
@end
