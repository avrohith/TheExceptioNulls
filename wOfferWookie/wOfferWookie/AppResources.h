//
//  AppResources.h
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/9/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppResources : NSObject

+(instancetype) appResources;

-(NSArray *) retailerNamesArray;
-(NSArray *) retailerImagesArray;
-(NSArray *) retailerOpcosArray;
-(BOOL) saveChanges;
-(void) addCardWithOpco:(NSString *) opco AndCardValue:(NSString *) cardValue;

@end
