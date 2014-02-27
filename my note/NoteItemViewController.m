//
//  NoteItemViewController.m
//  my note
//
//  Created by Greg Xu on 2/24/14.
//  Copyright (c) 2014 Greg Xu. All rights reserved.
//

#import "NoteItemViewController.h"

@interface NoteItemViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation NoteItemViewController

/*
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"note changed:%@", self.note.content);
    [self.noteCreationDelegate noteShouldChange:self.note];
}
*/

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
	// Do any additional setup after loading the view.
    self.textView.delegate = self;
    //[self.note addObserver:self forKeyPath:@"content" options:NSKeyValueObservingOptionNew context:NULL];
    self.textView.text = self.note.content;
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
