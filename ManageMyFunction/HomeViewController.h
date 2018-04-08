

#import <UIKit/UIKit.h>
//#import "ProfileViewController.h"
#import "Reachability.h"

@interface HomeViewController : UIViewController <UITextFieldDelegate,NSURLConnectionDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstname;
@property (weak, nonatomic) IBOutlet UITextField *lastname;
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;


@property (nonatomic,strong) NSString *result;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *failure,*main_role;
@property(nonatomic,strong)UIColor *progressIndicator;

@property(weak,nonatomic)IBOutlet NSLayoutConstraint *widthConstraint;
@property(weak,nonatomic)IBOutlet NSLayoutConstraint *heightConstraint;

@property (strong,nonatomic) NSString *role_id;
@end
