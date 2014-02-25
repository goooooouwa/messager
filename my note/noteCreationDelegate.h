//
//  DataReceiver.h
//  my note
//
//  Created by Greg Xu on 2/25/14.
//  Copyright (c) 2014 Greg Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol noteCreationDelegate <NSObject>

- (void)noteCreated:(Note *)note;

@end
