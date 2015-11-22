//
//  NewNoteViewController.m
//  my note
//
//  Created by Greg Xu on 2/25/14.
//  Copyright (c) 2014 Greg Xu. All rights reserved.
//

#import "NewNoteViewController.h"
#import "AppDelegate.h"

@interface NewNoteViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic)NSManagedObjectContext *context;
@property Note *note;

@end

@implementation NewNoteViewController

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.note.content length] == 0) {
        [self.context deleteObject:self.note];
        self.note = nil;
    }
    
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"%@",[error localizedDescription]);
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    // create a new managed object and assign to self.note, if self.note has been deleted from managed object context but the view will appear. Need a new note to show.
    if (self.note == nil) {
        self.note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:self.context];
    }
}

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
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.context = delegate.managedObjectContext;
    
    self.note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:self.context];
    
    self.textView.delegate = self;
    self.textView.text = self.note.content;
    [self.textView becomeFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.note.content = textView.text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
