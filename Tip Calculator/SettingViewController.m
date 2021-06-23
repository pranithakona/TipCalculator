//
//  SettingViewController.m
//  Tip Calculator
//
//  Created by Pranitha Reddy Kona on 6/22/21.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;
@property (weak, nonatomic) IBOutlet UITextField *customTipField;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double tipPercent = [defaults doubleForKey:@"default_tip_percentage"];
    NSInteger index = [defaults integerForKey:@"default_tip_index"];
    if (index != 4){
        [self.defaultTipControl setSelectedSegmentIndex:index];
        self.customTipField.text = @"";
    }
    else{
        self.customTipField.text = [NSString stringWithFormat:@"%.1f",tipPercent];
        [self.defaultTipControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
    }
    
    
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:true];
}

-(void)saveToUserDefaults:(double)tipPercent index:(NSInteger)index
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setDouble:tipPercent forKey:@"default_tip_percentage"];
        [standardUserDefaults setInteger:index forKey:@"default_tip_index"];
        [standardUserDefaults synchronize];
    }
    double hello = [standardUserDefaults doubleForKey:@"default_tip_percentage"];
}
- (IBAction)defaultChanged:(id)sender {
    double tipPercents[] = {0.1,0.15, 0.2,0.25};
    [self saveToUserDefaults: tipPercents[self.defaultTipControl.selectedSegmentIndex] index: self.defaultTipControl.selectedSegmentIndex];
}
- (IBAction)customDefaultTip:(id)sender {
    //self.defaultTipControl.selectedSegmentIndex = 5;
    [self saveToUserDefaults: [self.customTipField.text doubleValue] index:4];
    [self.defaultTipControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
