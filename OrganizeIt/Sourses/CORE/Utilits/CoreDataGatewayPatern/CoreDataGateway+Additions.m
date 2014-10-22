//
//  GCCoreDataGateway+GCAdditions.m
//  GotoCamera
//
//  Created by Alex Kurochkin on 9/14/11.
//  Copyright 2011 One Click Development, Inc. All rights reserved.
//

#import "CoreDataGateway+Additions.h"


@implementation CoreDataGateway (Additions)

+ (id)objectForEntityName:(NSString*)entityName predicate:(NSPredicate*)predicate {
	NSArray* results = [self objectsEntityForName:entityName forPredicate:predicate];
	return [results count] == 0 ? nil : [results objectAtIndex:0];
}

+ (NSArray *)objectsEntityForName:(NSString *)entityName {
	return [self objectsEntityForName:entityName forPredicate:nil];
}

+ (NSArray *)objectsEntityForName:(NSString *)entityName forPredicate:(NSPredicate *)predicate {
	return [self objectsEntityForName:entityName forPredicate:predicate forSortDescriptors:nil limit:0];
}

+ (NSArray *)objectsEntityForName:(NSString *)entityName
					 forPredicate:(NSPredicate *)predicate
			   forSortDescriptors:(NSArray*)sortDescriptors
							limit:(NSInteger)limit {
	NSError *error = nil;
	NSEntityDescription *entity = [self descriptionOfEntityForName:entityName];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entity];
	[request setPredicate:predicate];
	if(nil != sortDescriptors)
	{
		[request setSortDescriptors:sortDescriptors];
	}
	[request setFetchLimit:limit];
	
	NSArray *array = [[self managedObjectContext] executeFetchRequest:request error:&error];
    if (error != nil) {
        //DLog(@"Error with request %@", error);
    }
	
	return array;
}

+ (id)createNewObjectForEntityForName:(NSString *)entityName {

	
	NSManagedObject *entity = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self managedObjectContext]];
	return entity;
}

+ (NSEntityDescription *)descriptionOfEntityForName:(NSString *)entityName {
	return [NSEntityDescription entityForName:entityName 
					   inManagedObjectContext:[self managedObjectContext]];
}

+ (NSArray *)fetchRequestForEntityForName:(NSString *)entityName 
                   expressionDescriptions:(NSArray *)descriptions
                               resultType:(NSFetchRequestResultType)result 
                                    error:(NSError **)error {
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];	
	[request setEntity:[CoreDataGateway descriptionOfEntityForName:entityName]];	
	
	[request setResultType:NSDictionaryResultType];	
	
	[request setPropertiesToFetch:descriptions];		
	
	NSArray *objects = [[self managedObjectContext] executeFetchRequest:request error:error];
	

	
	return objects;
}
+ (void) deleteObjectEntity: (NSManagedObject *) obj {
    [[self managedObjectContext] deleteObject:obj];
}

@end
