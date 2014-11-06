
//
//  TCTalkViewController.m
//  TechCamp
//
//  Created by KONG on 13/3/14.
//  Copyright (c) 2014 TechCamp. All rights reserved.
//

#import "TCTalksViewController.h"
#import "TCTalkCell.h"
#import <UIAlertView+Blocks/UIAlertView+Blocks.h>

#import "TCTalkDetailViewController.h"

#import "NSObject+Random.h"
typedef enum {
  SortByCreatedAt,
  SortByVote,
  SortByFavorite,
  SortByRandom
} SortType;

@interface TCTalksViewController () <UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *searchResults;

@property (nonatomic, assign) SortType sortType;

@end

@implementation TCTalksViewController

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
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshTalks) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = self.refreshControl;
    
    
//    self.searchDisplayController.searchBar.barTintColor = [[UINavigationBar appearance] barTintColor];
//    self.searchDisplayController.searchBar.tintColor = [[UINavigationBar appearance] tintColor];
//    self.searchDisplayController.searchBar.translucent = NO;
    
    [self loadCachedTalks];
    [self refreshTalks];
    
    if (IS_OS_7_OR_LATER) {
        [self setNeedsStatusBarAppearanceUpdate];
        
        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"techcamp_logo"]];
        [tempImageView setFrame:self.tableView.frame];
        [tempImageView setContentMode:UIViewContentModeScaleAspectFit];
        self.tableView.backgroundView = tempImageView;

    }
    
    

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sort" style:UIBarButtonItemStyleBordered target:self action:@selector(showSortOption)];
}


- (void)refreshTalks {
    [[TCClient defaultClient] getTalksWithBlock:^(NSArray *objects, NSError *error) {
        if (objects && !error) {
            [self loadCachedTalks];
            [self.refreshControl endRefreshing];
        } else {
            [UIAlertView showWithTitle:@"Oops" message:@"Refresh Talks got error! Please try again later." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:NULL];
        }
    }];
}


- (void)loadCachedTalks {
    self.talks = [[TCClient defaultClient] cachedTalks];
    
    [self sortBy:self.sortType];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_searchResults count];
    }
    
    return _talks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TCTalkCell";
    TCTalkCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    TCTalk *talk = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        talk = [_searchResults objectAtIndex:indexPath.row];
    } else {
        talk = [_talks objectAtIndex:indexPath.row];
    }
    
    [cell updateViewWithTalk:talk];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [tableView deselectRowAtIndexPath:tableView.indexPathForSelectedRow animated:YES];
    
    
    TCTalk *selectedTalk = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        selectedTalk = [_searchResults objectAtIndex:indexPath.row];
        
    } else {
        selectedTalk = [_talks objectAtIndex:indexPath.row];
    }
    
    
    TCTalkDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TCTalkDetailViewController"];
    detailVC.talk = selectedTalk;

    [self.navigationController pushViewController:detailVC animated:YES];
    
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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    if ([segue.identifier isEqualToString:@"TalksPushToDetail"]) {
        
        
        
//        NSIndexPath *selectedIndexPath = []
        
//        detailVC.talk =
        
    }
}





#pragma mark Search

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"title contains[c] %@", searchText];
    
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"speakerName contains[c] %@", searchText];
    
    NSPredicate *fullPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[titlePredicate, namePredicate]];

    
    if (_searchResults == nil) {
        self.searchResults = [NSMutableArray array];
    } else {
        [self.searchResults removeAllObjects];
    }
    
    [_searchResults addObjectsFromArray:
     [_talks filteredArrayUsingPredicate:fullPredicate]];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)showSortOption {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Sort by Submit Date", @"Sort by Vote", @"Sort by Favorite", @"Randomize", nil];
    
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}


- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        [self sortBy:buttonIndex];
        [self.tableView reloadData];

    }
}


- (void)sortBy:(SortType)sortType {
    
    self.sortType = sortType;
    
    switch (sortType) {
        case SortByCreatedAt: {
            self.talks = [_talks sortedArrayUsingComparator:^NSComparisonResult(TCTalk *obj1, TCTalk *obj2) {
                return [obj2.createdAt compare:obj1.createdAt];
            }];
        } break;
        case SortByVote: {
            self.talks = [_talks sortedArrayUsingComparator:^NSComparisonResult(TCTalk *obj1, TCTalk *obj2) {
                return [obj2.voteCount compare:obj1.voteCount];
            }];
        } break;
        case SortByFavorite: {
            self.talks = [_talks sortedArrayUsingComparator:^NSComparisonResult(TCTalk *obj1, TCTalk *obj2) {
                return [obj2.favCount compare:obj1.favCount];
            }];
        } break;
        case SortByRandom: {
            self.talks = [NSObject shuffleArray:_talks];
        } break;
        default:
            break;
    }
    
}
@end
