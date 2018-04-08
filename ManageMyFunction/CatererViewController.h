//
//  CatererViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 11/2/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
@interface CatererViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,NIDropDownDelegate>

{
    IBOutlet UIButton *guestBtnSelect;
    IBOutlet UIButton *foodtypeBtnSelect;
    IBOutlet UIButton *areaBtnSelect;
    
    NIDropDown *dropDown;
    dispatch_queue_t queue;
    
}

@property (nonatomic,strong) NSArray *filteredarray;

@property(nonatomic) BOOL *isSomethingEnabled;
@property (strong, nonatomic) IBOutlet UILabel *start_date;
@property (strong, nonatomic) IBOutlet UILabel *start_time;
@property (strong, nonatomic) IBOutlet UILabel *end_date;

@property (strong, nonatomic) IBOutlet UILabel *end_time;
@property (strong, nonatomic) IBOutlet UILabel *city;

@property (strong, nonatomic) IBOutlet UITextField *guest_txtfld;
@property (strong, nonatomic) IBOutlet UITextField *type_txtfld;
@property (strong, nonatomic) IBOutlet UITextField *area_txtfld;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) IBOutlet UITableView *tableview;


@property (strong, nonatomic) IBOutlet UILabel *area_id;
@property (strong, nonatomic) IBOutlet UILabel *venue_type_id;
@property (strong, nonatomic) IBOutlet UILabel *allow_other_caterer;
@property (strong, nonatomic) IBOutlet UILabel *capacity1;
@property (strong, nonatomic) IBOutlet UILabel *capacity2;
@property (strong, nonatomic) IBOutlet UILabel *city_id;
@property (strong, nonatomic) IBOutlet UILabel *venue_type;

@property (strong, nonatomic) IBOutlet UILabel *event_lbl;

@property(nonatomic,retain)NSOperationQueue *que;
-(void)dataParsing;
//-(void)rel;
@property(nonatomic,retain)NSString *newurlpass,*indxp,*urlstr,*tempservice_str,*tempcity_idstr,*available_str;
@property(nonatomic,retain)NSMutableArray *servicenamearr,*servicearr,*addressarr,*areaarr,*imgarray,*homeser_arr,*foodarr,*service_idarr,*min_persons_price_arr,*area_idarr,*area_namearr,*city_idarr,*established_arr,*contact_arr,*min_person_arr,*availablearr,*capacityarr;

@property(nonatomic,retain)UIImage *img;
@property(nonatomic,retain)NSString *service_name_str,*foodidStr,*foodtypeStr,*loc_str,*city_str,*address_str,*capacity_str1,*capacity_str2,*service_id_str,*temprole_id,*area_idstr,*area_namestr,*city_idstr,*capacity_str,*venue_namestr,*areaid,*eventStr;


@property (retain, nonatomic) IBOutlet UIButton *guestBtnSelect;
- (IBAction)guestselectClicked:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *foodtypeBtnSelect;
- (IBAction)foodtypeselectClicked:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *areaBtnSelect;
- (IBAction)areaselectClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *guestlbl;
@property (strong, nonatomic) IBOutlet UILabel *foodtypelbl;
@property (strong, nonatomic) IBOutlet UILabel *arealbl;
@property (strong, nonatomic) IBOutlet UILabel *foodtypeid_lbl;

@property(nonatomic,retain)NSArray *capacitiesarr;
@property (weak,nonatomic) UIViewController *currentViewController;
@property (strong, nonatomic) IBOutlet UIButton *allvenueBtn;
@property (strong, nonatomic) IBOutlet UIButton *filterBtnClicked;



@end
