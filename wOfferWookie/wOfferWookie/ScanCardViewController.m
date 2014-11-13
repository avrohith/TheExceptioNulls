//
//  ScanCardViewController.m
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/8/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import "ScanCardViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanCardViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *scanLinesImageView;
@property (weak, nonatomic) IBOutlet UIButton *noBarcodeButton;
@property (nonatomic) BOOL isDoneReading;

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) NSArray *avMetaDataObjects;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIView *previewView;

@end

@implementation ScanCardViewController

-(instancetype) init
{
    self = [super init];
    if (self) {
        
//        self.isDoneReading = NO;
//        self.captureSession = nil;
//        
//        self.avMetaDataObjects = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code,
//                                   AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self loadBeepSound];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{
    //[self startScanning];
}

-(void) viewDidDisappear:(BOOL)animated
{
    //[self stopScanning];
}

-(void) initializeScanner
{
    
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
    [self.previewView.layer insertSublayer:self.videoPreviewLayer atIndex:0];
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
            [self.scanCardDelegate barcodeActionReceived:[metadataObj stringValue]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
