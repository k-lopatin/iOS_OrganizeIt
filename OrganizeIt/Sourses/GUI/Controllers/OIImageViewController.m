//
//  OIImageViewController.m
//  OrganizeIt
//
//  Created by lk1195 on 10/21/14.
//  Copyright (c) 2014 lk1195. All rights reserved.
//

#import "OIImageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

typedef void (^ALAssetsLibraryAssetForURLResultBlock)(ALAsset *asset);
typedef void (^ALAssetsLibraryAccessFailureBlock)(NSError *error);

@interface OIImageViewController ()

@end

@implementation OIImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
      
    self.noteImageView.image = [UIImage imageWithContentsOfFile:self.imageUrl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
