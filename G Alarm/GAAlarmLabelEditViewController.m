//
//  GAAlarmLabelEditViewController.m
//  G Alarm
//
//  Created by Larry Cao on 5/8/13.
//  Copyright (c) 2013 Larry Cao. All rights reserved.
//

#import "GAAlarmLabelEditViewController.h"



@interface GAAlarmLabelEditViewController ()

@end

@implementation GAAlarmLabelEditViewController

@synthesize delegate;
@synthesize label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        if ([indexPath section] == 0) {
            UITextField *labelTextField = [[UITextField alloc] initWithFrame:CGRectMake(8, 4, 280, 35)];
            labelField = labelTextField;
            labelTextField.adjustsFontSizeToFitWidth = YES;
            labelTextField.textColor = [UIColor whiteColor];
            labelTextField.backgroundColor = [UIColor clearColor];
            labelTextField.text = label;
            labelTextField.returnKeyType = UIReturnKeyDone;
            labelTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
            labelTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
            labelTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            labelTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            labelTextField.keyboardType = UIKeyboardTypeDefault;
            [labelTextField becomeFirstResponder];
            labelTextField.tag = 0;
            labelTextField.delegate = self;
            labelTextField.clearButtonMode = UITextFieldViewModeAlways;
            [labelTextField setEnabled: YES];
            [cell.contentView addSubview:labelTextField];
            
        }
    }
    cell.backgroundColor = [UIColor colorWithRed:17.0/255 green:22.0/255 blue:34.0/255 alpha:1];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellSelected = [tableView cellForRowAtIndexPath: indexPath];
    UITextField *textField = [[cellSelected.contentView subviews] objectAtIndex: 0];
    [textField becomeFirstResponder];
    
    [tableView deselectRowAtIndexPath: indexPath animated: NO];
}

-(IBAction)saveAlarmLabel:(id)sender
{
    if([self.delegate respondsToSelector:@selector(updateLabelText:)])
    {
        [self.delegate updateLabelText:labelField.text];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self saveAlarmLabel:nil];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

