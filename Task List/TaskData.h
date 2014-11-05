//
//  TaskData.h
//  Task List
//
//  Created by Tom Pullen on 04/11/2014.
//  Copyright (c) 2014 Tom Pullen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskData : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *date;
@property (nonatomic) BOOL completed;

+ (NSString *)getDateString:(NSDate *)date;
- (id)initWithData:(NSDictionary *)data;

@end
