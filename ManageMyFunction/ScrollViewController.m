


#import "ScrollViewController.h"
#import "Attendee.h"
#import <QuartzCore/QuartzCore.h>
@interface ScrollViewController ()

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _profilepic.layer.cornerRadius = _profilepic.frame.size.height /2;
    _profilepic.layer.masksToBounds = YES;
    [_profilepic.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [_profilepic.layer setBorderWidth: 1.0];
    
[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    // Do any additional setup after loading the view.
    
     Attendee *a1=[[Attendee alloc]init];
    
    self.myprofile=[[NSMutableArray alloc]init];
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    
    
    NSString *myst=[NSString stringWithFormat:@"username=%@",savedValue];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
   NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/getprofile.php"];
    
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
                                          
                                          NSArray *profile=[responseDict objectForKey:@"getprofile"];
                                          
                                          for(NSDictionary * dict in profile)
                                          {
                                              
                                              a1.first_name=dict[@"first_name"];
                                              a1.last_name=[dict objectForKey:@"last_name"];
                                              a1.contact=[dict objectForKey:@"contact"];
                                              a1.address=[dict objectForKey:@"address"];
                                              a1.image_name=[dict objectForKey:@"image_name"];
                                              a1.is_active=[dict objectForKey:@"is_active"];
                                              a1.is_tiedup=[dict objectForKey:@"is_tiedup"];
                                              a1.image_extension=dict[@"image_extension"];
                                              a1.username=dict[@"username"];
                                              a1.userid=dict[@"user_id"];
                                              self.userid=dict[@"user_id"];
                                              // self.myid=dict[@"id"];
                                              
                                              [self.myprofile addObject:a1];
                                              
                                          }
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              
                                              if(a1.first_name==(NSString *) [NSNull null])
                                              {
                                                  a1.first_name=@"not given";
                                              }
                                              if(a1.last_name==(NSString *) [NSNull null])
                                              {
                                                  a1.last_name=@"not given";
                                              }
                                              if(a1.contact==(NSString *) [NSNull null])
                                              {
                                                  a1.contact=@"";
                                              }
                                              if(a1.address==(NSString *) [NSNull null])
                                              {
                                                  a1.address=@"not given";
                                              }
                                              if(a1.image_name==(NSString *) [NSNull null])
                                              {
                                                  a1.image_name=@"not given";
                                              }
                                              if(a1.is_active==(NSString *) [NSNull null])
                                              {
                                                  a1.is_active=@"";
                                              }
                                              if(a1.is_tiedup==(NSString *) [NSNull null])
                                              {
                                                  a1.is_tiedup=@"";
                                              }
                                              if(a1.image_extension==(NSString *) [NSNull null])
                                              {
                                                  a1.image_extension=@"---";
                                              }
                                              if(a1.username==(NSString *) [NSNull null])
                                              {
                                                  a1.username=@"---";
                                              }
                                              self.first_name.text=a1.first_name;
                                              self.last_name.text=a1.last_name;
                                              self.contact.text=a1.contact;
                                              self.address.text=a1.address;
                                              self.username.text=a1.username;
                                              
                                          
                                          });
                                      }];
    
    [dataTask resume];
    
    
}
- (IBAction)updateclicked:(id)sender {
    
    NSString *st=[NSString stringWithFormat:@"user_id=%@&first_name=%@&last_name=%@&contact=%@&username=%@&address=%@",self.userid,self.first_name.text,self.last_name.text,self.contact.text,self.username.text,self.address.text];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
   
    NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/update.php"];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[st dataUsingEncoding:NSUTF8StringEncoding]];
    //NSError *error=nil;
    
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
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
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Failure" message:@"Profile not updated successfully" preferredStyle:UIAlertControllerStyleAlert];
                
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
    
    [dataTask resume];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)textFieldDidBeginEditing:(UITextField *)sender
{
    self.activeField = sender;
}

- (IBAction)textFieldDidEndEditing:(UITextField *)sender
{
    self.activeField = nil;
}

- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}
- (IBAction)uploadPicBtn:(id)sender {
    

    //To convert your image file to raw.
    NSData *imageData   = UIImagePNGRepresentation(self.profilepic.image);
    NSString *urlString = @"http://sample.com/upload.php";
   // NSString *urlString = @"http://localhost/phpmyadmin/MMF/upload.php";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    //Boundary and Header.
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    //Your uploading file.
    NSMutableData *bodyData = [NSMutableData data];
    [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    /*
     * Declares the PHP received $_FILES variables.
     * - $_FILES['_varName']['name'] = _sample.png
     */
    [bodyData appendData:[@"Content-Disposition: form-data; name=\"_varName\"; filename=\"_sample.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [bodyData appendData:[NSData dataWithData:imageData]];
    [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:bodyData];
    //Received response of server.
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    //Dumps it.
    NSLog(@"%@", returnString);
    

    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
    
}
@end
