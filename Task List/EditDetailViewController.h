//
//  EditDetailViewController.h
//  Task List
//
//  Created by Tom Pullen on 04/11/2014.
//  Copyright (c) 2014 Tom Pullen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskData.h"

@protocol EditDetailViewControllerDelegate <NSObject>

- (void)didEditTask:(TaskData *)task;

@end

@interface EditDetailViewController : UIViewController

@property (weak, nonatomic) id <EditDetailViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong, nonatomic) TaskData *task;

- (IBAction)saveBarButtonPressed:(UIBarButtonItem *)sender;

@end
