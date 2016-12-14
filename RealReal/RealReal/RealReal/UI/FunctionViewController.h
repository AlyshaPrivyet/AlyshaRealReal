//
//  FunctionViewController.h
//  RealReal
//
//  Created by alysha on 2016/12/10.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Woogeen/Woogeen.h>

@interface FunctionViewController : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,RTCPeerClientObserver>
@property (weak, nonatomic) IBOutlet UITextField *numberInputer;
- (IBAction)backBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *contentTable;

@property (weak, nonatomic) IBOutlet UIButton *prepareDieBtn;
- (IBAction)clickToCall:(id)sender;

@end
