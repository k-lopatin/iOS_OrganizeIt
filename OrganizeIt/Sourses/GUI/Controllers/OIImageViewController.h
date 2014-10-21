//
//  OIImageViewController.h
//  OrganizeIt
//
//  Created by lk1195 on 10/21/14.
//  Copyright (c) 2014 lk1195. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OIImageViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *noteImageView;

@property (strong, nonatomic) NSString *imageUrl;

- (IBAction)backClick:(id)sender;

@end
