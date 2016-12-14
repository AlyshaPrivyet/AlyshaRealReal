//
//  WelcomeViewController.h
//  Real-real
//
//  Created by alysha on 2016/12/6.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *welcomeScroll;
@property(nonatomic,strong)UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIPageControl *my;

@end
