//
//  ViewController.h
//  Task List
//
//  Created by Tom Pullen on 04/11/2014.
//  Copyright (c) 2014 Tom Pullen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskData.h"
#import "AddTaskViewController.h"
#import "ViewDetailViewController.h"

@interface ViewController : UIViewController <AddTaskViewControllerDeleate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *tasks;

- (IBAction)addTaskBarButtonPressed:(UIBarButtonItem *)sender;

@end

