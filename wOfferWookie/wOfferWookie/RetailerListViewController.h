//
//  RetailerListViewController.h
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/8/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanViewController.h"
#import "CardItem.h"

@protocol RetailerListDelegate <NSObject>

@required
-(void) retailerSelectedWithCardItem:(CardItem *) cardItem;

@end

@interface RetailerListViewController : UITableViewController <ScanViewDelegate>

@property (nonatomic, weak) id <RetailerListDelegate> retailerListDelegate;

@end
