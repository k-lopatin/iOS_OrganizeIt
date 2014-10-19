//
//  OICategoryViewController.m
//  OrganizeIt
//
//  Created by lk1195 on 10/19/14.
//  Copyright (c) 2014 lk1195. All rights reserved.
//

#import "OICategoryViewController.h"

@interface OICategoryViewController ()

@end

@implementation OICategoryViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:context];
    
    //Create unique id for new element
    NSNumber *itemId = [[NSNumber alloc] initWithInt:[NSDate timeIntervalSinceReferenceDate] ];
    [newItem setValue:itemId forKey:@"id"];
    
    [newItem setValue:self.categoryId forKey:@"parentId"];
    
    [newItem setValue:[self.categoryTextView text] forKey:@"name"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
