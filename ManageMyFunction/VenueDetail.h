//
//  VenueDetail.h
//  ManageMyFunction
//
//  Created by Anveshak on 11/2/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VenueDetail : NSObject

@property (nonatomic,strong) NSString *sevicename;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *location,*capacity,*food_type_id,*service_provider_id,*city_name,*role_id,*city_id,*established_year,*contact,*isActive,*area_id,*allowOtherCaterer,*available,*eventStr,*area_name;
@property (weak, nonatomic) NSString *img;

@end
