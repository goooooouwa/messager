//
//  NoteTableViewCell.h
//  my note
//
//  Created by Greg Xu on 11/24/15.
//  Copyright © 2015 Greg Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *previewLabel;

@end
