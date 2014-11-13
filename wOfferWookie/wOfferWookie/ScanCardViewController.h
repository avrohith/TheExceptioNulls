//
//  ScanCardViewController.h
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/8/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol ScanCardDelegate <NSObject>

-(void) barcodeActionReceived: (NSString *) barcodeValue;

@end

@interface ScanCardViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, weak) id <ScanCardDelegate> scanCardDelegate;

@end
