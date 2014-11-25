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
    
    NSArray *tasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY];
    
    for (NSDictionary *dict in tasksAsPropertyLists) {
        [self.tasks addObject:[self taskObjectForDictionary:dict]];
    }
    
//    
//    [[NSUserDefaults standardUserDefaults] setObject:[[NSArray alloc] init] forKey:TASK_OBJECTS_KEY];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
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

#pragma mark - UITableViewDataSource

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

- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender {
    if (self.tableView.editing == YES) {
        [self.tableView setEditing:NO animated:YES];
    }
    else {
        [self.tableView setEditing:YES animated:YES];
    }
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

- (void)updateCompletionOfTask:(TaskData *)task forIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *tasksAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    
    if (!tasksAsPropertyLists) tasksAsPropertyLists = [[NSMutableArray alloc] init];
    
    [tasksAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    task.completed = task.completed == YES ? NO : YES;
    
    [tasksAsPropertyLists insertObject:[self taskObjectAsAPropertyList:task] atIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
}

- (void)saveTasks {
    NSMutableArray *taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    for (int x = 0; x < [self.tasks count]; x++) {
        [taskObjectsAsPropertyLists addObject:[self taskObjectAsAPropertyList:self.tasks[x]]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskData *task = self.tasks[indexPath.row];
    
    [self updateCompletionOfTask:task forIndexPath:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tasks removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newTaskObjectsData = [[NSMutableArray alloc] init];
        
        for (TaskData *task in self.tasks) {
            [newTaskObjectsData addObject:[self taskObjectAsAPropertyList:task]];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:newTaskObjectsData forKey:TASK_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    TaskData *taskObject = self.tasks[sourceIndexPath.row];
    [self.tasks removeObjectAtIndex:sourceIndexPath.row];
    [self.tasks insertObject:taskObject atIndex:destinationIndexPath.row];
    
    [self saveTasks];
}

@end
