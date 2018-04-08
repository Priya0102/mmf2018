
#import "NewUserViewController.h"

@interface NewUserViewController ()

@end

@implementation NewUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}




- (IBAction)saveclicked:(id)sender {
    
    NSString *myst=[NSString stringWithFormat:@"first_name=%@&last_name=%@&contact=%@&username=%@&password=%@",self.firstname.text,self.lastname.text,self.contact.text,self.username.text,self.password.text];
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    
    NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/mainsignup.php"];
    //NSURL * url = [NSURL URLWithString:@"http://www.siddhantedu.com/iOSAPI/Symp/mainsignup.php"];//server
    //NSURL * url = [NSURL URLWithString:@"http://www.siddhantedu.com/iOSAPI/mainsignup2.php"];
    //    if(self.password.text.length==0)
    //    {
    //        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please fill all details" preferredStyle:UIAlertControllerStyleAlert];
    //
    //        UIAlertAction* ok = [UIAlertAction
    //                             actionWithTitle:@"OK"
    //                             style:UIAlertActionStyleDefault
    //                             handler:^(UIAlertAction * action)
    //                             {
    //                                 [alertView dismissViewControllerAnimated:YES completion:nil];
    //
    //                             }];
    //
    //        [alertView addAction:ok];
    //        [self presentViewController:alertView animated:YES completion:nil];
    //
    // }
    
    
    //    int numberofCharacters = 0;
    //    BOOL lowerCaseLetter = false,upperCaseLetter = false,digit = false,specialCharacter = 0;
    //    if([_password.text length] >= 8)
    //    {
    //        for (int i = 0; i < [_password.text length]; i++)
    //        {
    //            unichar c = [_password.text characterAtIndex:i];
    //            if(!lowerCaseLetter)
    //            {
    //                lowerCaseLetter = [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:c];
    //            }
    //            if(!upperCaseLetter)
    //            {
    //                upperCaseLetter = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c];
    //            }
    //            if(!digit)
    //            {
    //                digit = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
    //            }
    //            if(!specialCharacter)
    //            {
    //                specialCharacter = [[NSCharacterSet symbolCharacterSet] characterIsMember:c];
    //            }
    //        }
    //
    //        if(specialCharacter && digit && lowerCaseLetter && upperCaseLetter)
    //        {
    //            //do what u want
    //        }
    //        else
    //        {
    //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
    //                                                            message:@"Please Ensure that you have at least one lower case letter, one upper case letter, one digit and one special character"
    //                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //            [alert show];
    //        }
    //
    //    }
    //    else
    //    {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
    //                                                        message:@"Please Enter at least 8 digit password"
    //                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //    }
    
    //[self checkPassword:_password];
    
    if([self checkPassword:_password])
    {
        // NSLog(@"PASSRORD IS WRONG!!!!....");
    }
    else
    {
        //NSLog(@"DATA SAVED!!!!!!....");
        
    }
    if([self.password.text isEqualToString:self.confirm_password.text] && self.password.text.length>0 && self.confirm_password.text.length>0)
    {
        
        NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/change_signup.php"];
        //NSURL * url = [NSURL URLWithString:@"http://www.siddhantedu.com/iOSAPI/Symp/change_signup.php"];//server
        
        //NSURL *url=[NSURL URLWithString:@"http://www.siddhantedu.com/admin_ith/change_signup.php"];//old server url
        
        
        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
        NSError *error=nil;
        
        NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if(error == nil)
            {
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSLog(@"data =%@",text);
                self.result= [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                
                
            }
            NSError *er=nil;
            NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
            if(er)
            {
            }
            
            self.result=[dictionary objectForKey:@"success"];
            self.message=[dictionary objectForKey:@"message"];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if([self.result isEqualToString:@"1"])
                {
                    
                    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:self.message preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* ok = [UIAlertAction
                                         actionWithTitle:@"OK"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action)
                                         {
                                             
                                             [alertView dismissViewControllerAnimated:YES completion:nil];
                                             [self performSegueWithIdentifier:@"Home" sender:self];
                                             
                                             
                                         }];
                    
                    [alertView addAction:ok];
                    [[NSUserDefaults standardUserDefaults] setObject:self.username.text forKey:@"username"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [self presentViewController:alertView animated:YES completion:nil];
                    
                    
                    
                }
                else
                {
                    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:self.message preferredStyle:UIAlertControllerStyleAlert];
                    
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
    
    
    else
    {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Confirm Password doesn't match" preferredStyle:UIAlertControllerStyleAlert];
        
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
    
    
}


-(BOOL)checkPassword:(UITextField *)textField
{
    
    
    int numberofCharacters = 0;
    BOOL lowerCaseLetter = false,upperCaseLetter = false,digit = false,specialCharacter = 0;
    if([textField.text length] >= 8)
    {
        for (int i = 0; i < [textField.text length]; i++)
        {
            unichar c = [textField.text characterAtIndex:i];
            if(!lowerCaseLetter)
            {
                lowerCaseLetter = [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:c];
            }
            if(!upperCaseLetter)
            {
                upperCaseLetter = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c];
            }
            if(!digit)
            {
                digit = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
            }
            if(!specialCharacter)
            {
                specialCharacter = [[NSCharacterSet symbolCharacterSet] characterIsMember:c];
            }
        }
        
        if(specialCharacter && digit && lowerCaseLetter && upperCaseLetter)
        {
            //do what u want
            return true;
        }
        else
        {
            //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
            //                                                                message:@"Please Ensure that you have at least one lower case letter, one upper case letter, one digit and one special character"
            //                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //                [alert show];
            //                return false;
        }
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please Enter at least 8 digit password"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return false;
    }
    
    return true;
    
}


//-(void)textFieldDidEndEditing:(UITextField *)textField{
//
//    textField=_password;
//    int numberofCharacters = 0;
//    BOOL lowerCaseLetter = false,upperCaseLetter = false,digit = false,specialCharacter = 0;
//    if([_password.text length] >= 8)
//    {
//        for (int i = 0; i < [_password.text length]; i++)
//        {
//            unichar c = [_password.text characterAtIndex:i];
//            if(!lowerCaseLetter)
//            {
//                lowerCaseLetter = [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:c];
//            }
//            if(!upperCaseLetter)
//            {
//                upperCaseLetter = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c];
//            }
//            if(!digit)
//            {
//                digit = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
//            }
//            if(!specialCharacter)
//            {
//                specialCharacter = [[NSCharacterSet symbolCharacterSet] characterIsMember:c];
//            }
//        }
//
//        if(specialCharacter && digit && lowerCaseLetter && upperCaseLetter)
//        {
//            //do what u want
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                            message:@"Please Ensure that you have at least one lower case letter, one upper case letter, one digit and one special character"
//                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//        }
//
//    }
//    else
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                        message:@"Please Enter at least 8 digit password"
//                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.firstname resignFirstResponder];
    [self.lastname resignFirstResponder];
    [self.confirm_password resignFirstResponder];
    [self.contact resignFirstResponder];
    [self.password resignFirstResponder];
    [self.username resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==self.firstname)
    {
        [textField resignFirstResponder];
        [self.lastname becomeFirstResponder];
    }
    else if(textField==self.lastname)
    {
        [textField resignFirstResponder];
        [self.contact becomeFirstResponder];
    }
    else if(textField==self.contact)
    {
        [textField resignFirstResponder];
        [self.username becomeFirstResponder];
    }
    else if(textField==self.username)
    {
        [textField resignFirstResponder];
        [self.password becomeFirstResponder];
    }
    else if(textField==self.password)
    {
        [textField resignFirstResponder];
        [self.confirm_password becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return  YES;
}
- (IBAction)textFieldDidBeginEditing:(UITextField *)sender
{
    self.activeField = sender;
}

//- (IBAction)textFieldDidEndEditing:(UITextField *)sender
//{
//    self.activeField = nil;
//}

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

@end
