//
//  PhotoGraphViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 11/2/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
@interface PhotoGraphViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NIDropDownDelegate>

{
    IBOutlet UIButton *guestBtnSelect;
    IBOutlet UIButton *typeBtnSelect;
    IBOutlet UIButton *areaBtnSelect;
    
    NIDropDown *dropDown;
    dispatch_queue_t queue;
    
}

@property (nonatomic,strong) NSArray *filteredarray;

@property(nonatomic) BOOL *isSomethingEnabled;

@property (strong, nonatomic) IBOutlet UILabel *area_id;
@property (strong, nonatomic) IBOutlet UITextField *type_txtfld;
@property (strong, nonatomic) IBOutlet UITextField *area_txtfld;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property(nonatomic,retain)NSOperationQueue *que;
-(void)dataParsing;

@property(nonatomic,retain)NSString *newurlpass,*indxp,*urlstr,*tempservice_str,*tempcity_idstr,*available_str;
@property(nonatomic,retain)NSMutableArray *servicenamearr,*servicearr,*addressarr,*areaarr,*imgarray,*cityarr,*foodarr,*service_idarr,*role_id_arr,*area_idarr,*area_namearr,*city_idarr,*established_arr,*contact_arr,*isActivearr,*allow_other_catererarr,*availablearr,*capacityarr;

@property(nonatomic,retain)UIImage *img;
@property(nonatomic,retain)NSString *service_name_str,*loc_str,*city_str,*address_str,*service_id_str,*temprole_id,*area_idstr,*area_namestr,*city_idstr,*contact_str,*venue_namestr,*areaid;


@property (retain, nonatomic) IBOutlet UIButton *guestBtnSelect;
- (IBAction)guestselectClicked:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *typeBtnSelect;
- (IBAction)typeselectClicked:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *areaBtnSelect;
- (IBAction)areaselectClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *guestlbl;
@property (strong, nonatomic) IBOutlet UILabel *typelbl;
@property (strong, nonatomic) IBOutlet UILabel *arealbl;

@property (weak,nonatomic) UIViewController *currentViewController;
@property (strong, nonatomic) IBOutlet UIButton *allvenueBtn;
@property (strong, nonatomic) IBOutlet UIButton *filterBtnClicked;



@end
