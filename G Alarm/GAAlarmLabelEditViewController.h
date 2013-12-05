//
//  GAAlarmLabelEditViewController.h
//  G Alarm
//
//  Created by Larry Cao on 5/8/13.
//  Copyright (c) 2013 Larry Cao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GAAlarmLabelEditViewController;

@protocol GAAlarmLabelEditViewControllerDelegate <NSObject>
- (void)updateLabelText:(NSString*)newLabel;
@end

@interface GAAlarmLabelEditViewController : UIViewController<UITextFieldDelegate>{
    UITextField * labelField;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString * label;
@property (unsafe_unretained) id <GAAlarmLabelEditViewControllerDelegate> delegate;

@end
