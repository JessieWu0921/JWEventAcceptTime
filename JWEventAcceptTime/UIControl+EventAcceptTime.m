//
//  UIControl+EventAcceptTime.m
//  JWEventAcceptTime
//
//  Created by JessieWu on 2018/7/5.
//  Copyright © 2018年 JessieWu. All rights reserved.
//

#import "UIControl+EventAcceptTime.h"
#import <objc/runtime.h>

static const char *UIControl_EventAcceptInterval = "UIControl_EventAcceptInterval";

@interface UIControl()
@property (nonatomic, assign) NSTimeInterval jw_acceptEventTime;
@end

@implementation UIControl (EventAcceptTime)

+ (void)load {
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(jw_sendAction:to:forEvent:));
//    BOOL added = class_addMethod([self class], @selector(jw_sendAction:to:forEvent:), method_getImplementation(b), method_getTypeEncoding(b));
//    if (!added) {
//        method_exchangeImplementations(a, b);
//    }
    method_exchangeImplementations(a, b);
}

- (NSTimeInterval)jw_acceptEventTimeInterval {
    return [objc_getAssociatedObject(self, UIControl_EventAcceptInterval) doubleValue];
}

- (void)setJw_acceptEventTimeInterval:(NSTimeInterval)jw_acceptEventTimeInterval {
    objc_setAssociatedObject(self, UIControl_EventAcceptInterval, @(jw_acceptEventTimeInterval), OBJC_ASSOCIATION_ASSIGN);
}

static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

- (NSTimeInterval)jw_acceptEventTime {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setJw_acceptEventTime:(NSTimeInterval)jw_acceptEventTime {
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(jw_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)jw_sendAction:(SEL)selector to:(id)target forEvent:(UIEvent *)event {
    if (NSDate.date.timeIntervalSince1970 - self.jw_acceptEventTime < self.jw_acceptEventTimeInterval) {
        return;
    }
    
    if (self.jw_acceptEventTimeInterval > 0) {
        self.jw_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    [self jw_sendAction:selector to:target forEvent:event];
    
}

@end
