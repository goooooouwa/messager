//
//  NewNoteViewController.m
//  my note
//
//  Created by Greg Xu on 2/25/14.
//  Copyright (c) 2014 Greg Xu. All rights reserved.
//

#import "NewNoteViewController.h"
#import "AppDelegate.h"
#import "Note.h"

@interface NewNoteViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic)NSManagedObjectContext *context;
@property Note *note;

@end

@implementation NewNoteViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.note.content length] == 0) {
        [self.context deleteObject:self.note];
        self.note = nil;
    }
    
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"%@",[error localizedDescription]);
    }
    
    //post
    // 1
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/posts.json"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [config setHTTPAdditionalHeaders:@{@"Content-Type": @"application/json"}];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 3
    NSDictionary *payloadDictionary = @{@"post":@{@"title":@"http://www.baidu.com"}};

    NSData *payloadJSON = [NSJSONSerialization dataWithJSONObject:payloadDictionary
                                                   options:kNilOptions error:&error];
    
    if (!error) {
        // 4
        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                                   fromData:payloadJSON completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                                                                       // Handle response here
                                                                       NSLog(@"response: %@", response);
                                                                   }];
        
        // 5
        [uploadTask resume];
    }
    
    //emit message
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
    
    self.note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:self.context];
    
    self.titleTextField.delegate = self;
    self.titleTextField.text = self.note.title;
    
    self.textView.delegate = self;
    self.textView.text = self.note.content;
    [self.textView becomeFirstResponder];
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
