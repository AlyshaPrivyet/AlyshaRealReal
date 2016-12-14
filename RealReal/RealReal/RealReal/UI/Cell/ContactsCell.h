//
//  ContactsCell.h
//  RealReal
//
//  Created by alysha on 2016/12/13.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface ContactsCell : UITableViewCell

@property(nonatomic,strong)Person *person;

+(instancetype)cellWithTableView:(UITableView*)tableView;

@end
