//
//  ViewController.m
//  Task List
//
//  Created by Tom Pullen on 04/11/2014.
//  Copyright (c) 2014 Tom Pullen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    TaskData *task = [[TaskData alloc] init];
    TaskData *task2 = [[TaskData alloc] init];
    
    task.title = @"Task Uno";
    task.desc = @"Description for task 1";
    task.date = [TaskData getDateString:[NSDate date]];
    task.completed = YES;
    
    task2.title = @"Task Dos";
    task2.desc = @"Description for task 2";
    task2.date = [TaskData getDateString:[[NSDate date] dateByAddingTimeInterval:60*60*24*15]];
    task2.completed = NO;
    
    self.tasks = [[NSMutableArray alloc] initWithObjects:task, task2, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"DataCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    TaskData *task = [self.tasks objectAtIndex:indexPath.row];
    
    cell.textLabel.text = task.title;
    cell.detailTextLabel.text = task.desc;
    cell.backgroundColor = task.completed ? [UIColor greenColor] : [UIColor redColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (IBAction)addTaskBarButtonPressed:(UIBarButtonItem *)sender {
}
@end
