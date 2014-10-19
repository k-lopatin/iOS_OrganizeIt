//
//  OIItemViewController.m
//  OrganizeIt
//
//  Created by lk1195 on 10/19/14.
//  Copyright (c) 2014 lk1195. All rights reserved.
//

#import "OIItemViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface OIItemViewController ()

@end

@implementation OIItemViewController

@synthesize categoryId;

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
    
    self.noteTextView.layer.borderWidth = 1.0f;
    self.noteTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    
    if(self.editMode == YES){
        self.navigationController.title = @"Edit";
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
        NSPredicate *predicateForCurCatID = [NSPredicate predicateWithFormat:@"id == %d", [self.itemId integerValue]];
        [fetchRequest setPredicate:predicateForCurCatID];
        NSArray *curItemTempArray = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
        self.noteTextView.text = [[curItemTempArray objectAtIndex:0]
                                  valueForKey:@"content"];
        self.categoryId = [[curItemTempArray objectAtIndex:0]
                           valueForKey:@"content"];
    }
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
    
    if(self.editMode == YES){
        [self updateItem];
    } else {
        [self saveNewItem];
    }
    
        [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) saveNewItem {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:context];
    
    //Create unique id for new element
    NSNumber *itemId = [[NSNumber alloc] initWithInt:[NSDate timeIntervalSinceReferenceDate] ];
    [newItem setValue:itemId forKey:@"id"];
    
    [newItem setValue:self.categoryId forKey:@"categoryId"];
    
    [newItem setValue:[self.noteTextView text] forKey:@"content"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

}

-(void) updateItem {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSPredicate *predicateForCurCatID = [NSPredicate predicateWithFormat:@"id == %d", [self.itemId integerValue]];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
    [fetchRequest setPredicate:predicateForCurCatID];
    NSManagedObject *item = [[context executeFetchRequest:fetchRequest error:nil] lastObject];
    
    [item setValue:[self.noteTextView text] forKey:@"content"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
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
