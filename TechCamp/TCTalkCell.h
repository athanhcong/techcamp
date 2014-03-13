//
//  TCTalkCell.h
//  TechCamp
//
//  Created by KONG on 13/3/14.
//  Copyright (c) 2014 TechCamp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCTalk.h"
@interface TCTalkCell : UITableViewCell

@property (nonatomic, strong) TCTalk *talk;


@property (nonatomic, strong) IBOutlet UILabel *titleLabel, *speakerNameLabel;

@property (nonatomic, strong) IBOutlet UIButton *voteButton, *favoriteButton;
- (void)updateViewWithTalk:(TCTalk *)talk;

@end
