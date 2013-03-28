//
//  TweetDetailViewController.h
//  TwitterClient
//
//  Created by JRamos on 2/6/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *currentTweetAuthor;
@property (weak, nonatomic) IBOutlet UILabel *currentTweetText;
@property (strong, nonatomic) NSDictionary *currentTweet;
@property (weak, nonatomic) IBOutlet UIImageView *tweetImage;
@property (weak, nonatomic) IBOutlet UILabel *date;

- (IBAction)addTweetToFavorites:(UIBarButtonItem *)sender;

@end
