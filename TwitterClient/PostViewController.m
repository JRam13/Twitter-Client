//
//  PostViewController.m
//  TwitterClient
//
//  Created by JRamos on 2/6/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "PostViewController.h"
#import <Social/Social.h>

@interface PostViewController ()

@end

@implementation PostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendTweet:(id)sender {
    SLComposeViewController *tweeter=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [tweeter setInitialText:@"Post a tweet!"];
    [self presentViewController:tweeter animated:YES completion:nil];
}
@end
