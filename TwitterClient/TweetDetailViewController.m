//
//  TweetDetailViewController.m
//  TwitterClient
//
//  Created by JRamos on 2/6/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "TweetDetailViewController.h"

@interface TweetDetailViewController ()

@end

@implementation TweetDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated
{
    self.currentTweetText.text = [self.currentTweet objectForKey:@"text"];
    self.currentTweetAuthor.text = [self.currentTweet objectForKey:@"from_user"];
    self.date.text = [self.currentTweet objectForKey:@"created_at"];
    NSString *url = [self.currentTweet objectForKey:@"profile_image_url"];
    
    

    self.tweetImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addTweetToFavorites:(UIBarButtonItem *)sender {
    // Retrieve the NSUserDefaults dictionary
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Retrieve a mutable copy of the array of favorite tweets or create  one if it doesn't exists
    NSMutableArray *favoriteTweets = [[defaults arrayForKey:@"FavoriteTweets"] mutableCopy];
    if (!favoriteTweets)
        favoriteTweets = [NSMutableArray array];
    
    // Create a shorter current tweet object in a simple NSDictionary
    NSDictionary *abridgedTweet = @{@"Text" : [self.currentTweet objectForKey:@"text"],
    @"User" : [self.currentTweet objectForKey:@"from_user"],
    @"DateString" : [self.currentTweet objectForKey:@"created_at"]};
    
    // Add the current tweet to our favorite tweets array
    [favoriteTweets addObject:abridgedTweet];
    
    // Reset the FavoritesTweet array
    [defaults setObject:favoriteTweets forKey:@"FavoriteTweets"];
    [defaults synchronize];
    
    // Log it out for debugging
    NSLog(@"Defaults:%@",[defaults dictionaryRepresentation]);
}
@end
