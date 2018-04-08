//
//  Attendee.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/28/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Attendee : NSObject

@property (nonatomic,strong) NSString *first_name;
@property (nonatomic,strong) NSString *last_name;
@property (nonatomic,strong) NSString *contact;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *is_active,*is_tiedup,*image_extension,*username,*image_name;
@property (nonatomic,strong) NSString *role_name;
@property int mainid;
@property (nonatomic,strong) NSString *userid;

@end
