//
//  NoteListViewController.h
//  my note
//
//  Created by Greg Xu on 2/24/14.
//  Copyright (c) 2014 Greg Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteItemViewController.h"
#import "noteCreationDelegate.h"

@interface NoteListViewController : UITableViewController <noteCreationDelegate>

@property (strong, nonatomic)NSManagedObjectContext *context;

@end
