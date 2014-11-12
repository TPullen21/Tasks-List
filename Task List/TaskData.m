//
//  TaskData.m
//  Task List
//
//  Created by Tom Pullen on 04/11/2014.
//  Copyright (c) 2014 Tom Pullen. All rights reserved.
//

#import "TaskData.h"

@implementation TaskData

+ (NSString *)getDateString:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    return [formatter stringFromDate:date];
}

+ (NSDate *)getDate:(NSString *)stringDate {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    return [formatter dateFromString:stringDate];
}

-(id)initWithData:(NSDictionary *)data {
    self = [super init];
    
    if (self) {
        self.title = data[TASK_TITLE];
        self.desc = data[TASK_DESCRIPTION];
        self.date = [TaskData getDateString:data[TASK_DATE]];
        self.completed = [data[TASK_COMPLETION] boolValue];
    }
    
    return self;
}

- (id)init {
    self = [self initWithData:nil];
    
    return self;
}

@end
