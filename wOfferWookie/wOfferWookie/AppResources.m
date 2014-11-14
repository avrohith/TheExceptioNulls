//
//  AppResources.m
//  wOfferWookie
//
//  Created by Rohith Avatapally on 11/9/14.
//  Copyright (c) 2014 Rohith Avatapally. All rights reserved.
//

#import "AppResources.h"
#import "CardItem.h"
@import CoreData;

@interface AppResources ()

@property (nonatomic) NSArray *retailerNames;
@property (nonatomic) NSArray *retailerImages;
@property (nonatomic) NSArray *retailerOpco;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *model;
@property (nonatomic, strong) NSPersistentStoreCoordinator *storeCoordinator;
@property (nonatomic) NSMutableArray *cardsArray;

-(NSString *) itemArchivePath;

@end

@implementation AppResources

+(instancetype) appResources
{
    static AppResources *instance = nil;
    
    if (!instance)
    {
        instance = [[self alloc] initPrivate];
    }
    
    return instance;
}

-(instancetype) init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [AppResources getAppResources]" userInfo:nil];
    return nil;
}

-(instancetype) initPrivate
{
    self = [super init];
    
    if (self) {
        
        self.model = [NSManagedObjectModel mergedModelFromBundles:nil];
        self.storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
        
        NSString *path = self.itemArchivePath;
        NSURL *url = [NSURL fileURLWithPath:path];
        NSError *error = nil;
        
        if (![self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error])
        {
            @throw [NSException exceptionWithName:@"OpenFailure" reason:[error localizedDescription] userInfo:nil];
        }
        
        self.managedObjectContext = [[NSManagedObjectContext alloc] init];
        self.managedObjectContext.persistentStoreCoordinator = self.storeCoordinator;
        [self loadAllCards];
        
        self.retailerNames = [NSArray arrayWithObjects:
                              @"A&P",
                              @"Family Express",
                              @"Giant",
                              @"Giant Carlisle",
                              @"Harris Teeter",
                              @"Kroger",
                              @"Marsh",
                              @"Martin's",
                              @"Safeway",
                              @"ShopRite",
                              @"Stop & Shop",
                              @"Walmart",
                              @"Weis", nil];
        
        self.retailerOpco = [NSArray arrayWithObjects:
                             @"ap",
                             @"fe",
                             @"gl",
                             @"gc",
                             @"ht",
                             @"kg",
                             @"ms",
                             @"mr",
                             @"sw",
                             @"sr",
                             @"ss",
                             @"wm",
                             @"ws",
                             nil];
        
        self.retailerImages = [NSArray arrayWithObjects:
                               @"i_aandp",
                               @"i_familyexpress",
                               @"i_gl",
                               @"i_gc",
                               @"i_harristeeter",
                               @"i_kroger",
                               @"i_marsh",
                               @"i_martins",
                               @"i_safeway",
                               @"i_shoprite",
                               @"i_stopandshop",
                               @"i_walmart",
                               @"i_weis",
                               nil];
        
    }
    
    return self;
}

-(NSArray *) getRetailerImagesArray
{
    return self.retailerImages;
}

-(NSArray *) getRetailerNamesArray
{
    return self.retailerNames;
}

-(NSArray *) getRetailerOpcosArray
{
    return self.retailerOpco;
}

-(NSString *) itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

-(void) loadAllCards
{
    if (!self.cardsArray)
    {
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"CardItem" inManagedObjectContext:self.managedObjectContext];

        if (e) {
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            request.entity = e;
            
            NSError *error;
            NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
            
            if (!result) {
                [NSException raise:@"Fetch Failed" format:@"Reason:%@",[error localizedDescription]];
            }
            
            self.cardsArray = [[NSMutableArray alloc] initWithArray:result];
        }
    }else
    {
        self.cardsArray = [[NSMutableArray alloc] init];
    }
}

-(BOOL) saveChanges
{
    NSError *error;
    BOOL isSuccessful = [self.managedObjectContext save:&error];
    if (!isSuccessful) {
        NSLog(@"Error saving %@",[error localizedDescription]);
    }
    
    return isSuccessful;
}

-(NSArray *) getCards
{
    return self.cardsArray;
}

-(void) addCardWithOpco:(NSString *)opco AndCardValue:(NSString *)cardValue
{
    CardItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"CardItem" inManagedObjectContext:self.managedObjectContext];
    item.opco = opco;
    item.cardValue = cardValue;
    [self.cardsArray addObject:item];
}

-(void) removeItem:(CardItem *) item
{
    [self.managedObjectContext deleteObject:item];
    [self.cardsArray removeObjectIdenticalTo:item];
}

-(NSString *) getRetailerImageNameForOpco: (NSString *) opcoValue
{
    if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:0]]) {
        return [self.retailerImages objectAtIndex:0];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:1]]){
        return [self.retailerImages objectAtIndex:1];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:2]]){
        return [self.retailerImages objectAtIndex:2];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:3]]){
        return [self.retailerImages objectAtIndex:3];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:4]]){
        return [self.retailerImages objectAtIndex:4];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:5]]){
        return [self.retailerImages objectAtIndex:5];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:6]]){
        return [self.retailerImages objectAtIndex:6];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:7]]){
        return [self.retailerImages objectAtIndex:7];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:8]]){
        return [self.retailerImages objectAtIndex:8];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:9]]){
        return [self.retailerImages objectAtIndex:9];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:10]]){
        return [self.retailerImages objectAtIndex:10];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:11]]){
        return [self.retailerImages objectAtIndex:11];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:12]]){
        return [self.retailerImages objectAtIndex:12];
    }
    
    return nil;
}

-(NSString *) getRetailerNameForOpco:(NSString *)opcoValue
{
    if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:0]]) {
        return [self.retailerNames objectAtIndex:0];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:1]]){
        return [self.retailerNames objectAtIndex:1];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:2]]){
        return [self.retailerNames objectAtIndex:2];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:3]]){
        return [self.retailerNames objectAtIndex:3];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:4]]){
        return [self.retailerNames objectAtIndex:4];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:5]]){
        return [self.retailerNames objectAtIndex:5];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:6]]){
        return [self.retailerNames objectAtIndex:6];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:7]]){
        return [self.retailerNames objectAtIndex:7];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:8]]){
        return [self.retailerNames objectAtIndex:8];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:9]]){
        return [self.retailerNames objectAtIndex:9];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:10]]){
        return [self.retailerNames objectAtIndex:10];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:11]]){
        return [self.retailerNames objectAtIndex:11];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:12]]){
        return [self.retailerNames objectAtIndex:12];
    }
    
    return nil;
}

-(UIColor *) getRetailerColorFromOpco:(NSString *) opcoValue
{
    if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:0]]) {
        return [UIColor colorWithRed:237.0/255.0 green:27.0/255.0 blue:36.0/255.0 alpha:1];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:1]]){
        return [UIColor colorWithRed:52.0/255.0 green:182.0/255.0 blue:214.0/255.0 alpha:1];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:2]]){
        return [UIColor colorWithRed:112.0/255.0 green:32.0/255.0 blue:118.0/255.0 alpha:1];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:3]]){
        return [UIColor colorWithRed:238.0/255.0 green:58.0/255.0 blue:67.0/255.0 alpha:1];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:4]]){
        return [UIColor colorWithRed:27.0/255.0 green:134.0/255.0 blue:68.0/255.0 alpha:1];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:5]]){
        return [UIColor colorWithRed:0/255.0 green:102.0/255.0 blue:176.0/255.0 alpha:1];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:6]]){
        return [UIColor colorWithRed:227.0/255.0 green:26.0/255.0 blue:48.0/255.0 alpha:1];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:7]]){
        return [UIColor colorWithRed:178.0/255.0 green:50.0/255.0 blue:57.0/255.0 alpha:1];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:8]]){
        return [UIColor colorWithRed:224.0/255.0 green:61.0/255.0 blue:63.0/255.0 alpha:1];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:9]]){
        return [UIColor colorWithRed:237.0/255.0 green:24.0/255.0 blue:46.0/255.0 alpha:1];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:10]]){
        return [UIColor colorWithRed:112.0/255.0 green:32.0/255.0 blue:118.0/255.0 alpha:1];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:11]]){
        return [UIColor colorWithRed:0/255.0 green:126.0/255.0 blue:203.0/255.0 alpha:1];
    }else if ([opcoValue isEqualToString:[self.retailerOpco objectAtIndex:12]]){
        return [UIColor colorWithRed:255.0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    }
    
    return nil;
}


@end
