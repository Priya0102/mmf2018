//
//  Caterer.h
//  ManageMyFunction
//
//  Created by Anveshak on 11/2/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Caterer : NSObject


@property (nonatomic,strong) NSString *sevicename;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *area_name,*capacity,*food_type_id,*service_provider_id,*city_name,*role_id,*city_id,*established_year,*contact,*isActive,*area_id,*allowOtherCaterer,*available,*eventStr,*homeser_str,*min_person_str,*min_person_price_str;
@property (weak, nonatomic) NSString *img;

@end
