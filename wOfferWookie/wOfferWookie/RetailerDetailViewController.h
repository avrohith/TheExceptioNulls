//
//  RetailerDetailViewController.h
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/9/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardItem.h"

@interface RetailerDetailViewController : UITabBarController

@property (nonatomic) CardItem *cardItem;

-(instancetype) initWithCardItem: (CardItem *) cardItem;

@end
