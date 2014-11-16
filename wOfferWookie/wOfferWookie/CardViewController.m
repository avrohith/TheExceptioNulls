//
//  CardViewController.m
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/9/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import "CardViewController.h"
#import "AppResources.h"

@interface CardViewController ()
@property (weak, nonatomic) IBOutlet UIView *retailerHeaderUIView;
@property (weak, nonatomic) IBOutlet UIImageView *retailerHeaderLogo;
@property (weak, nonatomic) IBOutlet UIImageView *userCardBardcodeImage;
@property (weak, nonatomic) IBOutlet UILabel *userCardValue;
@property (weak, nonatomic) IBOutlet UIButton *userImageButton;

@property (nonatomic) UIImagePickerController *imagePicker;

@end

@implementation CardViewController

-(instancetype) init
{
    self = [super init];
    if (self) {
        UITabBarItem *tabBarItem = self.tabBarItem;
        tabBarItem.title = @"CARD";
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.retailerHeaderUIView setBackgroundColor:[[AppResources appResources] getRetailerColorFromOpco:self.cardItem.opco]];
    self.retailerHeaderLogo.image = [UIImage imageNamed:[[AppResources appResources] getRetailerImageNameForOpco:self.cardItem.opco]];
    self.userCardValue.text = self.cardItem.cardValue;
    
    if (!self.cardItem.cardImage) {
        [self.userImageButton setBackgroundImage:[UIImage imageNamed:@"i_camera"] forState:UIControlStateNormal];
        [self.userImageButton setContentMode:UIViewContentModeCenter];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)imageButtonOnTap:(id)sender
{
    if (!self.imagePicker) {
        self.imagePicker = [[UIImagePickerController alloc] init];
    }
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else
    {
        [self showImagePickerAlerView];
    }
    
}

#pragma mark - imagepicker

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.userImageButton setBackgroundImage:image forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:self.imagePicker completion:nil];
    self.userImageButton.imageView.image = nil;
}

#pragma mark - alertview

-(void) showImagePickerAlerView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Chose One" message:nil delegate:nil cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Take a Picture", @"Choose from library", nil];
    [alertView setDelegate:self];
    [alertView show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button index %ld",(long)buttonIndex);
    switch (buttonIndex) {
        case 1:
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.imagePicker.delegate = self;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
            break;
        case 2:
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.imagePicker.delegate = self;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
            break;
        default:
            break;
    }
}

-(void) alertViewCancel:(UIAlertView *)alertView
{
    
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
