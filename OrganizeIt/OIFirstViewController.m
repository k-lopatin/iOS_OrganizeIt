//
//  OIFirstViewController.m
//  OrganizeIt
//
//  Created by lk1195 on 10/16/14.
//  Copyright (c) 2014 lk1195. All rights reserved.
//

#import "OIFirstViewController.h"

@interface OIFirstViewController ()

@end

@implementation OIFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.noteTextView.text = @"test";
    [self.noteTextView setText:@"test"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated. self.
}

/*- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}*/

@end
