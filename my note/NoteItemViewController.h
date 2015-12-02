//
//  NoteItemViewController.h
//  my note
//
//  Created by Greg Xu on 2/24/14.
//  Copyright (c) 2014 Greg Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Note;

@interface NoteItemViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property Note *note;

@end

