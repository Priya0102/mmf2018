#import "ViewController.h"
//#import "PatternViewCell.h"
#import "NIDropDown.h"
#import "OpeningViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import "DateTime.h"
#define IDIOM UI_USER_INTERFACE_IDIOM()
#define IPAD UIUserInterfaceIdiomPad
@interface ViewController ()

{
    NSMutableArray *eventArray;
    
    NSUserDefaults *defaults;
    
    NSString *str;
}
@property (nonatomic, readonly) CGFloat offset;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

/* http://stackoverflow.com/questions/16832459/ios-launch-image-sizes */
@end

@implementation ViewController{
    
    float fadeAlpha;
    NSMutableArray *keyarr1;
}
@synthesize message;
@synthesize cityBtnSelect;
@synthesize eventBtnSelect;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //  d = [[DateTime alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _venueLbl.layer.borderWidth = 1;
    _venueLbl.layer.cornerRadius = 5;
    _venueLbl.clipsToBounds = YES;
    
    _venueBtn.layer.borderWidth = 1;
    //_venueBtn.layer.cornerRadius = 5;
    _venueBtn.clipsToBounds = YES;
    
    _catererlbl.layer.borderWidth = 1;
    _catererlbl.layer.cornerRadius = 5;
    _catererlbl.clipsToBounds = YES;
    
    _catererBtn.layer.borderWidth = 1;
    //_catererBtn.layer.cornerRadius = 5;
    _catererBtn.clipsToBounds = YES;
    
    _photolbl.layer.borderWidth = 1;
    _photolbl.layer.cornerRadius = 5;
    _photolbl.clipsToBounds = YES;
    
    _photoBtn.layer.borderWidth = 1;
    //_photoBtn.layer.cornerRadius = 5;
    _photoBtn.clipsToBounds = YES;
    
    
    _decoraterlbl.layer.borderWidth = 1;
    _decoraterlbl.layer.cornerRadius = 5;
    _decoraterlbl.clipsToBounds = YES;
    
    _decoretorBtn.layer.borderWidth = 1;
    //_decoretorBtn.layer.cornerRadius = 5;
    _decoretorBtn.clipsToBounds = YES;
    
    //    OpeningViewController *viewControllerB = [[OpeningViewController alloc] init];
    //    viewControllerB.isSomethingEnabled = YES;
    //    [self.navigationController pushViewController:viewControllerB animated:YES];
    
    
    //    OpeningViewController *o=[[OpeningViewController alloc]init];
    //    o.eventStr=eventBtnSelect.titleLabel.text;
    //
    //    NSLog(@"Event Btn Selected==%@",eventBtnSelect.titleLabel.text);
    //    [self.navigationController pushViewController:o animated:YES];
    //
    
    //
    //    SecondvViewController *objSecondviewController =[[SecondviewController alloc]init];
    //    objSecondviewController.secondLabelText=myLabel.text;
    //    [self.navigationController pushViewController:objSecondviewController animated:YES]
    //
    //
    
//    self.startdate.delegate=self;
//    self.enddate.delegate=self;
//    //
//    self.startdate.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"startdate"];//if we uncomment this then save value will not reflect
//    self.enddate.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"enddate"];
//    self.startTime.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"startTime"];
//    self.endTime.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"endTime"];
    
    
    keyarr1= [[NSMutableArray alloc]init];
    [self.venueBtn addTarget:self action:@selector(venueBtnClicked:) forControlEvents:UIControlEventTouchDown];
    
    fadeAlpha = 0.5f;
    cityBtnSelect.layer.borderWidth = 1;
    cityBtnSelect.layer.borderColor = [[UIColor blackColor] CGColor];
    cityBtnSelect.layer.cornerRadius = 5;
    
    eventBtnSelect.layer.borderWidth = 1;
    eventBtnSelect.layer.borderColor = [[UIColor blackColor] CGColor];
    eventBtnSelect.layer.cornerRadius = 5;
    
    
    self.navigationItem.hidesBackButton = NO;
    //  [self setupScrollView:self.scroll];
    
    self.navigationItem.backBarButtonItem.title=@"Back";
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
}
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Set the current view controller to the one embedded (in the storyboard).
    self.currentViewController = self.childViewControllers.firstObject;
}
- (void)viewDidUnload {
    //    [btnSelect release];
    //cityBtnSelect = nil;
    // [self setBtnSelect:nil];
    
    eventBtnSelect=nil;
    [self setEventBtnSelect:nil];
    [super viewDidUnload];
}
-(IBAction)cityselectClicked:(id)sender {
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Pune",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    
    if(dropDown1 == nil) {
        CGFloat f = 40;
        dropDown1 = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        
        dropDown1.delegate = self;
    }
    else {
        [dropDown1 hideDropDown:sender];
        [self rel];
    }
    
}

-(IBAction)eventselectClicked:(id)sender {
    
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
                                        NSLog(@"%@",response);
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        keyarr1= [[NSMutableArray alloc]init];
                                        
                                        NSArray *keyarr= (NSArray*)[outerdic objectForKey:@"events"];
                                        
                                        NSUInteger count=[keyarr count];
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
                                                    _other_events.text=_other_eventsstr;
                                                    
                                                    NSLog(@"****Event name==%@  Event type id==%@ Other_events==%@",str1,str2,str3);
                                                    
                                                    
                                                }];
                                                
                                                NSString *test=[keyarr1 objectAtIndex:i];
                                                
                                                NSLog(@"Area====%@",test);
                                            }
                                            i++;
                                        }
                                        NSArray * arrImage = [[NSArray alloc] init];
                                        
                                        if(dropDown2 == nil) {
                                            CGFloat f = 20000;
                                            dropDown2 = [[NIDropDown alloc]showDropDown:sender :&f :keyarr1 :arrImage :@"down"];
                                            
                                            dropDown2.delegate = self;
                                        }
                                        else {
                                            [dropDown2 hideDropDown:sender];
                                            [self rel];
                                        }
                                    }
                                    
                                }];
    
    
    [task resume];
    
}



- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
    
    self.cityName=cityBtnSelect.titleLabel.text;
    self.eventName=eventBtnSelect.titleLabel.text;
    
    NSLog(@"city==%@", cityBtnSelect.titleLabel.text);
    
    NSLog(@"event====%@",eventBtnSelect.titleLabel.text);
    
    [[NSUserDefaults standardUserDefaults]setValue:eventBtnSelect.titleLabel.text forKey:@"eventName"];
    NSLog(@"Event-Name== %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"eventName"]);
    
    
    [[NSUserDefaults standardUserDefaults]setValue:cityBtnSelect.titleLabel.text forKey:@"city"];
    NSLog(@"City== %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"city"]);
    
}

-(void)rel{
    //[dropDown1 release];
    //    dropDown2 = nil;
    //    dropDown1=nil;
    
}
- (IBAction)venueBtnClicked:(id)sender {
    
    NSLog(@"Venue Button Clicked==%@",_venueBtn);
    
//    [[NSUserDefaults standardUserDefaults]setValue:self.startdate.text forKey:@"startdate"];
//    [[NSUserDefaults standardUserDefaults]setValue:self.enddate.text forKey:@"enddate"];
//    [[NSUserDefaults standardUserDefaults]setValue:self.startTime.text forKey:@"startTime"];
//    [[NSUserDefaults standardUserDefaults]setValue:self.endTime.text forKey:@"endTime"];
//    
//     NSString *dateStart =_startdate.text;
//     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//     [dateFormatter setDateFormat:@"dd-MM-yyyy"];
//     [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
//     NSDate *date = [dateFormatter dateFromString:dateStart];
//     NSLog(@"Start date==%@,SDATE==%@",_startdate.text,date);
//     
//     
//     NSString *dateEnd =_enddate.text;
//     NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
//     [dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
//     [dateFormatter1 setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
//     NSDate *date1 = [dateFormatter1 dateFromString:dateEnd];
//     NSLog(@"End date==%@,EDATE==%@",_enddate.text,date1);
//     
//     
//     
//     NSString *timeString =_startTime.text;
//     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//     formatter.dateFormat = @"hh:mm a";
//     [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
//     NSDate *time = [formatter dateFromString:timeString];
//     NSLog(@"Start==%@,STime==%@",_startTime.text,time);
//     
//     
//     
//     NSString *timeEnd =_endTime.text;
//     NSDateFormatter *timeFormatter1 = [[NSDateFormatter alloc] init];
//     [timeFormatter1 setDateFormat:@"hh:mm a"];
//     [timeFormatter1 setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
//     NSDate *time1 = [timeFormatter1 dateFromString:timeEnd];
//     NSLog(@"End==%@,ETime==%@",_endTime.text,time1);
//     
//     if (date>date1) {
//     
//     UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"End date must be greater than start date" preferredStyle:UIAlertControllerStyleAlert];
//     UIAlertAction* ok = [UIAlertAction
//     actionWithTitle:@"OK"
//     style:UIAlertActionStyleDefault
//     handler:^(UIAlertAction * action)
//     {
//     [alertView dismissViewControllerAnimated:YES completion:nil];
//     }];
//     [alertView addAction:ok];
//     [self presentViewController:alertView animated:YES completion:nil];
//     }
//     
//     else if(date==date1)
//     {
//     
//     if (time<time1)
//     {
//     
//     UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"End time must be greater than start time" preferredStyle:UIAlertControllerStyleAlert];
//     
//     UIAlertAction* ok = [UIAlertAction
//     actionWithTitle:@"OK"
//     style:UIAlertActionStyleDefault
//     handler:^(UIAlertAction * action)
//     {
//     [alertView dismissViewControllerAnimated:YES completion:nil];
//     
//     }];
//     
//     [alertView addAction:ok];
//     [self presentViewController:alertView animated:YES completion:nil];
//     
//     }
//     else if (time==time1)
//     {
//     UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Both dates and time must not equal" preferredStyle:UIAlertControllerStyleAlert];
//     
//     UIAlertAction* ok = [UIAlertAction
//     actionWithTitle:@"OK"
//     style:UIAlertActionStyleDefault
//     handler:^(UIAlertAction * action)
//     {
//     [alertView dismissViewControllerAnimated:YES completion:nil];
//     
//     }];
//     
//     [alertView addAction:ok];
//     [self presentViewController:alertView animated:YES completion:nil];
//     }
//     else{
//        
//         
//         float diff=time1.timeIntervalSince1970-time.timeIntervalSince1970;
//         
//         int hours=(int)(diff/(3600));//total time difference divided by 3600 secs.
//         NSLog(@"TIME Difference==%d",hours);
//              //int hours=(int);
//         
//         [[NSUserDefaults standardUserDefaults] setInteger:hours forKey:@"hours"];
//         
//         [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"days"];
//         
//
//         
//     }
//     }
//     else{
//         float diff=date1.timeIntervalSince1970-date.timeIntervalSince1970;
//         int days=(int)(diff/(24*3600));
//          NSLog(@"Days Difference==%d",days);
//         
//          [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"hours"];
//          [[NSUserDefaults standardUserDefaults] setInteger:days forKey:@"days"];
//     }
//     
    
     if (dropDown1==nil) {
     UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please select mandatory fields before going further" preferredStyle:UIAlertControllerStyleAlert];
     
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
//     if (dropDown2==nil) {
//     UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please select mandatory fields before going further" preferredStyle:UIAlertControllerStyleAlert];
//     
//     UIAlertAction* ok = [UIAlertAction
//     actionWithTitle:@"OK"
//     style:UIAlertActionStyleDefault
//     handler:^(UIAlertAction * action)
//     {
//     [alertView dismissViewControllerAnimated:YES completion:nil];
//     
//     }];
//     
//     [alertView addAction:ok];
//     [self presentViewController:alertView animated:YES completion:nil];
//     
//     }
//    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier]isEqualToString:@"showVenue"])
    {
        OpeningViewController *t=[segue destinationViewController];

    t.eventStr=self.eventBtnSelect.titleLabel.text;
    t.city_str=self.cityBtnSelect.titleLabel.text;
    NSLog(@"Event==...%@..City==...%@",self.eventBtnSelect.titleLabel.text,self.cityBtnSelect.titleLabel.text);
        
    }

}


@end
