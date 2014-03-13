//
//  TCTalkDetailViewController.m
//  TechCamp
//
//  Created by KONG on 13/3/14.
//  Copyright (c) 2014 TechCamp. All rights reserved.
//

#import "TCTalkDetailViewController.h"
#import "UIImage+ColorTransformation.h"

@interface TCTalkDetailViewController ()

@end

@implementation TCTalkDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setToolbarHidden:NO animated:YES];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSString *htmlString = [self htmlStringForTalk:_talk];
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
    
    UIColor *tintColor = self.navigationController.navigationBar.barTintColor;
    
    
    UIButton *voteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    
    if (_talk.voted) {
        [voteButton setTitle:@"Voted" forState:UIControlStateNormal];
        voteButton.enabled = NO;
    } else {
        [voteButton setTitle:@"Vote" forState:UIControlStateNormal];
    }
    
    [voteButton setImage:[[UIImage imageNamed:@"vote_active"] imageWithTint:tintColor] forState:UIControlStateNormal];
    [voteButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [voteButton setTitleColor:tintColor forState:UIControlStateNormal];
    
    UIBarButtonItem *voteButtonItem = [[UIBarButtonItem alloc] initWithCustomView:voteButton];
    
    
    UIButton *favButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    
    if (_talk.voted) {
        [favButton setTitle:@"Favorited" forState:UIControlStateNormal];
        favButton.enabled = NO;
    } else {
        [favButton setTitle:@"Favorite" forState:UIControlStateNormal];
    }
    
    [favButton setImage:[[UIImage imageNamed:@"saved_talks_icon_active"] imageWithTint:tintColor] forState:UIControlStateNormal];
    [favButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [favButton setTitleColor:tintColor forState:UIControlStateNormal];
    
    UIBarButtonItem *favButtonItem = [[UIBarButtonItem alloc] initWithCustomView:favButton];

    
    
    self.toolbarItems = @[voteButtonItem,
                          [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                          favButtonItem];
    
    self.title = _talk.speakerName;
}


- (NSString *)htmlStringForTalk:(TCTalk *)talk {
    NSString *htmlString = [NSString stringWithFormat:
                            @"<h2 class='title' style='font-family:HelveticaNeue-CondensedBold;'><font color='#FF3B30'>%@</font></h2>\
                            <p class='name'><font color='gray'><b>%@</b></font></p>\
                            <hr style = 'background-color:#FF3B30; border-width:0; color:#FF3B30; height:1px; lineheight:0;'/>\
                            <p class='desciption'><font color='#505050' style='line-height:2em;'>%@</font></p>",
                            
                            talk.title, talk.speakerName,talk.talkDescription];
    
    
    htmlString = [NSString stringWithFormat:@"<body style='font-size:16px;font-family:HelveticaNeue;'>%@</body>", htmlString];
    
    return htmlString;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
