//
//  Singleton.h
//  ManageMyFunction
//
//  Created by Anveshak on 8/24/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject

@property (nonatomic, retain) NSMutableArray *venuefacilityarray;
+(Singleton*)singleton;

@property (nonatomic,retain) NSString *facility_id,*unit,*quantity,*price,*comments,*facility_id_no,*facility_name,*userquantity,*price_per_unit;
@end
