//
//  TCNotificationCell.m
//  TechCamp
//
//  Created by KONG on 13/3/14.
//  Copyright (c) 2014 TechCamp. All rights reserved.
//

#import "TCNotificationCell.h"

#import <FormatterKit/TTTTimeIntervalFormatter.h>

static TTTTimeIntervalFormatter *_timeFormatter;
@implementation TCNotificationCell


- (TTTTimeIntervalFormatter *)timeFormatter {
    if (_timeFormatter == nil) {
        _timeFormatter = [[TTTTimeIntervalFormatter alloc] init];
    }
    return _timeFormatter;
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)updateViewWithNotification:(TCNotification *)notification {
    self.notification = notification;
    self.titleLabel.text = notification.subject;
    self.descriptionLabel.text = notification.message;
    
    self.createdAtLabel.text = [self.timeFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:notification.createdAt];
}
@end
