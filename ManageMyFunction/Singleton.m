//
//  Singleton.m
//  ManageMyFunction
//
//  Created by Anveshak on 8/24/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

@synthesize venuefacilityarray;

+(Singleton *)singleton {
    static dispatch_once_t pred;
    static Singleton *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[Singleton alloc] init];
        shared.venuefacilityarray = [[NSMutableArray alloc]init];
        NSLog(@"%@",[Singleton singleton].venuefacilityarray);
    });
    return shared;
}
//+ (id)sharedManager {
//    static Singleton *sharedMyManager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedMyManager = [[self alloc] init];
//    });
//    return sharedMyManager;
//}
//or use without GCD

//+ (id)sharedManager {
//    static Singleton *sharedMyManager = nil;
//    @synchronized(self) {
//        if (sharedMyManager == nil)
//            sharedMyManager = [[self alloc] init];
//    }
//    return sharedMyManager;
//}
- (id)init {
    if (self = [super init]) {
       // facility = [[NSString alloc] initWithString:@"Default Property Value"];
        
     
    }
    return self;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


@end
