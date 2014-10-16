//
//  AbstractEntityGateway.m
//  GotoCamera
//
//  Created by Alex Kurochkin on 9/14/11.
//  Copyright 2011 One Click Development, Inc. All rights reserved.
//

#import "AbstractEntityGateway.h"
#import "CoreDataGateway+Additions.h"



@implementation AbstractEntityGateway

- (NSArray *)entities {
	return [CoreDataGateway objectsEntityForName:[self entityName]];
}

- (id)createEntity {
	id newEntity = [NSEntityDescription insertNewObjectForEntityForName:[self entityName] 
												 inManagedObjectContext:[CoreDataGateway managedObjectContext]];
	//[self applyDefaultSettingsForEntity:newEntity];	
	
	return newEntity;
}

- (void)deleteEntity:(id)entity {
	if ( [entity isKindOfClass:[NSManagedObject class]] ) {
		[[CoreDataGateway managedObjectContext] deleteObject:entity];
	} else {
		//DLog(@"Error. Can't delete entity: %@. It must be kind of NSManagedObject.", entity);
	}
}

- (void)applyDefaultSettingsForEntity:(id)entity {
	
}


@end

