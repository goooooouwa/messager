//
//  NewNoteViewController.h
//  my note
//
//  Created by Greg Xu on 2/25/14.
//  Copyright (c) 2014 Greg Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "DataReceiver.h"

@interface NewNoteViewController : UIViewController

@property Note *note;
@property (weak) id <DataReceiver> dataReceiver;

@end