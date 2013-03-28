//
//  CustomTweetViewCell.h
//  TwitterClient
//
//  Created by JRamos on 2/6/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTweetViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *tweet;
@property (weak, nonatomic) IBOutlet UILabel *user;

@end
