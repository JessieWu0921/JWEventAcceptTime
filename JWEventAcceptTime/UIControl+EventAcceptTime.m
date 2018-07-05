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

- (void)jw_sendAction:(SEL)selector to:(id)target forEvent:(UIEvent *)event {
    static NSTimeInterval eventTime = 0.0f;
    if (NSDate.date.timeIntervalSince1970 - eventTime < self.jw_acceptEventTimeInterval) return;
        
    [self jw_sendAction:selector to:target forEvent:event];
    
    eventTime = NSDate.date.timeIntervalSince1970;
}

@end
