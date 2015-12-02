//
//  Note.h
//  my note
//
//  Created by Greg Xu on 2/26/14.
//  Copyright (c) 2014 Greg Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * creationDate;

@end
