//
//  StatusViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/31/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"
#import "NIDropDown.h"
@interface StatusViewController : UIViewController<FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance,NIDropDownDelegate,UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UIButton *veuneBtnClicked;
    
    NIDropDown *dropDown1,*dropDown2;
}
//@property (nonatomic) BOOL showAllSections;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UILabel *welcome_lbl;
//@property (strong, nonatomic) IBOutlet UIButton *venueBtn;
@property(nonatomic,retain)NSOperationQueue *que;

@property (weak , nonatomic) FSCalendar *calendar;
@property (weak , nonatomic) NSDateFormatter *formatter;
// Main color of numbers
@property (nonatomic, strong) UIColor *fontColor;
// Color of the headers (Year and month)
@property (nonatomic, strong) UIColor *fontHeaderColor;
// Color of selected numbers
@property (nonatomic, strong) UIColor *fontSelectedColor;
// Color of selection
@property (nonatomic, strong) UIColor *selectionColor;
// Color of today
@property (nonatomic, strong) UIColor *todayColor;

// Whether the currently selected date should be marked
@property (nonatomic, assign) BOOL shouldMarkSelectedDate;
// Whether today's date should be marked
@property (nonatomic, assign) BOOL shouldMarkToday;
// Whether the month and year headers should be shown
@property (nonatomic, assign) BOOL shouldShowHeaders;
// Preferred weekday start
@property (strong, nonatomic) IBOutlet UILabel *venueLbl;
@property (strong, nonatomic) IBOutlet UILabel *serviceproviderid;
@property (strong, nonatomic) IBOutlet UILabel *user;
@property (strong, nonatomic) IBOutlet UIButton *venueBtnClicked;

@property (nonatomic,retain) NSString *venue_Str,*service_provider_id_str,*user_str,*eventDateFromstr,*eventDateTostr,*countstr,*startStr,*firstNamestr,*lastNamestr,*contactStr,*useridstr,*startDateStr,*bookidstr,*isConfirmedstr,*isPaidstr,*statusStr,*success,*message;

@property (strong,nonatomic) NSMutableArray *myprofile,*allstatusArr,*statusArray,*contactArray,*firstNameArray,*startDateArray,*lastNameArray,*serviceprovideridArray,*useridArray,*bookidArray,*blockedArray;

@property (strong,nonatomic) NSMutableArray *pendingArray,*bookedArray,*confirmedArray,*cancelledArray;

@property (strong, nonatomic) IBOutlet UITextView *textView;
 
@property(strong,nonatomic)NSMutableArray *alldate;
 
@end
