//
//  OIFirstViewController.m
//  OrganizeIt
//
//  Created by lk1195 on 10/16/14.
//  Copyright (c) 2014 lk1195. All rights reserved.
//

#import "OINewNoteViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface OINewNoteViewController ()

@end

@implementation OINewNoteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addButtonsToTopNav];
    [self setViewStyles];
    [self.noteTextView endEditing:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated. self.
}


#pragma mark save new note

- (void) saveNewNote: (id) sender {
    
}

#pragma mark view 

- (void) addButtonsToTopNav {
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                   target:self
                                   action:@selector(saveNewNote:)];
    self.topNavBar.rightBarButtonItem = saveButton;
}

- (void) setViewStyles {
    [[self.noteTextView layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.noteTextView layer] setBorderWidth:2.5];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
