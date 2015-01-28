//
//  PYPerson.m
//  DataSaveDemo
//
//  Created by hehewyp on 15/1/27.
//  Copyright (c) 2015年 hehewyp. All rights reserved.
//

#import "PYPerson.h"

@implementation PYPerson

- (void)encodeWithCoder:(NSCoder *)aCoder { // 数据写到coder中去,序列化数据
    NSLog(@"_name is %@",_name);
    [aCoder encodeObject:_name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)aDecoder { // 读取数据，保存到相应的变量中,即反序列化数据
    self = [super init];
    if (self) {
       [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
