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

-(NSMutableArray *)tasks {
    if (!_tasks) {
        _tasks = [[NSMutableArray alloc] init];
    }
    return _tasks;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    
//    TaskData *task = [[TaskData alloc] init];
//    TaskData *task2 = [[TaskData alloc] init];
//    
//    task.title = @"Task Uno";
//    task.desc = @"Description for task 1";
//    task.date = [TaskData getDateString:[NSDate date]];
//    task.completed = YES;
//    
//    task2.title = @"Task Dos";
//    task2.desc = @"Description for task 2";
//    task2.date = [TaskData getDateString:[[NSDate date] dateByAddingTimeInterval:60*60*24*15]];
//    task2.completed = NO;
//    
//    self.tasks = [[NSMutableArray alloc] initWithObjects:task, task2, nil];
    
    NSArray *tasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY];
    
    for (NSDictionary *dict in tasksAsPropertyLists) {
        [self.tasks addObject:[self taskObjectForDictionary:dict]];
    }
    
//    
//    [[NSUserDefaults standardUserDefaults] setObject:[[NSArray alloc] init] forKey:TASK_OBJECTS_KEY];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//
//    TaskData *tempTask = self.tasks[2];
//    tempTask.date = [TaskData getDateString:[NSDate date]];
//    self.tasks[2] = tempTask;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]]) {
        AddTaskViewController *addTaskViewController = segue.destinationViewController;
        addTaskViewController.delegate = self;
    }
    
    if ([segue.destinationViewController isKindOfClass:[ViewDetailViewController class]]) {
        if ([sender isKindOfClass:[NSIndexPath class]]) {
            ViewDetailViewController *viewDetailViewController = segue.destinationViewController;
            NSIndexPath *path = sender;
            viewDetailViewController.taskToView = [self.tasks objectAtIndex:path.row];
            viewDetailViewController.indexRow = path.row;
            viewDetailViewController.delegate = self;
        }
    }
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
    if (task.completed) {
        cell.backgroundColor = [UIColor greenColor];
    }
    else if ([NSDate date] > [TaskData getDate:task.date]) {
        cell.backgroundColor = [UIColor redColor];
    }
    else {
        cell.backgroundColor = [UIColor blueColor];
    }
    
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tasks count];;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"toViewDetailViewController" sender:indexPath];
}

- (IBAction)addTaskBarButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toAddTaskViewController" sender:nil];
}

#pragma mark - AddTaskViewControllerDelegate

-(void)didAddTask:(TaskData *)task {
    [self.tasks addObject:task];
    
    NSMutableArray *tasksAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    
    if (!tasksAsPropertyLists) {
        tasksAsPropertyLists = [[NSMutableArray alloc] init];
    }
    
    [tasksAsPropertyLists addObject:[self taskObjectAsAPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
}

-(void)didCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ViewDetailViewControllerDelegate

-(void)didEditTask:(TaskData *)task atRow:(long)row {
    self.tasks[row] = task;
    
    NSMutableArray *tasksAsPropertyLists = [[NSMutableArray alloc] init];
    
    for (TaskData *tempTask in self.tasks) {
        [tasksAsPropertyLists addObject:[self taskObjectAsAPropertyList:tempTask]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];    
    
    [self.tableView reloadData];
}

#pragma mark - Helper Methods

- (NSDictionary *)taskObjectAsAPropertyList:(TaskData *)taskObject {
    return @{
             TASK_TITLE         :   taskObject.title,
             TASK_DESCRIPTION   :   taskObject.desc,
             TASK_DATE          :   taskObject.date,
             TASK_COMPLETION    :   @(taskObject.completed)
            };
}

- (TaskData *)taskObjectForDictionary:(NSDictionary *)dict {
    return [[TaskData alloc] initWithData:dict];
}

- (void)updateStandardUserDefaults:(TaskData *)task {
    
}

@end
