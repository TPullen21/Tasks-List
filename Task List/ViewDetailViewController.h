//
//  ViewDetailViewController.h
//  Task List
//
//  Created by Tom Pullen on 04/11/2014.
//  Copyright (c) 2014 Tom Pullen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *completedLabel;

- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender;


@end
