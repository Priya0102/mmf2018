//
//  CatererInfoViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 11/3/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatererInfoViewController : UIViewController<UITextViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextFieldDelegate>

@property(nonatomic,retain)NSString *indxpath,*service_provider_id_str;

@property (strong, nonatomic) IBOutlet UILabel *service_name;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *capacity;
//@property (strong, nonatomic) IBOutlet UILabel *price_hour;
//@property (strong, nonatomic) IBOutlet UILabel *price_day;
//@property (strong, nonatomic) IBOutlet UILabel *deposit;
@property (strong, nonatomic) IBOutlet UIImageView *cover_images;
@property (strong, nonatomic) IBOutlet UILabel *morning_start_time;
@property (strong, nonatomic) IBOutlet UILabel *morning_end_time;
//@property (strong, nonatomic) IBOutlet UILabel *opening_time;
//@property (strong, nonatomic) IBOutlet UILabel *closing_time;
//@property (strong, nonatomic) IBOutlet UILabel *facilities;
//@property (strong, nonatomic) IBOutlet UIButton *viewpdf;
@property (strong, nonatomic) IBOutlet UILabel *terms_conditons;
@property (strong, nonatomic) IBOutlet UILabel *service_provider_id;
//@property (strong, nonatomic) IBOutlet UILabel *venue_type;
//@property (strong, nonatomic) IBOutlet UILabel *event_type;
@property (strong, nonatomic) IBOutlet UILabel *established_year;

//@property (strong, nonatomic) IBOutlet UILabel *start_date;
@property (strong, nonatomic) IBOutlet UILabel *evening_start_time;
//@property (strong, nonatomic) IBOutlet UILabel *end_date;
@property (strong, nonatomic) IBOutlet UILabel *evening_end_time;

@property (strong, nonatomic) IBOutlet UILabel *contact;
@property (strong, nonatomic) IBOutlet UILabel *foodtypeid;
@property (strong, nonatomic) IBOutlet UILabel *foodtype;

@property (strong, nonatomic) IBOutlet UILabel *advancepayment;
@property (strong, nonatomic) IBOutlet UILabel *providehomeservie;
@property (strong, nonatomic) IBOutlet UILabel *min_person;
@property (strong, nonatomic) IBOutlet UILabel *priceforminperson;
//-(void)techparsing;

@property(nonatomic,retain)NSString *facilities_str,*price_hr_str,*price_day_str,*day_starttime_str,*day_endtime_str,*opening_time_str,*closing_time_str,*capacity_str,*venue_type_name_str,*event_name_str,*service_name_str,*address_str,*coverimages_str,*terms_conditons_str,*pdf_name_str,*deposit_str,*ext_str,*path_str,*eastablished_yr_str,*indxp;

@property(nonatomic,retain)NSOperationQueue *que;


@property (strong, nonatomic) IBOutlet UIButton *viewPdfBtn;
@property (strong, nonatomic) IBOutlet UIButton *changeTimeBtn;
@property (strong, nonatomic) IBOutlet UIButton *proceedBtn;


@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *contentview;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property(nonatomic,retain)NSMutableArray  *catererarr,*selectedFacility;

@property (strong, nonatomic) IBOutlet UITextField *guestcount;
@property (strong, nonatomic) IBOutlet UITextField *comments;
//@property (strong, nonatomic) IBOutlet UITextView *comments;
@property (strong, nonatomic) IBOutlet UITextField *startTime;
@property (strong, nonatomic) IBOutlet UITextField *endTime;

-(void)changeUserQuantity:(int)index :(NSString*)userQuantity;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;



@end
