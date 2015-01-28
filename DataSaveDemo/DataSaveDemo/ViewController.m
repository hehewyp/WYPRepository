//
//  ViewController.m
//  DataSaveDemo
//
//  Created by hehewyp on 15/1/27.
//  Copyright (c) 2015年 hehewyp. All rights reserved.
//

#import "ViewController.h"
#import "PYPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self saveData];
    [self readData];
    
//    PYPerson *p = [[PYPerson alloc] init];
//    p.name = @"zaza";
//    [NSKeyedArchiver archiveRootObject:p toFile:NSHomeDirectory()];
//    
//    PYPerson *p2 = [NSKeyedUnarchiver unarchiveObjectWithFile:NSHomeDirectory()];
//    NSLog(@"p2 is %@",p2);
    
    NSData *data = [@"zaza" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *archiveCarPriceData = [NSKeyedArchiver archivedDataWithRootObject:data];
    [[NSUserDefaults standardUserDefaults] setObject:archiveCarPriceData forKey:@"DataArray"];
    
    NSData *myEncodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"DataArray"];
    NSLog(@"data is %@",[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject]);
}

- (void)saveData {
    NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];// 以plist文件的形式存储
    NSString *name = @"defalut string";
    [defults setObject:name forKey:@"name"];
    UIImage *image = [UIImage imageNamed:@"test.jpg"];
    NSData *imageData = UIImageJPEGRepresentation(image, 100);
    [defults setObject:imageData forKey:@"image"];
    [defults synchronize];
}

- (void)readData {
    NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defults stringForKey:@"name"];
    NSLog(@"name is %@ home is %@",name,NSHomeDirectory());
    NSData *data = [defults dataForKey:@"image"];
    UIImage *image = [[UIImage alloc] initWithData:data];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(50, 50, 200, 100);
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
