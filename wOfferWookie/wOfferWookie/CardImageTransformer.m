//
//  CardImageTransformer.m
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/12/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardImageTransformer.h"

@implementation CardImageTransformer

+ (Class) transformedValueClass
{
    return [NSData class];
}

-(id) transformedValue:(id)value
{
    if (!value) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }

    return UIImagePNGRepresentation(value);
}

-(id) reverseTransformedValue:(id)value
{
    return [UIImage imageWithData:value];
}

@end
