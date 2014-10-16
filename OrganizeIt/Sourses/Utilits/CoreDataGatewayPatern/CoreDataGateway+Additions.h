//
//  GCCoreDataGateway+GCAdditions.h
//  GotoCamera
//
//  Created by Alex Kurochkin on 9/14/11.
//  Copyright 2011 One Click Development, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataGateway.h"
#import <CoreData/CoreData.h>

@interface CoreDataGateway (Additions)

+ (id)objectForEntityName:(NSString *)entityName predicate:(NSPredicate *)predicate;
+ (NSArray *)objectsEntityForName:(NSString *)entityName;
+ (NSArray *)objectsEntityForName:(NSString *)entityName forPredicate:(NSPredicate *)predicate;
+ (NSArray *)objectsEntityForName:(NSString *)entityName forPredicate:(NSPredicate *)predicate forSortDescriptors:(NSArray *)sortDescriptors	limit:(NSInteger)limit;

+ (id)createNewObjectForEntityForName:(NSString *)entityName;

+ (NSEntityDescription *)descriptionOfEntityForName:(NSString *)entityName;


+ (NSArray *)fetchRequestForEntityForName:(NSString *)entityName 
				   expressionDescriptions:(NSArray *)descriptions
							   resultType:(NSFetchRequestResultType)result 
									error:(NSError **)error;


@end
