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
    self.textView.text = self.note.note;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end