//
//  VenueInfo.m
//  ManageMyFunction
//
//  Created by Anveshak on 8/21/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "VenueInfo.h"

#define kfacility_idKey    @"facility_id"
#define kunitKey           @"unit"
#define kquantityKey       @"quantity"
#define kpriceKey          @"price"
#define kcommentsKey       @"comments"
#define kfacility_nameKey  @"facility_name"
#define kuserquantityKey          @"userquantity"
#define kprice_per_unitKey       @"price_per_unit"
#define kfacility_id_noKey  @"facility_id_no"

@implementation VenueInfo
@synthesize facility_name;


+(VenueInfo *)singleton {
    static dispatch_once_t pred;
    static VenueInfo *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[VenueInfo alloc] init];
        shared.venuefacilityarray = [[NSMutableArray alloc]init];
        NSLog(@"%@",[VenueInfo singleton].venuefacilityarray);
    });
    return shared;
}
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.facility_name = [decoder decodeObjectForKey:kfacility_nameKey];
        self.unit = [decoder decodeObjectForKey:kunitKey];
        self.quantity = [decoder decodeObjectForKey:kquantityKey];
        self.facility_id = [decoder decodeObjectForKey:kfacility_idKey];
        self.price = [decoder decodeObjectForKey:kpriceKey];
        self.comments = [decoder decodeObjectForKey:kcommentsKey];
        self.price_per_unit = [decoder decodeObjectForKey:kprice_per_unitKey];
        self.userquantity = [decoder decodeObjectForKey:kuserquantityKey ];
        self.facility_id_no = [decoder decodeObjectForKey:kfacility_id_noKey];
       
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:facility_name forKey:kfacility_nameKey];
    [encoder encodeObject:_unit forKey:kunitKey];
    [encoder encodeObject:_quantity forKey:kquantityKey];
    [encoder encodeObject:_facility_id forKey:kfacility_idKey];
    [encoder encodeObject:_price forKey:kpriceKey];
    [encoder encodeObject:_comments forKey:kcommentsKey];
    [encoder encodeObject:_price_per_unit forKey:kprice_per_unitKey];
    [encoder encodeObject:_userquantity forKey:kuserquantityKey];
    [encoder encodeObject:_facility_id_no forKey:kfacility_id_noKey];
    
   }
@end
