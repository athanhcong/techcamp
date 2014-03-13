//
//  TCTalkDetailViewController.h
//  TechCamp
//
//  Created by KONG on 13/3/14.
//  Copyright (c) 2014 TechCamp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TCTalk.h"

@interface TCTalkDetailViewController : UIViewController

@property (nonatomic, strong) TCTalk *talk;

@property (nonatomic, strong) IBOutlet UIWebView *webView;

@end
