//
//  GAHomeViewController.h
//  G Alarm
//
//  Created by Larry Cao on 5/8/13.
//  Copyright (c) 2013 Larry Cao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GAHomeViewController : UIViewController<UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *hour1Label;
@property (strong, nonatomic) IBOutlet UILabel *hour2Label;
@property (strong, nonatomic) IBOutlet UILabel *minute1Label;
@property (strong, nonatomic) IBOutlet UILabel *minute2Label;
@property (strong, nonatomic) IBOutlet UILabel *colon;
@property (nonatomic) BOOL alarmGoingOff;



@end
