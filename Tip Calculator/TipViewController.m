//
//  TipViewController.m
//  Tip Calculator
//
//  Created by Pranitha Reddy Kona on 6/22/21.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billField;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *billLabel;
@property (weak, nonatomic) IBOutlet UIButton *tipPercent10Button;
@property (weak, nonatomic) IBOutlet UIButton *tipPercent15Button;
@property (weak, nonatomic) IBOutlet UIButton *tipPercent20Button;
@property (weak, nonatomic) IBOutlet UIButton *tipPercent25Button;
@property (weak, nonatomic) IBOutlet UIButton *tipPercentCustomButton;
@property (weak, nonatomic) IBOutlet UIImageView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *splitLabel;
@property (weak, nonatomic) IBOutlet UIStepper *splitStepper;
@property (weak, nonatomic) IBOutlet UITextField *customTipField;

@end

@implementation TipViewController
double tipPercent;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *tipButtons = [[NSArray alloc]
       initWithObjects:self.tipPercent10Button,self.tipPercent15Button,self.tipPercent20Button,self.tipPercent25Button,self.tipPercentCustomButton, nil];
    
    for (int i = 0; i < tipButtons.count; i++){
        UIButton *button = tipButtons[i];
        button.layer.cornerRadius = 25.0;
    }
    
    self.bottomView.layer.cornerRadius = 25.0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSArray *tipButtons = [[NSArray alloc]
       initWithObjects:self.tipPercent10Button,self.tipPercent15Button,self.tipPercent20Button,self.tipPercent25Button,self.tipPercentCustomButton, nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    tipPercent = [defaults doubleForKey:@"default_tip_percentage"]/100.0;
    NSInteger index = [defaults integerForKey:@"default_tip_index"];
    for (int i = 0; i < tipButtons.count; i++){
        UIButton *button = tipButtons[i];
        button.backgroundColor = [UIColor colorWithRed: 58/255.0 green: 132/255.0 blue: 82/255.0 alpha: 0.26];
        [button setTitleColor: [UIColor colorWithRed: 58/255.0 green: 132/255.0 blue: 82/255.0 alpha: 1.0] forState: UIControlStateNormal];
    }
    if (index == 4){
        self.customTipField.text = [NSString stringWithFormat:@"%.1f",tipPercent*100.0];
    }
    else{
        UIButton *button = tipButtons[index];
        button.backgroundColor = [UIColor colorWithRed: 58/255.0 green: 132/255.0 blue: 82/255.0 alpha: 1.0];
        [button setTitleColor: [UIColor colorWithRed: 255/255.0 green: 255/255.0 blue: 255/255.0 alpha: 1.0] forState: UIControlStateNormal];
        self.customTipField.text = @"";
    }
    [self updateLabels:self];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:true];
}
- (IBAction)updateLabels:(id)sender {
    double bill = [self.billField.text doubleValue]/self.splitStepper.value;
    double tip = ([self.billField.text doubleValue]/self.splitStepper.value) * tipPercent;
    double total = bill + tip;
    
    self.billLabel.text = [NSString stringWithFormat:@"$%.2f", bill];
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", total];
}
- (IBAction)updateSplit:(id)sender {
    self.splitLabel.text = [NSString stringWithFormat:@"%.20f",self.splitStepper.value];
    [self updateLabels:self];
}
- (IBAction)customTip:(id)sender {
    NSArray *tipButtons = [[NSArray alloc]
       initWithObjects:self.tipPercent10Button,self.tipPercent15Button,self.tipPercent20Button,self.tipPercent25Button,self.tipPercentCustomButton, nil];
    for (int i = 0; i < tipButtons.count; i++){
        UIButton *button = tipButtons[i];
        button.backgroundColor = [UIColor colorWithRed: 58/255.0 green: 132/255.0 blue: 82/255.0 alpha: 0.26];
        [button setTitleColor: [UIColor colorWithRed: 58/255.0 green: 132/255.0 blue: 82/255.0 alpha: 1.0] forState: UIControlStateNormal];
    }
    tipPercent = [self.customTipField.text doubleValue]/100;
    [self updateLabels:self];
}

- (IBAction)buttonPressed:(UIButton*)_sender {
    NSArray *tipButtons = [[NSArray alloc]
       initWithObjects:self.tipPercent10Button,self.tipPercent15Button,self.tipPercent20Button,self.tipPercent25Button,self.tipPercentCustomButton, nil];
    double tipPercents[] = {0.10, 0.15, 0.2, 0.25};
    for (int i = 0; i < tipButtons.count; i++){
        UIButton *button = tipButtons[i];
        if (button == _sender){
            tipPercent = tipPercents[i];
            [self updateLabels:self];
        }
        button.backgroundColor = [UIColor colorWithRed: 58/255.0 green: 132/255.0 blue: 82/255.0 alpha: 0.26];
        [button setTitleColor: [UIColor colorWithRed: 58/255.0 green: 132/255.0 blue: 82/255.0 alpha: 1.0] forState: UIControlStateNormal];
    }
    _sender.backgroundColor = [UIColor colorWithRed: 58/255.0 green: 132/255.0 blue: 82/255.0 alpha: 1.0];
    [_sender setTitleColor: [UIColor colorWithRed: 255/255.0 green: 255/255.0 blue: 255/255.0 alpha: 1.0] forState: UIControlStateNormal];
    
}


\

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
