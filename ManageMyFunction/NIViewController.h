

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "DropdownMenuSegue.h"

@interface NIViewController : UIViewController <NIDropDownDelegate>
{
    IBOutlet UIButton *btnSelect;
    NIDropDown *dropDown;
}

@property (retain, nonatomic) IBOutlet UIButton *btnSelect;
- (IBAction)selectClicked:(id)sender;

-(void)rel;

@property (weak, nonatomic) IBOutlet UIButton *startPlanningBtn;


@property (weak,nonatomic) UIViewController *currentViewController;
@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIView *menubar;
@property (weak, nonatomic) IBOutlet UIView *menu;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (strong, nonatomic) IBOutlet UILabel *event_type;
@property (nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

- (IBAction) displayGestureForTapRecognizer:(UITapGestureRecognizer *) recognizer;
- (IBAction) menuButtonAction: (UIButton *) sender;
- (IBAction) listButtonAction: (UIButton *) sender;

//- (void) setTrianglePlacement: (float) trianglePlacementVal;
//- (void) setFadeAmountWithAlpha:(float) alphaVal;
//- (void) setFadeTintWithColor:(UIColor *) color;
//- (void) dropShapeShouldShowWhenOpen:(BOOL)shouldShow;
- (void) setMenubarTitle:(NSString *) menubarTitle;
- (void) setMenubarBackground:(UIColor *) color;
- (void) toggleMenu;
- (void) showMenu;
- (void) hideMenu;


-(void)techparsing;
@property (strong, nonatomic) IBOutlet UILabel *eventname;
@property (strong, nonatomic) IBOutlet UILabel *eventtypeid;
@property (strong, nonatomic) IBOutlet UILabel *other_events;

@property(nonatomic,retain)NSOperationQueue *que;

@property(nonatomic,retain)NSString *eventNamestr,*event_idstr,*other_eventstr;

@end
