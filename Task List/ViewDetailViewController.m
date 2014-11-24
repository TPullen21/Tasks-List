//
//  ViewDetailViewController.m
//  Task List
//
//  Created by Tom Pullen on 04/11/2014.
//  Copyright (c) 2014 Tom Pullen. All rights reserved.
//

#import "ViewDetailViewController.h"

@interface ViewDetailViewController ()

@end

@implementation ViewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.taskToView.title;
    self.descriptionLabel.text = self.taskToView.desc;
    self.dateLabel.text = self.taskToView.date;
    self.completedLabel.text = self.taskToView.completed ? @"Completed" : @"Incomplete";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[EditDetailViewController class]]) {
        EditDetailViewController *editDetailVC = segue.destinationViewController;
        editDetailVC.delegate = self;
        editDetailVC.task = self.taskToView;
    }
}

- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toEditDetailViewController" sender:nil];
}

-(void)didEditTask:(TaskData *)task {
    self.taskToView = task;
    [self viewDidLoad];
    [self.delegate didEditTask:task atRow:self.indexRow];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
