//
//  CardItem.h
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/12/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>


@interface CardItem : NSManagedObject

@property (nonatomic, strong) NSString * opco;
@property (nonatomic, strong) NSString * cardValue;
@property (nonatomic, strong) UIImage *cardImage;

@end
