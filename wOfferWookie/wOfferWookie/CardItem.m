//
//  CardItem.m
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/12/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import "CardItem.h"
@import CoreData;

@interface CardItem ()



@end

@implementation CardItem

@dynamic opco;
@dynamic cardValue;
@dynamic cardImage;

-(void) awakeFromInsert
{
    [super awakeFromInsert];
    NSLog(@"Woke up from insert");
}

@end
