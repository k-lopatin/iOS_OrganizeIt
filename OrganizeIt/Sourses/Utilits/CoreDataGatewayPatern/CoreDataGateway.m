//
//  CoreDataGateway.m
//  GotoCamera
//
//  Created by Alex Kurochkin on 9/14/11.
//  Copyright 2011 One Click Development, Inc. All rights reserved.
//

#import "CoreDataGateway.h"
#import <CoreData/CoreData.h>
//#import "SettingsManager.h"

@interface CoreDataGateway ()

@property (nonatomic, strong, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong, readwrite) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readwrite) NSManagedObjectContext *managedObjectContext;

@end



@implementation CoreDataGateway

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize coreDataGatewayDataSource = _coreDataGatewayDataSource;

#pragma mark -
#pragma mark Initialization

static CoreDataGateway *sharedInstance = nil;

+ (instancetype)sharedCoreDataGateway {
	if (sharedInstance == nil) {
		sharedInstance = [[self alloc] init];
	}
	return sharedInstance;
}

- (void)awakeFromNib {
	sharedInstance = self;
}

- (id)init {
	self = [super init];
	if (self != nil) {
	//	lock = [[GCMutex alloc] init];
	}
	return self;
}

- (void)dealloc {
    self.coreDataGatewayDataSource = nil;
	//[lock release];

}


- (NSManagedObjectModel *)managedObjectModel {	
    if (_managedObjectModel == nil) {
		self.managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil]; 
	}       
    return _managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.  This 
 implementation will create and return a coordinator, having added the 
 store for the application to it.  (The directory for the store is created, 
 if necessary.)
 */
								   
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator == nil) {
		
		NSError *error = nil;
		NSManagedObjectModel* mom = [self managedObjectModel];
		if (!mom) {
			NSAssert(NO, @"Managed object model is nil");
			//DLog(@"%@:%s No model to generate a store from", [self class], _cmd);
			return nil;
		}
		
		NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: mom];
		
		self.persistentStoreCoordinator = coordinator;
		
        
        if (self.coreDataGatewayDataSource &&
            [self.coreDataGatewayDataSource respondsToSelector:@selector(pathOffCoreDataStore)] &&
            [self.coreDataGatewayDataSource respondsToSelector:@selector(coredataStoreType)]) {
            
            NSURL *url = [NSURL fileURLWithPath:[self.coreDataGatewayDataSource pathOffCoreDataStore]];
            
            if (![_persistentStoreCoordinator addPersistentStoreWithType:[self.coreDataGatewayDataSource coredataStoreType]
                                                           configuration:nil
                                                                     URL:url
                                                                 options:nil
                                                                   error:&error]) {
                //			[[UIApplication sharedApplication] presentError:error];
                DLog(@"Error:%@", error);
                self.persistentStoreCoordinator = nil;
                return nil;
            }    
            
        }    	

    }
        
    return _persistentStoreCoordinator;
}



/**
 Returns the managed object context for the application (which is already
 bound to the persistent store coordinator for the application.) 
 */
- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) return _managedObjectContext;
	
    NSPersistentStoreCoordinator* coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        //NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        //[[UIApplication sharedApplication] presentError:error];
        //DLog(@"Error:%@", error);
        DLog(@"Error:");
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
	[_managedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
	
    return _managedObjectContext;
}


+ (NSManagedObjectContext *)managedObjectContext {
	return [[self sharedCoreDataGateway] managedObjectContext];
}

- (BOOL)commitAndSave {
	NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        if ([[error domain] isEqualToString:@"NSCocoaErrorDomain"]) {
            // ...check whether there's an NSDetailedErrors array            
            NSDictionary *userInfo = [error userInfo];
            DLog(@"User Info:%@", userInfo);
            if ([userInfo valueForKey:@"NSDetailedErrors"] != nil) {
                // ...and loop through the array, if so.
                NSArray *errors = [userInfo valueForKey:@"NSDetailedErrors"];
                for (NSError *anError in errors) {
                    NSDictionary *subUserInfo = [anError userInfo];
                    subUserInfo = [anError userInfo];
                    // Granted, this indents the NSValidation keys rather a lot
                    // ...but it's a small loss to keep the code more readable.
                    DLog( @"Core Data Save Error\n\n \
                         NSValidationErrorKey\n%@\n\n \
                         NSValidationErrorPredicate\n%@\n\n \
                         NSValidationErrorObject\n%@\n\n \
                         NSLocalizedDescription\n%@", 
                         [subUserInfo valueForKey:@"NSValidationErrorKey"], 
                         [subUserInfo valueForKey:@"NSValidationErrorPredicate"], 
                         [subUserInfo valueForKey:@"NSValidationErrorObject"], 
                         [subUserInfo valueForKey:@"NSLocalizedDescription"]);
                }
            }
            // If there was no NSDetailedErrors array, print values directly
            // from the top-level userInfo object. (Hint: all of these keys
            // will have null values when you've got multiple errors sitting
            // behind the NSDetailedErrors key.
            else {
				DLog(@"Core Data Save Error\n\n \
                     NSValidationErrorKey\n%@\n\n \
                     NSValidationErrorPredicate\n%@\n\n \
                     NSValidationErrorObject\n%@\n\n \
                     NSLocalizedDescription\n%@", 
                     [userInfo valueForKey:@"NSValidationErrorKey"], 
                     [userInfo valueForKey:@"NSValidationErrorPredicate"], 
                     [userInfo valueForKey:@"NSValidationErrorObject"], 
                     [userInfo valueForKey:@"NSLocalizedDescription"]);
				
            }
        } 
        // Handle mine--or 3rd party-generated--errors
        else {
            DLog(@"Custom Error: %@", [error localizedDescription]);
        }
        return NO;
    }
    return YES;
}

- (void)clearOldDataBase {
//    NSPersistentStore *store = ...;
//    NSError *error = nil;
  //  NSURL *storeURL = store.URL;
    //NSPersistentStoreCoordinator *storeCoordinator = ...;
//    [self.persistentStoreCoordinator removePersistentStore:store error:&error];
//    [[NSFileManager defaultManager] removeItemAtPath:storeURL.path error:&error];
    NSLog(@"buttonReset Pressed");
    
    //Erase the persistent store from coordinator and also file manager.
    NSPersistentStore *store = [self.persistentStoreCoordinator.persistentStores lastObject];
    NSError *error = nil;
    NSURL *storeURL = store.URL;
    [self.persistentStoreCoordinator removePersistentStore:store error:&error];
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
    
    
    NSLog(@"Data Reset");
    
    //Make new persistent store for future saves   (Taken From Above Answer)
    if (![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // do something with the error
    }

}

@end
