//
//  GAAlarmObject.m
//  G Alarm
//
//  Created by Larry Cao on 5/8/13.
//  Copyright (c) 2013 Larry Cao. All rights reserved.
//

#import "GAAlarmObject.h"

@implementation GAAlarmObject

@synthesize label;
@synthesize timeToSetOff;
@synthesize enabled;
@synthesize notificationID;
@synthesize region;
@synthesize canDisable;

//This is important for saving the alarm object in user defaults
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.label forKey:@"label"];
    [encoder encodeObject:self.timeToSetOff forKey:@"timeToSetOff"];
    [encoder encodeBool:self.enabled forKey:@"enabled"];
    [encoder encodeInt:self.notificationID forKey:@"notificationID"];
}

//This is important for loading the alarm object from user defaults
-(id)initWithCoder:(NSCoder *)decoder
{
    self.label = [decoder decodeObjectForKey:@"label"];
    self.timeToSetOff = [decoder decodeObjectForKey:@"timeToSetOff"];
    self.enabled = [decoder decodeBoolForKey:@"enabled"];
    self.notificationID = [decoder decodeIntForKey:@"notificationID"];
    return self;
}

@end
