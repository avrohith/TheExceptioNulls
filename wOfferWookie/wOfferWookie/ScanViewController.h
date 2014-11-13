//
//  ScanViewController.h
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/12/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol ScanViewDelegate <NSObject>

-(void) barcodeActionReceived: (NSString *) barcodeValue;

@end

@interface ScanViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, weak) id <ScanViewDelegate> scanViewDelegate;

@end
