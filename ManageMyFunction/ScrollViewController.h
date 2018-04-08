

#import <UIKit/UIKit.h>
#import "Attendee.h"
@interface ScrollViewController : UIViewController<NSURLConnectionDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSMutableArray *myprofile;

@property (weak, nonatomic) IBOutlet UITextField *first_name;
@property (weak, nonatomic) IBOutlet UITextField *last_name;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *contact;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property int myid;
@property (weak, nonatomic) NSString *userid;
@property (weak, nonatomic) UITextField *activeField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong,nonatomic) NSString *success;
@property (strong,nonatomic) NSString *message;
@property (strong, nonatomic) IBOutlet UIImageView *profilepic;

@end
