
#import "NIViewController.h"
#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

@interface NIViewController ()
@property (nonatomic, readonly) CGFloat offset;

- (void)iOS6_hideMenuCompleted;
@end

@implementation NIViewController{
     float fadeAlpha;
     NSMutableArray *keyarr1;
}

@synthesize btnSelect;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
      keyarr1= [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
    fadeAlpha = 0.5f;
    btnSelect.layer.borderWidth = 1;
    btnSelect.layer.borderColor = [[UIColor blackColor] CGColor];
    btnSelect.layer.cornerRadius = 5;
    btnSelect.clipsToBounds = YES;
}
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Set the current view controller to the one embedded (in the storyboard).
    self.currentViewController = self.childViewControllers.firstObject;
}
- (void)viewDidUnload {
//    [btnSelect release];
    btnSelect = nil;
    [self setBtnSelect:nil];
    [super viewDidUnload];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

- (void)dealloc {
//    [btnSelect release];
//    [super dealloc];
}
/*- (IBAction)selectClicked:(id)sender {
    
    
    //NSArray * arr = [[NSArray alloc] init];


        NSBlockOperation *op2=[NSBlockOperation blockOperationWithBlock:^{
            
            NSString *urlstr=@"http://localhost/phpmyadmin/MMF/event_type.php";
            //NSString *urlstr=@"http://siddhantedu.com/MMF/event_type.php";
            
            NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
            
            NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
            
            NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
            
            NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                        {
                                            
                                            if(data==nil)
                                            {
                                                NSLog(@"Data is nil");
                                                
                                            }
                                            
                                            else
                                            {
                                                
                                                
                                                NSLog(@"%@",response);
                                                
                                                
                                                NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                
                                                NSArray *arr=[outerdic objectForKey:@"events"];
                                                
                                                for(NSDictionary *temp in arr)
                                                {
                                                    NSString *str1=[temp objectForKey:@"event_type_id"];
                                                    NSString *str2=[temp objectForKey:@"event_name"];
                                                    
                                                    NSLog(@"%@event _name......",str1);
                                                    
                                                    {
                                                        
                                                        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                            
//                                                            _event_idstr=str1;
//                                                            
//                                                            _startPlanningBtn.tag=_event_idstr;
                                                            //_about.text=_aboutstr;
                                                            
                                                            _eventstr=str2;
                                                            _event_type.text=_eventstr;
                                                            
                                                            NSLog(@"%@...EVENT TYPE=...%@",_event_type.text);
                                                            //_startPlanningBtn.tag=_eventstr;
                                                            
                                                            
                                                        }];
                                                        
                                                    }
                                                }
                                            }
                                            
                                        }];
            
            [task resume];
            
        }];
        
        [_que addOperation:op2];
        
    
    
    

    
//    
//    
//    
       NSArray * arr = [[NSArray alloc] init];
   arr = [NSArray arrayWithObjects:@"Wedding", @"Birthday", @"Social Meetup", @"Shradhh", @"Theme Party", @"Sangeet", @"Reception", @"Pre-wedding function", @"Naming ceremony", @"Engagement",nil];
    NSArray * arrImage = [[NSArray alloc] init];
 
    if(dropDown == nil) {
        CGFloat f = 2000;
         dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}
*/
- (IBAction)selectClicked:(id)sender {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_events.php"];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    if(data==nil)
                                    {
                                        NSLog(@"Data is nil");
                                    }
                                    else
                                    {
                                        NSLog(@"response==%@",response);
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        keyarr1= [[NSMutableArray alloc]init];
                                        
                                        NSArray *keyarr= (NSArray*)[outerdic objectForKey:@"events"];
                                        
                                        NSUInteger count=[keyarr count];
                                          NSLog(@"keyarr==%@ & count=%lu",keyarr,(unsigned long)count);
                                        
                                        NSUInteger i=0;
                                        
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            NSString *str1=[temp objectForKey:@"event_name"];
                                            NSString *str2=[temp objectForKey:@"event_type_id"];
                                            NSString *str3=[temp objectForKey:@"other_events"];
                                            
                                            if(count>i)
                                            {
                                                [keyarr1 addObject:str1];
                                                
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                    _eventname.text=_eventNamestr;
                                                    _eventtypeid.text=_event_idstr;
                                                    _other_events.text=_other_eventstr;
                                                    
                                                    NSLog(@"Event name%@  Event type id==%@ Other_events==%@",str1,str2,str3);
                                                    
                                                    [[NSUserDefaults standardUserDefaults]setValue:str1 forKey:@"eventname"];
                                                    NSLog(@"***Venue eventname = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"eventname"]);
                                                    

                                                    
                                                }];
                                                
                                                NSString *test=[keyarr1 objectAtIndex:i];
                                                
                                                NSLog(@"Area====%@",test);
                                                
                                                
                                            }
                                            i++;
                                        }
                                        NSArray * arrImage = [[NSArray alloc] init];
                                        
                                        if(dropDown == nil) {
                                            CGFloat f = 12000;
                                            dropDown = [[NIDropDown alloc]showDropDown:sender :&f :keyarr1 :arrImage :@"down"];
                                            
                                            dropDown.delegate = self;
                                        }
                                        else {
                                            [dropDown hideDropDown:sender];
                                            [self rel];
                                        }
                                    }
                                    
                                }];
    
    
    [task resume];
    
}


- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
    
    //self.eventname=btnSelect.titleLabel.text;
    NSLog(@"%@", btnSelect.titleLabel.text);
}

-(void)rel{
//    [dropDown release];
    //dropDown = nil;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ToVenue"])
    {
        //ProfileViewController *controller=segue.destinationViewController;
        //controller.email=self.email;
    }
}

@end
