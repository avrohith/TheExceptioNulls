//
//  RetailerDetailViewController.m
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/9/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import "RetailerDetailViewController.h"
#import "OffersViewController.h"
#import "CardViewController.h"

@interface RetailerDetailViewController ()

@end

@implementation RetailerDetailViewController

-(instancetype) initWithCardItem:(CardItem *)cardItem
{
    self = [super init];
    if (self) {
        
        self.cardItem = cardItem;
        CardViewController *cardViewController = [[CardViewController alloc] init];
        cardViewController.cardItem = self.cardItem;
        OffersViewController *offersViewController = [[OffersViewController alloc] init];
        
        self.viewControllers = @[cardViewController, offersViewController];
    }
    
    return self;
}

-(instancetype) init
{
    @throw [[NSException alloc] initWithName:@"call initWithCardItem:(CardItem *) cardItem" reason:@"" userInfo:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
