//
//  HomeViewController.m
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/8/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import "HomeViewController.h"
#import "RetailerListViewController.h"
#import "RetailerDetailViewController.h"
#import "AppResources.h"
#import "RetailerCollectionViewCell.h"

@interface HomeViewController ()

@property (nonatomic) NSString *cellReuseIdentifier;

@end

@implementation HomeViewController

-(instancetype) init
{
    UICollectionViewFlowLayout *uiCollectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    uiCollectionViewFlowLayout.itemSize = CGSizeMake(150, 150);
    uiCollectionViewFlowLayout.minimumLineSpacing = 30;
    [uiCollectionViewFlowLayout setSectionInset:UIEdgeInsetsMake(20, 20, 20, 20)];
    [uiCollectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self = [super initWithCollectionViewLayout:uiCollectionViewFlowLayout];
    
    if (self) {
        
        self.cellReuseIdentifier = @"RetailerCollectionViewCell";
        
        UINavigationItem *uiNavItem = self.navigationItem;
        uiNavItem.title = @"Home";
        
        UIBarButtonItem *addRetailer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewRetailer:)];
        uiNavItem.rightBarButtonItem = addRetailer;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *uiNib = [UINib nibWithNibName:@"RetailerCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:uiNib forCellWithReuseIdentifier:self.cellReuseIdentifier];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) addNewRetailer:(id)sender
{
    NSLog(@"add retailer selected");
    RetailerListViewController *retailerListViewController = [[RetailerListViewController alloc] init];
    retailerListViewController.retailerListDelegate = self;
    [self.navigationController pushViewController:retailerListViewController animated:YES];
}

-(void) retailerSelected
{
    // Reload data here
    RetailerDetailViewController *retailerDetailViewcontroller = [[RetailerDetailViewController alloc] init];
    [self.navigationController pushViewController:retailerDetailViewcontroller animated:YES];
}

#pragma mark - CollectioView 

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RetailerCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellReuseIdentifier forIndexPath:indexPath];
    
    collectionCell.retailerImage.image = [UIImage imageNamed:[[[AppResources appResources] retailerImagesArray] objectAtIndex:indexPath.row]];
    collectionCell.retailerName.text = [[[AppResources appResources] retailerNamesArray] objectAtIndex:indexPath.row];
    
    return collectionCell;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [AppResources appResources].retailerNamesArray.count;
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RetailerDetailViewController *retailerDetailViewController = [[RetailerDetailViewController alloc] init];
    [self.navigationController pushViewController:retailerDetailViewController animated:YES];
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
