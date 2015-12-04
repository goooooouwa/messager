//
//  NoteItemViewController.m
//  my note
//
//  Created by Greg Xu on 2/24/14.
//  Copyright (c) 2014 Greg Xu. All rights reserved.
//

#import "NoteItemViewController.h"
#import "AppDelegate.h"
#import "Note.h"

@interface NoteItemViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic)NSManagedObjectContext *context;

@end

@implementation NoteItemViewController

/*
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"note changed:%@", self.note.content);
    [self.noteCreationDelegate noteShouldChange:self.note];
}
*/

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (([self.note.title length] == 0) && ([self.note.content length] == 0)) {
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
    [super viewWillAppear:animated];
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

    self.titleTextField.delegate = self;
    self.titleTextField.text = self.note.title;
    
    self.textView.delegate = self;
    self.textView.text = self.note.content;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.note.title = textField.text;
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
