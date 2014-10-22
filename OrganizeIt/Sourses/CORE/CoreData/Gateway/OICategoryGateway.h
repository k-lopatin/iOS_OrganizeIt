//
//  OICategoryGateway.h
//  OrganizeIt
//
//  Created by lk1195 on 10/21/14.
//  Copyright (c) 2014 lk1195. All rights reserved.
//

#import "AbstractEntityGateway.h"
#import "EntityGateway.h"

@class Category;

@interface OICategoryGateway : AbstractEntityGateway < EntityGateway >

- (void) deleteCategory: (NSManagedObject *)cat;
- (NSMutableArray *) categoriesById: (NSNumber *) catId; 

@end
