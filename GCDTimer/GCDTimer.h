//
//  GCDTimer.h
//  GCDTimer
//
//  Created by GM on 16/7/25.
//  Copyright © 2016年 LGM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDTimer : NSObject
{
    NSMutableDictionary * _timerContainer;
}

+ (GCDTimer *)sharedInstance;
- (void)scheduleDispatchTimer:(NSString *)timerName timeInterval:(double)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats action:(dispatch_block_t)action;
- (void)cancelTimerWithName:(NSString *)timerName;
@end
