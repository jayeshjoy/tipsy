//
//  TipsyViewController.m
//  tipsy
//
//  Created by Jayesh Joy on 9/20/15.
//  Copyright © 2015 Jayesh Joy. All rights reserved.
//

#import "TipsyViewController.h"
#import "SettingsViewController.h"

@interface TipsyViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
- (IBAction)billChanged:(id)sender;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)onSettingsButton;
- (void)loadDefaultIndex;

@end

@implementation TipsyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tipsy";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    [self.billTextField becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadDefaultIndex {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"optionIndex"]) {
        [defaults setInteger:1 forKey:@"optionIndex"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    NSInteger index = [defaults integerForKey:@"optionIndex"];
    self.tipControl.selectedSegmentIndex = index;
    [self updateValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"tipsy view will appear");
    [self loadDefaultIndex];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"tipsy view did appear");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)billChanged:(id)sender {
    [self updateValues];
}

- (IBAction)onTap:(id)sender {
    [self updateValues];
}

-(void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = billAmount + tipAmount;

    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}
@end
