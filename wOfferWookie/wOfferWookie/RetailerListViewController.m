//
//  RetailerListViewController.m
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/8/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import "RetailerListViewController.h"
#import "ScanViewController.h"
#import "RetailerListItem.h"
#import "RetailerListCell.h"
#import "AppResources.h"

@interface RetailerListViewController ()

@property (nonatomic) NSString *cellReuseIdentifier;
@property (nonatomic) NSString *opcoValue;

@end

@implementation RetailerListViewController

-(instancetype) init
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        
        self.cellReuseIdentifier = @"RetailerListCell";
        
        UINavigationItem *uiNavigationItem = self.navigationItem;
        uiNavigationItem.title = @"Select Retailer";
        
        self.tableView.rowHeight = 100;
    }
    
    return self;
}

-(instancetype) initWithStyle:(UITableViewStyle) style
{
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *uiNib = [UINib nibWithNibName:@"RetailerListCell" bundle:nil];
    [self.tableView registerNib:uiNib forCellReuseIdentifier:self.cellReuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[AppResources appResources] getRetailerNamesArray].count;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScanViewController *scanViewController = [[ScanViewController alloc] init];
    scanViewController.scanViewDelegate = self;
    [self.navigationController pushViewController:scanViewController animated:YES];
    self.opcoValue = [[[AppResources appResources] getRetailerOpcosArray] objectAtIndex:indexPath.row];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RetailerListCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellReuseIdentifier forIndexPath:indexPath];
    
    cell.retailerName.text = [[[AppResources appResources] getRetailerNamesArray] objectAtIndex:indexPath.row];
    cell.retailerImage.image = [UIImage imageNamed:[[[AppResources appResources] getRetailerImagesArray] objectAtIndex:indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - callback

-(void) barcodeActionReceived:(NSString *)barcodeValue
{
    NSLog(@"barcode value - %@", barcodeValue);
    if (barcodeValue) {
        [[AppResources appResources] addCardWithOpco:self.opcoValue AndCardValue:barcodeValue];
    }else
    {
        [[AppResources appResources] addCardWithOpco:self.opcoValue AndCardValue:@""];
    }
    [self.navigationController popViewControllerAnimated:NO];
    [self.retailerListDelegate retailerSelectedWithCardItem:[[[AppResources appResources] getCards] lastObject]];
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
