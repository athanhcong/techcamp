//
//  TCNotificationCell.h
//  TechCamp
//
//  Created by KONG on 13/3/14.
//  Copyright (c) 2014 TechCamp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCNotification.h"
@interface TCNotificationCell : UITableViewCell


@property (nonatomic, strong) TCNotification *notification;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel, *descriptionLabel, *createdAtLabel;


- (void)updateViewWithNotification:(TCNotification *)notification;

@end
