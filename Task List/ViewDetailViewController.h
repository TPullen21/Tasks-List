//
//  ViewDetailViewController.h
//  Task List
//
//  Created by Tom Pullen on 04/11/2014.
//  Copyright (c) 2014 Tom Pullen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskData.h"
#import "EditDetailViewController.h"

@protocol ViewDetailViewControllerDelegate <NSObject>

- (void)didEditTask:(TaskData *)task atRow:(long)row;

@end

@interface ViewDetailViewController : UIViewController <EditDetailViewControllerDelegate>

@property (weak, nonatomic) id <ViewDetailViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *completedLabel;
@property (strong, nonatomic) TaskData *taskToView;
@property (nonatomic) long indexRow;


- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender;


@end
