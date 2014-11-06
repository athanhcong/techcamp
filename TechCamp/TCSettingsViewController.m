//
//  TCSettingsViewController.m
//  TechCamp
//
//  Created by KONG on 13/3/14.
//  Copyright (c) 2014 TechCamp. All rights reserved.
//

#import "TCSettingsViewController.h"
#import <SVWebViewController/SVWebViewController.h>


static NSString *const scheduleLink = @"https://docs.google.com/spreadsheet/ccc?key=0ApUi9j7RVQB_dDViUTR2dF9QQkFEaFgzM3VoWlU0T3c#gid=0";

//static NSString *const scheduleLink = @"https://docs.google.com/spreadsheet/pub?key=0ApUi9j7RVQB_dG9QbWdTd2d0d3lWb1JsUUk4SU9qZUE&output=html";

static NSString *const webLink = @"http://techcamp.vn/";

static NSString *const youtubeLink = @"http://www.youtube.com/playlist?list=PLUUDeNs_EpClPwK-PiTtsoN2Z-drkmoSV";

static NSString *const facebookLink = @"https://www.facebook.com/techcampsaigon";

static NSString *const facebookAppLink = @"fb://profile/161773950698676";




static NSString *const contactEmail = @"barcamp@barcampsaigon.com";

@interface TCSettingsViewController () <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@end

@implementation TCSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SVWebViewController *webViewController = [[SVWebViewController alloc] initWithAddress:scheduleLink];
        
        webViewController.title = @"Loading schedule...";
        [self.navigationController pushViewController:webViewController animated:YES];
        
//        self.navigationController.toolbarHidden = YES;

    } else if (indexPath.section == 1) {
        
        NSString *link = nil;
        switch (indexPath.row) {
            case 1:
                link = youtubeLink;
                break;
            case 2: {
                BOOL isInstalled = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://"]];
                
                if (isInstalled) {
                    NSURL *urlApp = [NSURL URLWithString:facebookAppLink];
                    [[UIApplication sharedApplication] openURL:urlApp];
                } else {
                    link = facebookLink;
                }
                
            } break;
            default:
                link = webLink;
                break;
        }
        
        if (link) {
            SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:link];
            
            webViewController.barsTintColor = [[UINavigationBar appearance] tintColor];
            [self presentViewController:webViewController animated:YES completion:NULL];
        }
    } else if (indexPath.section == 2) {
        [self sendMail:@"Feedback for Techcamp 2014" message:nil to:@[contactEmail]];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */



- (void)sendMail:(NSString *)subject message:(NSString *)body to:(NSArray *)recipients {
    if ([MFMailComposeViewController canSendMail] == NO) {
        return;
    }
    
    MFMailComposeViewController *messageInstance = [[MFMailComposeViewController alloc] init];
    
    [messageInstance setSubject:subject];
    [messageInstance setToRecipients:recipients];
    [messageInstance setMessageBody:body isHTML:NO];
    messageInstance.mailComposeDelegate = self;
 
    
    messageInstance.navigationBar.tintColor = [[UINavigationBar appearance] tintColor];
    [self presentViewController:messageInstance animated:YES completion:NULL];
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [controller dismissViewControllerAnimated:YES completion:NULL];

}


@end
