//
//  EntityGateway.h
//  GotoCamera
//
//  Created by Alex Kurochkin on 9/14/11.
//  Copyright 2011 One Click Development, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol EntityGateway

@required

// Returns shared core data gateway for entities with this name.
+ (id<EntityGateway>)sharedGateway;

// Returns entity name
- (NSString *)entityName;

// Returns all exesting entities with this name.
- (NSArray *)entities;

// Create an empty entity with default values.
- (id)createEntity;

// Delete the "entity".
- (void)deleteEntity:(id)entity;

@optional


@end
