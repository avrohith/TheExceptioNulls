//
//  AppResources.h
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/9/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppResources : NSObject

+(instancetype) appResources;

-(NSArray *) getRetailerNamesArray;
-(NSArray *) getRetailerImagesArray;
-(NSArray *) getRetailerOpcosArray;
-(BOOL) saveChanges;
-(void) addCardWithOpco:(NSString *) opco AndCardValue:(NSString *) cardValue;
-(NSArray *) getCards;
-(NSString *) getRetailerImageNameForOpco: (NSString *) opcoValue;
-(NSString *) getRetailerNameForOpco: (NSString *) opcoValue;
-(UIColor *) getRetailerColorFromOpco:(NSString *) opcoValue;

@end
