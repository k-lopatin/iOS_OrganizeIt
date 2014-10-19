//
//  OIItemViewController.h
//  OrganizeIt
//
//  Created by lk1195 on 10/19/14.
//  Copyright (c) 2014 lk1195. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OIItemViewController : UIViewController

@property (weak, nonatomic) NSNumber *categoryId;

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
