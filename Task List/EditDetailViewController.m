//
//  EditDetailViewController.m
//  Task List
//
//  Created by Tom Pullen on 04/11/2014.
//  Copyright (c) 2014 Tom Pullen. All rights reserved.
//

#import "EditDetailViewController.h"

@interface EditDetailViewController ()

@end

@implementation EditDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textField.text = self.task.title;
    self.textView.text = self.task.desc;
    self.datePicker.date = [TaskData getDate:self.task.date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveBarButtonPressed:(UIBarButtonItem *)sender {
    
    TaskData *tempTask = [[TaskData alloc] init];
    tempTask.title = self.textField.text;
    tempTask.desc = self.textView.text;
    tempTask.date = [TaskData getDateString:self.datePicker.date];
    
    [self.delegate didEditTask:tempTask];
}

- (IBAction)saveButtonPressed:(UIButton *)sender {
    
    TaskData *tempTask = [[TaskData alloc] init];
    tempTask.title = self.textField.text;
    tempTask.desc = self.textView.text;
    tempTask.date = [TaskData getDateString:self.datePicker.date];
    
    [self.delegate didEditTask:tempTask];
}
@end
