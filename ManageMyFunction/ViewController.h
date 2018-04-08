

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "NIDropDown.h"
#import "DropdownMenuSegue.h"
#import "OpeningViewController.h"
//#import "DateTime.h"
//#import "WSCalendarView.h"

@interface ViewController : UIViewController<UIScrollViewDelegate,NIDropDownDelegate,UITextFieldDelegate>
{
    IBOutlet UIButton *cityBtnSelect;
    IBOutlet UIButton *eventBtnSelect;
    
    NIDropDown *dropDown1,*dropDown2;
    
}

@property (weak, nonatomic) IBOutlet UITextField *txtCalender;
@property (weak, nonatomic) IBOutlet UIView *containerView;
//-(void)rel;

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (nonatomic,strong) NSString *result;

@property(nonatomic,strong)NSArray *patternImagesArray;
@property (weak, nonatomic) IBOutlet UILabel *message;

//@property (nonatomic, retain) NSString *city_str;

@property(nonatomic,strong)NSArray *labelArray;
@property (weak, nonatomic) IBOutlet UIImageView *animationView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbutton;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *contentview;

@property (strong,nonatomic) NSString *role_id;

@property (strong,nonatomic) NSString *city_str,*startDatestr,*endDatestr,*eventNamestr,*event_idstr,*other_eventsstr,*startTimestr,*endTimestr;

@property (strong,nonatomic) NSString *cityName;
@property (strong,nonatomic) NSString *eventName;
@property int maximumZoomScale;
@property int minimumZoomScale;

//@property(nonatomic,retain)OpeningViewController *ovc;
//@property DateTime *d;
@property (strong, nonatomic) IBOutlet UITextField *startdate;

@property (strong, nonatomic) IBOutlet UITextField *enddate;
@property (strong, nonatomic) IBOutlet UITextField *startTime;
@property (strong, nonatomic) IBOutlet UITextField *endTime;
@property (strong, nonatomic) IBOutlet UITextField *eventType;

@property (strong, nonatomic) IBOutlet UITextField *city;



@property (retain, nonatomic) IBOutlet UIButton *venueBtn;
@property (retain, nonatomic) IBOutlet UIButton *cityBtnSelect;
- (IBAction)cityselectClicked:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *eventBtnSelect;
- (IBAction)eventselectClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *citylbl;
@property (strong, nonatomic) IBOutlet UILabel *eventname;
@property (strong, nonatomic) IBOutlet UILabel *eventtypeid;
@property (strong, nonatomic) IBOutlet UILabel *other_events;
@property (strong, nonatomic) IBOutlet UILabel *venueLbl;
@property (strong, nonatomic) IBOutlet UIButton *catererBtn;
@property (strong, nonatomic) IBOutlet UILabel *catererlbl;
@property (strong, nonatomic) IBOutlet UIButton *photoBtn;
@property (strong, nonatomic) IBOutlet UIButton *decoretorBtn;
@property (strong, nonatomic) IBOutlet UILabel *decoraterlbl;
@property (strong, nonatomic) IBOutlet UILabel *photolbl;
@property (weak,nonatomic) UIViewController *currentViewController;
@end

