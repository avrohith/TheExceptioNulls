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

-(NSArray *) retailerImagesArray
{
    return self.retailerImages;
}

-(NSArray *) retailerNamesArray
{
    return self.retailerNames;
}

-(NSArray *) retailerOpcosArray
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
    if (!self.cardsArray) {
        
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

-(NSArray *) getUserCards
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

@end
