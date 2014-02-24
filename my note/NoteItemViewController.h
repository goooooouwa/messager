//
//  NoteItemViewController.h
//  my note
//
//  Created by Greg Xu on 2/24/14.
//  Copyright (c) 2014 Greg Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

// protocol declaration
@protocol myDelegate

@optional
-(void)selectedValueIs:(NSIndexPath *)value;

@end


@interface NoteItemViewController : UIViewController

// set it as the property
@property (nonatomic, assign) id<myDelegate> selectedValueDelegate;
@property Note *note;

@end

