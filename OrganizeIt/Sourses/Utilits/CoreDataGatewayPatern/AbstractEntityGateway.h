//
//  VNAbstractEntityGateway.h
//  GotoCamera
//
//  Created by Alex Kurochkin on 9/14/11.
//  Copyright 2011 One Click Development, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AbstractEntityGateway : NSObject {

}

- (NSArray *)entities;
- (id)createEntity;
- (void)deleteEntity:(id)entity;
- (void)applyDefaultSettingsForEntity:(id)entity;

@end

@interface AbstractEntityGateway ( Abstract )

- (NSString *)entityName;

@end

