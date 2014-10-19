//
//  OICategoryViewController.h
//  OrganizeIt
//
//  Created by lk1195 on 10/19/14.
//  Copyright (c) 2014 lk1195. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OICategoryViewController : UIViewController

@property (weak, nonatomic) NSNumber *categoryId;
//@property (strong, nonatomic) NSNumber *itemId;
//@property (nonatomic, assign) BOOL editMode;

@property (weak, nonatomic) IBOutlet UITextField *categoryTextView;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
