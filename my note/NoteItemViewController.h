//
//  NoteItemViewController.h
//  my note
//
//  Created by Greg Xu on 2/24/14.
//  Copyright (c) 2014 Greg Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "noteCreationDelegate.h"

@interface NoteItemViewController : UIViewController <UITextViewDelegate>

@property Note *note;
@property id <noteCreationDelegate> noteCreationDelegate;

@end

