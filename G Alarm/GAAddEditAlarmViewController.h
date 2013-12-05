//
//  GAAddEditAlarmViewController.h
//  G Alarm
//
//  Created by Larry Cao on 5/8/13.
//  Copyright (c) 2013 Larry Cao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAAlarmLabelEditViewController.h"

@interface GAAddEditAlarmViewController : UIViewController <GAAlarmLabelEditViewControllerDelegate, UIAlertViewDelegate>


@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIDatePicker *timeToSetOff;
@property (nonatomic, strong) IBOutlet UINavigationItem *navItem;
@property (nonatomic, assign) NSInteger indexOfAlarmToEdit;
@property(atomic,strong) NSString *label;
@property(nonatomic,assign) BOOL editMode;
@property(nonatomic,assign) int notificationID;

@end
