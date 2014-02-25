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
@protocol pushDataBackToListViewController

-(void)itemHasChanged:(id)item;

@end


@interface NoteItemViewController : UIViewController

// set it as the property
@property (nonatomic, assign) id<pushDataBackToListViewController> listViewController;
@property Note *note;

@end

