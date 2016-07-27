//
//  GCDTimer.m
//  GCDTimer
//
//  Created by GM on 16/7/25.
//  Copyright © 2016年 LGM. All rights reserved.
//

#import "GCDTimer.h"

@implementation GCDTimer

+ (GCDTimer *)sharedInstance{

    static GCDTimer * timer = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        timer = [[GCDTimer alloc]init];
    });
    return timer;
}
- (instancetype)init{
    if (self = [super init]) {
        _timerContainer = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)scheduleDispatchTimer:(NSString *)timerName timeInterval:(double)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats action:(dispatch_block_t)action{

    if (timerName == nil || timerName.length == 0) {
        return;
    }
    if (queue == nil) {
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    dispatch_source_t timer = [_timerContainer objectForKey:timerName];
    if (!timer) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timer);
        [_timerContainer setObject:timer forKey:timerName];
    }
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);

    __weak typeof(self) wself = self;
    dispatch_source_set_event_handler(timer, ^{
        action();
        if (!repeats) {
            [wself cancelTimerWithName:timerName];
        }
    });
}

- (void)cancelTimerWithName:(NSString *)timerName{
    dispatch_source_t timer = [_timerContainer objectForKey:timerName];
    if (!timerName) {
        return;
    }
    [_timerContainer removeObjectForKey:timerName];
    dispatch_source_cancel(timer);
}


@end
