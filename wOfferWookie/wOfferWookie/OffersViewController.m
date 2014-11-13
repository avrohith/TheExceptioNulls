//
//  OffersViewController.m
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/9/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import "OffersViewController.h"
#import "OfferCollectionCell.h"
#import "AppResources.h"

@interface OffersViewController ()

@property (nonatomic) NSString *cellReuseIdentifier;

@end

@implementation OffersViewController

-(instancetype) init
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UICollectionViewFlowLayout *uiCollectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    uiCollectionViewFlowLayout.itemSize = CGSizeMake(screenRect.size.width - 40, 150);
    uiCollectionViewFlowLayout.minimumLineSpacing = 20;
    [uiCollectionViewFlowLayout setSectionInset:UIEdgeInsetsMake(80, 15, 15, 15)];
    [uiCollectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self = [super initWithCollectionViewLayout:uiCollectionViewFlowLayout];
    
    if (self) {
        
        self.cellReuseIdentifier = @"offersCollectionCell";
        
        UITabBarItem *tabBarItem = self.tabBarItem;
        tabBarItem.title = @"OFFERS";
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *uiNib = [UINib nibWithNibName:@"OfferCollectionCell" bundle:nil];
    [self.collectionView registerNib:uiNib forCellWithReuseIdentifier:self.cellReuseIdentifier];
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:239.0/255.0f green:239.0/255.0f blue:239.0/255.0f alpha:1]];
    //[self.collectionView setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectioView

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OfferCollectionCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellReuseIdentifier forIndexPath:indexPath];
    
    collectionCell.offerImage.image = [UIImage imageNamed:[[[AppResources appResources] retailerImagesArray] objectAtIndex:indexPath.row]];
    //collectionCell.retailerName.text = [[[AppResources appResources] retailerNamesArray] objectAtIndex:indexPath.row];
    
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
