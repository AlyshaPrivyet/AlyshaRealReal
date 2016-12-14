//
//  MainViewController.h
//  Real-real
//
//  Created by alysha on 2016/12/7.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *numberInputer;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)goNext:(id)sender;

@end
