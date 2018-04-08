//
//  VenueInfoArray.m
//  ManageMyFunction
//
//  Created by Anveshak on 9/6/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "VenueInfoArray.h"

@implementation VenueInfoArray
+(NSMutableArray*) venuefacilityarray
{
    static NSMutableArray* theValue = nil;
    @synchronized([VenueInfoArray class]) // in a single threaded app you can omit the sync block
    {
        if (theValue == nil)
        {
            theValue = [[NSMutableArray alloc] init];
        }
    }
    return theValue;
}

@end
