//
//  RetailerListItem.h
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/9/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RetailerListItem : NSObject

@property (nonatomic) NSString *retailerName;

-(instancetype) initWithRetailerName:(NSString *) retailerName;

@end
