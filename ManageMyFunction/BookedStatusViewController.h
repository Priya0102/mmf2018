//
//  BookedStatusViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 10/5/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookedStatusViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *firstname;
@property (strong, nonatomic) IBOutlet UILabel *lastname;
@property (strong, nonatomic) IBOutlet UILabel *contact;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *serviceName;
@property (strong, nonatomic) IBOutlet UILabel *eventName;
@property (strong, nonatomic) IBOutlet UILabel *requestedDate;
@property (strong, nonatomic) IBOutlet UILabel *guestCount;
@property (strong, nonatomic) IBOutlet UILabel *startDate;
@property (strong, nonatomic) IBOutlet UILabel *startTime;
@property (strong, nonatomic) IBOutlet UILabel *endDate;
@property (strong, nonatomic) IBOutlet UILabel *endTime;
@property (strong, nonatomic) IBOutlet UILabel *confirmedDate;
@property (strong, nonatomic) IBOutlet UILabel *totalAmount;
@property (strong, nonatomic) IBOutlet UILabel *deposit;
@property (strong, nonatomic) IBOutlet UILabel *paymentTypeName;
@property (strong, nonatomic) IBOutlet UILabel *amount;
@property (strong, nonatomic) IBOutlet UILabel *details;
@property (strong, nonatomic) IBOutlet UILabel *paymentDate;
@property (strong, nonatomic) IBOutlet UILabel *paymentModeType;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UITableView *tableview2;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *userid;
@property (strong, nonatomic) IBOutlet UILabel *bookid;
@property (strong, nonatomic) IBOutlet UILabel *serviceproviderid;
@property (strong, nonatomic) IBOutlet UILabel *userEventId;
@property (strong, nonatomic) IBOutlet UILabel *eventTypeId;
@property (strong, nonatomic) IBOutlet UILabel *isPaid;
@property (strong, nonatomic) IBOutlet UILabel *isConfirmed;
@property (strong, nonatomic) IBOutlet UILabel *serviceProviderUserId;
@property (strong, nonatomic) IBOutlet UILabel *eastablished;
@property (strong, nonatomic) IBOutlet UILabel *paymentModeId;
@property (strong, nonatomic) IBOutlet UILabel *paymentTypeId;
@property(strong,nonatomic)IBOutlet UILabel *cheque;
@property(strong,nonatomic)IBOutlet UILabel *transaction_id;
@property(strong,nonatomic)IBOutlet UILabel *bankName;

@property(strong,nonatomic)IBOutlet UILabel *amountType;
@property(strong,nonatomic)IBOutlet UILabel *eventAmountId;
@property(strong,nonatomic)IBOutlet UILabel *idlbl;
@property(strong,nonatomic)IBOutlet UILabel *price;

@property(strong,nonatomic)IBOutlet UILabel *commentType;
@property(strong,nonatomic)IBOutlet UILabel *eventCommentId;
@property(strong,nonatomic)IBOutlet UILabel *commentidlbl;
@property(strong,nonatomic)IBOutlet UILabel *comments;

@property(nonatomic,retain)NSString *service_provider_id_str,*book_id_str,*usereventidStr,*user_idStr,*eventTypeidStr,*eventDatefromStr,*eventDateToStr,*eventTimeFromStr,*evetTimeToStr,*guestStr,*requestedDateStr,*confirmedDateStr,*is_paidStr,*is_ConfirmedStr,*serviceprovider_useridStr,*firstNameStr,*lastNameStr,*contactStr,*addressStr,*serviceNameStr,*establishedStr,*eventNameStr;

@property(nonatomic,retain)NSString *paymentmodeidStr,*paymenttypeidStr,*paymentDateStr,*amountStr,*paymentTypeNameStr,*paymentModeTypeStr,*chequeStr,*transactionidStr,*bankNameStr,*amountTypeStr,*eventAmountIdStr,*idStr,*priceStr,*eventCommentIdStr,*commentTypeStr,*commentStr,*success,*message,*statusStr;
@property(nonatomic,retain)NSOperationQueue *que;

@property(strong,nonatomic)NSMutableArray *otherfaciltyarr,*otherdetailarr;
@property (strong, nonatomic) IBOutlet UITextField *advancePaymentamountTxtfld;
@property (strong, nonatomic) IBOutlet UITextField *advancePaymentCommentTxtFld;

@property (strong, nonatomic) IBOutlet UITextField *depositamountTxtfld;
@property (strong, nonatomic) IBOutlet UITextField *commentDepositTxtFld;



@end
