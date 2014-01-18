//
//  GAHomeViewController.m
//  G Alarm
//
//  Created by Larry Cao on 5/8/13.
//  Copyright (c) 2013 Larry Cao. All rights reserved.
//

#import "GAHomeViewController.h"
#import "GAAppDelegate.h"

@interface GAHomeViewController ()

@end

@implementation GAHomeViewController
@synthesize hour1Label;
@synthesize hour2Label;
@synthesize minute1Label;
@synthesize minute2Label;
@synthesize colon;
@synthesize alarmGoingOff;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self updateLabels];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    //How often to update the clock labels
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateLabels) userInfo:nil repeats:YES];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    [runloop addTimer:timer forMode:UITrackingRunLoopMode];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
}

// Add this Method
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    //This is what sets the custom font
    //See -http://stackoverflow.com/questions/360751/can-i-embed-a-custom-font-in-an-iphone-application
    colon.font = [UIFont fontWithName:@"digital-7" size:90];
    hour1Label.font = [UIFont fontWithName:@"Digital-7" size:90];
    minute1Label.font = [UIFont fontWithName:@"digital-7" size:90];
    hour2Label.font = [UIFont fontWithName:@"digital-7" size:90];
    minute2Label.font = [UIFont fontWithName:@"digital-7" size:90];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    //This checks if the home view is shown because of an alarm firing
    if(self.alarmGoingOff)
    {
        UIAlertView *alarmAlert = [[UIAlertView alloc] initWithTitle:@"Alarm"
                                                             message:@"snooze"
                                                            delegate:self
                                                   cancelButtonTitle:@"okay"
                                                   otherButtonTitles:nil, nil];
        [alarmAlert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLabels
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSString *hourMinuteSecond = [dateFormatter stringFromDate:date];
    
    hour1Label.text = [hourMinuteSecond substringWithRange:NSMakeRange(0, 1)];
    hour2Label.text = [hourMinuteSecond substringWithRange:NSMakeRange(1, 1)];
    minute1Label.text = [hourMinuteSecond substringWithRange:NSMakeRange(3, 1)];
    minute2Label.text = [hourMinuteSecond substringWithRange:NSMakeRange(4, 1)];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        GAAppDelegate * myAppDelegate = (GAAppDelegate*)[[UIApplication sharedApplication] delegate];
        [myAppDelegate.player stop];
    }
    else{
        //do nothing
    }
}


@end
