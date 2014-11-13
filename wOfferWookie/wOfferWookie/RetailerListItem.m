//
//  RetailerListItem.m
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/9/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import "RetailerListItem.h"

@implementation RetailerListItem

-(instancetype) initWithRetailerName:(NSString *) retailerName
{
    self = [super init];
    if (self) {
        self.retailerName = retailerName;
    }
    
    return self;
}

@end
