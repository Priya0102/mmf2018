//
//  RecieptViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/31/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecieptViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UILabel *registrationNo;
@property (strong, nonatomic) IBOutlet UILabel *serviceName;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *contact;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *contactCustomer;
@property (strong, nonatomic) IBOutlet UILabel *eventName;
@property (strong, nonatomic) IBOutlet UILabel *eventAddress;
@property (strong, nonatomic) IBOutlet UILabel *startDate;
@property (strong, nonatomic) IBOutlet UILabel *startTime;
@property (strong, nonatomic) IBOutlet UILabel *endDate;
@property (strong, nonatomic) IBOutlet UILabel *endTime;
@property (strong, nonatomic) IBOutlet UILabel *totalAmount;
@property (strong, nonatomic) IBOutlet UILabel *advancePayment;
@property (strong, nonatomic) IBOutlet UILabel *paidDate;
@property (strong, nonatomic) IBOutlet UILabel *netBalance;
@property (strong, nonatomic) IBOutlet UILabel *bookid;
@property (strong, nonatomic) IBOutlet UILabel *reciept_id;
@property (strong, nonatomic) IBOutlet UILabel *reciept_number;

    
@property(nonatomic,retain)NSString *serviceNameStr,*addressStr,*contactStr,*nameStr,*contactCustomerStr,*eventNameStr,*eventAddressStr,*startTimeStr,*endTimeStr,*startDateStr,*endDateStr,*totalAmountStr,*bookidStr,*idStr,*recieptNumberStr;

@property(strong,nonatomic)NSMutableArray *otherfaciltyarr,*otherdetailarr;
    
@end
