//
//  OICategoryGateway.m
//  OrganizeIt
//
//  Created by lk1195 on 10/21/14.
//  Copyright (c) 2014 lk1195. All rights reserved.
//

#import "OICategoryGateway.h"
#import "Category.h"
#import "CoreDataGateway+Additions.h"

@implementation OICategoryGateway

static OICategoryGateway *sharedInstance = nil;

// Returns shared core data gateway for entities with this name.
+ (id <EntityGateway>)sharedGateway {
	if (sharedInstance == nil) {
		sharedInstance = [[self alloc] init];
	}
	return sharedInstance;
}

- (NSString *)entityName {
    return @"Category";
}

- (void) deleteCategory: (NSManagedObject *)cat {
    [CoreDataGateway deleteObjectEntity:cat];
}

- (NSMutableArray *) categoriesById: (NSNumber *) catId {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parentId == %d",
                                [catId integerValue]];
    NSArray *categories = [CoreDataGateway objectsEntityForName:[self entityName]
                                                   forPredicate:predicate
                                             forSortDescriptors:nil
                                                          limit:0];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:categories ];
    return arr;
}

- (Category *)categoryWithTitle:(NSString *)title  {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@", title];
    NSArray *categories = [CoreDataGateway objectsEntityForName:[self entityName] forPredicate:predicate forSortDescriptors:nil limit:0];
    
    return [categories lastObject];
}

@end
