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
@property (weak, nonatomic) IBOutlet UIImageView *userCardPhotoImage;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

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


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.retailerHeaderUIView setBackgroundColor:[[AppResources appResources] getRetailerColorFromOpco:self.cardItem.opco]];
    self.retailerHeaderLogo.image = [UIImage imageNamed:[[AppResources appResources] getRetailerImageNameForOpco:self.cardItem.opco]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
