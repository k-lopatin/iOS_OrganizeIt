//
//  OIFirstViewController.h
//  OrganizeIt
//
//  Created by lk1195 on 10/16/14.
//  Copyright (c) 2014 lk1195. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OINewNoteViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) IBOutlet UIButton *addPhotoButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *topNavBar;

@end
