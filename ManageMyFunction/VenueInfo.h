//
//  VenueInfo.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/21/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VenueInfo : NSObject<NSCoding>


@property (nonatomic, retain) NSMutableArray *venuefacilityarray;
+(VenueInfo*)singleton;


@property (nonatomic,retain) NSString *facility_id,*unit,*quantity,*price,*comments,*facility_id_no,*facility_name,*userquantity,*price_per_unit;
@end
