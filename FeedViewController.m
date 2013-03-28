//
//  FeedViewController.m
//  TwitterClient
//
//  Created by JRamos on 2/6/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "FeedViewController.h"
#import "TweetDetailViewController.h"

@interface FeedViewController ()
@property (strong, nonatomic) NSMutableArray *twitterFeed;

@end

@implementation FeedViewController

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
    
    // Refresh Controller
    UIRefreshControl *pullToRefresh = [[UIRefreshControl alloc] init];
    pullToRefresh.tintColor = [UIColor magentaColor];
    [pullToRefresh addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = pullToRefresh;
}


-(void)viewWillAppear:(BOOL)animated
{
    // Downloads the Twitter feed from search term 'apple'
    [self downloadTwitterFeed];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*******************************************************************************
 * @method          downloadTwitterFeed
 * @abstract        Download a JSON feed from the Twitter API using Grand Central Dispatch (GCD)
 * @description     Download feed, parse and update a table in UITableViewController.  Please
 *                  note that this is not a best practice for downloading data.
 ******************************************************************************/
- (void) downloadTwitterFeed
{
    // The search query term in "apple"
    NSURL *url=[NSURL URLWithString:@"http://search.twitter.com/search.json?q=apple"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        // Request the data from URL on new thread
        NSData *data = [NSData dataWithContentsOfURL:url];
        // Get back on the main thread to update the UI
        dispatch_async(dispatch_get_main_queue(),^{
            // Parse the returned JSON into NSDictionary
            NSError *error = nil;
            NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            // Log out the dictionary for debugging purposes
            NSLog(@"Json as NSDictionary: %@",results);
            // Get the "results" key from NSDictionary into an NSArray that will be read by the
            //  UITableView  dataSource
            // "twitterFeed" is a NSMutableArray @property of the view controller
            self.twitterFeed = [NSMutableArray arrayWithArray:[results objectForKey:@"results"]];
            
            // Reload the the UITableViewController's tableView
            [self.tableView reloadData];
            // Remove the UIRefreshControll spinner on the table
            [self.refreshControl endRefreshing];
        });
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.twitterFeed count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FeedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *tweet = [self.twitterFeed objectAtIndex:indexPath.row];
    cell.textLabel.text = [tweet objectForKey:@"text"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"@%@", [tweet objectForKey:@"from_user"]];
    
    return cell;
}

/*******************************************************************************
 * @method          prepareForSegue:
 * @abstract        Called before segue transition
 * @description
 ******************************************************************************/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Segue....");
    if ([[segue identifier] isEqualToString:@"segueTweetDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *tweet = [self.twitterFeed objectAtIndex:indexPath.row];
        TweetDetailViewController *tdvc = [segue destinationViewController];
        [tdvc setCurrentTweet:tweet];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - ACTIONS
-(void)refreshAction
{
    //Refresh Twitter API
    [self downloadTwitterFeed];
}

@end
