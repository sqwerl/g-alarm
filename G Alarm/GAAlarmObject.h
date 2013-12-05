//
//  GAAlarmObject.h
//  G Alarm
//
//  Created by Larry Cao on 5/8/13.
//  Copyright (c) 2013 Larry Cao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GAAlarmObject : NSObject<NSCoding>

@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSDate *timeToSetOff;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) int notificationID;
@property (nonatomic, assign) CLRegion *region;
@property (nonatomic, assign) BOOL canDisable;

@end
