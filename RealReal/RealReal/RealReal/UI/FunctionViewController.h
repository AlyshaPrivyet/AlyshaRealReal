//
//  FunctionViewController.h
//  RealReal
//
//  Created by alysha on 2016/12/10.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionViewController : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *numberInputer;
- (IBAction)backBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *contentTable;


@end
