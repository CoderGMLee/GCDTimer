//
//  ViewController.m
//  GCDTimer
//
//  Created by GM on 16/7/25.
//  Copyright © 2016年 LGM. All rights reserved.
//

#import "ViewController.h"
#import "GCDTimer.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[GCDTimer sharedInstance]scheduleDispatchTimer:@"timer" timeInterval:2 queue:dispatch_get_main_queue() repeats:NO action:^{
        NSLog(@"1234567890");
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
