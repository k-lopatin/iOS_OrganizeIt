//
//  GCCoreDataGateway.h
//  GotoCamera
//
//  Created by Alex Kurochkin on 9/14/11.
//  Copyright 2011 One Click Development, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CoreDataSettingsDataSource <NSObject>

@required

- (NSString *)pathOffCoreDataStore;
- (NSString *)coredataStoreType;

@end

@interface CoreDataGateway : NSObject {
@private	
	NSPersistentStoreCoordinator*	_persistentStoreCoordinator;
    NSManagedObjectModel*			_managedObjectModel;
    NSManagedObjectContext*			_managedObjectContext;
    id < CoreDataSettingsDataSource > __weak _coreDataGatewayDataSource;
	
//	GCMutex *lock;
}

@property (nonatomic, weak, readwrite) id < CoreDataSettingsDataSource > coreDataGatewayDataSource;

//- (GCMutex *)lockInstance;

+ (instancetype)sharedCoreDataGateway;

+ (NSManagedObjectContext *)managedObjectContext;
- (BOOL)commitAndSave;
- (void)clearOldDataBase;

@end
