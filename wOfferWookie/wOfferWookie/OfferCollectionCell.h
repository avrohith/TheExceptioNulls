//
//  OfferCollectionCell.h
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/11/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *offerImage;
@property (weak, nonatomic) IBOutlet UILabel *offerTitle;
@property (weak, nonatomic) IBOutlet UILabel *offerDescription;
@property (weak, nonatomic) IBOutlet UILabel *offerExpiration;

@end
