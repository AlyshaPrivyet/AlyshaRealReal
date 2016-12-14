//
//  ConverseViewController.h
//  RealReal
//
//  Created by alysha on 2016/12/13.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StreamView.h"
#import "AppDelegate.h"
#import "HorizontalSegue.h"

@interface ConverseViewController : UIViewController
{
    AppDelegate* appDelegate;
}
@property(nonatomic,readonly) UILabel *status;
@property BOOL isCaller;
@property BOOL isChatting;
@property (weak, nonatomic) IBOutlet StreamView *streamView;


@end
