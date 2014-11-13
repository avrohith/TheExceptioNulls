//
//  ScanViewController.m
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/12/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController ()
@property (weak, nonatomic) IBOutlet UIButton *scanningErrorButton;
@property (weak, nonatomic) IBOutlet UIImageView *scanLinesImage;

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) NSArray *avMetaDataObjects;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation ScanViewController

-(instancetype) init
{
    self = [super self];
    
    if (self) {
        self.captureSession = nil;
        self.avMetaDataObjects = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code,
                                   AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBeepSound];
}

-(void) viewDidAppear:(BOOL)animated
{
    [self startScanning];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [self stopScanning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) startScanning
{
    
    NSError *error = nil;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!deviceInput) {
        // If any error occurs, simply log the description of it and don't continue any more.
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
    
    self.captureSession = [[AVCaptureSession alloc] init];
    [self.captureSession addInput:deviceInput];
    
    AVCaptureMetadataOutput *captureMetaDataOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:captureMetaDataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetaDataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    captureMetaDataOutput.metadataObjectTypes = self.avMetaDataObjects;
    
    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.videoPreviewLayer setFrame:self.view.frame];
    [self.view.layer insertSublayer:self.videoPreviewLayer atIndex:0];
    [self.captureSession startRunning];
}

-(void) stopScanning
{
    if (self.captureSession) {
        [_captureSession stopRunning];
        _captureSession = nil;
    }
    
    if (self.videoPreviewLayer) {
        [self.videoPreviewLayer removeFromSuperlayer];
    }
    
}

-(void) captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeUPCECode]) {
            if (_audioPlayer) {
                [_audioPlayer play];
            }
            [self.navigationController popViewControllerAnimated:NO];
            [self.scanViewDelegate barcodeActionReceived:[metadataObj stringValue]];
        }
    }
}

-(void)loadBeepSound{
    // Get the path to the beep.mp3 file and convert it to a NSURL object.
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    
    NSError *error;
    
    // Initialize the audio player object using the NSURL object previously set.
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        // If the audio player cannot be initialized then log a message.
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        // If the audio player was successfully initialized then load it in memory.
        [_audioPlayer prepareToPlay];
    }
}

- (IBAction) cannotScanBarcode:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
    [self.scanViewDelegate barcodeActionReceived:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
