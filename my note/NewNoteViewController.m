//
//  NewNoteViewController.m
//  my note
//
//  Created by Greg Xu on 2/25/14.
//  Copyright (c) 2014 Greg Xu. All rights reserved.
//

#import "NewNoteViewController.h"

@interface NewNoteViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation NewNoteViewController

- (void)viewDidDisappear:(BOOL)animated
{
    [self.noteCreationDelegate noteDidChange:self.note];
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
    self.textView.delegate = self;
    self.textView.text = @"";
    [self.textView becomeFirstResponder];
	// Do any additional setup after loading the view.
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.note.content = textView.text;
    [self.noteCreationDelegate noteShouldChange:self.note];
    NSLog(@"text:%@ -> note:%@", textView.text, self.note.content);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
