//
//  Venue.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/16/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Venue : NSObject
@property (nonatomic,strong) NSString *sevicename;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *area_name,*capacity,*food_type_id,*service_provider_id,*city_name,*role_id,*city_id,*established_year,*contact,*isActive,*area_id,*allowOtherCaterer,*available,*eventStr;
@property (weak, nonatomic) NSString *img;
@end
