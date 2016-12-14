//
//  WelcomeViewController.m
//  Real-real
//
//  Created by alysha on 2016/12/6.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import "WelcomeViewController.h"
#import "Tools.h"
#import "MainViewController.h"
#import "HexColor.h"
#import "MainTabbarViewController.h"

@interface WelcomeViewController ()
{
    NSMutableArray *picArray;
    BOOL isout;
//    UIImageView *imageView;
}
@property(nonatomic,strong)UIButton *button;
@end

@implementation WelcomeViewController


//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
//        [self prefersStatusBarHidden];
//        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
//    }
//}
//- (BOOL)prefersStatusBarHidden{
//    return YES;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    [self initImagesArray];
    [self initScrollAndPageControll];
    
    [self loadPageControl];
    
    
}

-(void)initImagesArray
{
    picArray = [[NSMutableArray alloc]initWithObjects:@"Wel01.jpg",@"Wel02.jpg",@"Wel03.jpg", nil];
}


-(void)initScrollAndPageControll
{
    _welcomeScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
    _welcomeScroll.contentSize = CGSizeMake(SCREEN_WIDTH * picArray.count, 0);
    [self.view addSubview:_welcomeScroll];
    _welcomeScroll.pagingEnabled = YES;
    
    for (int i=0; i< picArray.count; i++) {
        //计算imageView的X的坐标
        CGFloat imageViewX =i * _welcomeScroll.frame.size.width;
        //NSLog(@"---%d---%f",zImageCount,imageViewX);
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageViewX, 0, _welcomeScroll.frame.size.width, _welcomeScroll.frame.size.height)];
        //设置我们的图片
        NSString *imghUrlStr = [picArray objectAtIndex:i];
//        Util *util = [[Util alloc]init];
//        UIImage *image = [util getImageFromURL:imghUrlStr];
//        imageView.image=image;
        UIImage *image = [UIImage imageNamed:imghUrlStr];
        imageView.image=image;
        

        
        
        //添加到轮播控制器中
        [_welcomeScroll addSubview:imageView];
        
        if(i==2)
        {
            imageView.userInteractionEnabled=YES;
            self.button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
            self.button.center=CGPointMake(SCREEN_WIDTH /2, SCREEN_HIGHT-120);
            self.button.backgroundColor=[UIColor whiteColor];
            [self.button setTitle:@"立即体验" forState:UIControlStateNormal];
            [self.button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            self.button.layer.cornerRadius=5;
            [self.button addTarget:self action:@selector(presentVC) forControlEvents:UIControlEventTouchUpInside];
            
            [imageView addSubview:self.button];
        }
        

        
        
    }
    //计算imageView的宽度
    CGFloat imageViewW = picArray.count * _welcomeScroll.frame.size.width;
    //NSLog(@"%f",imageViewW);
    
    //给轮播器设置滚动范围
    _welcomeScroll.contentSize=CGSizeMake(imageViewW, 0);
    //隐藏滚动条
    _welcomeScroll.showsHorizontalScrollIndicator=NO;
    //设置分页
    _welcomeScroll.pagingEnabled=YES;
    //设置代理
    _welcomeScroll.delegate=self;
}

//加载页码
- (void)loadPageControl{
    //设置页面总个数
    _my.numberOfPages=picArray.count;
    //设置当前页码
    _my.currentPage=0;
    //设置当前页码的颜色
  //  _pageControl.currentPageIndicatorTintColor=[UIColor yellowColor];
    //设置其他页码的颜色
    _my.backgroundColor = [UIColor clearColor];
    _my.pageIndicatorTintColor=[UIColor whiteColor];
    _my.currentPageIndicatorTintColor=[HexColor colorWithHexString:@"#544847"];
    [self.view addSubview:_my];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView1
{
    int page = (int)(_welcomeScroll.contentOffset.x / SCREEN_WIDTH + 0.5);
    _my.currentPage = page;
}

-(void)presentVC
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:@"isFirstTimeLaunchAPP"];
    NSString *mynum = [userDefaults objectForKey:@"PhoneNumber"];
    if ([mynum isEqualToString:@""] || (mynum == nil)) {
        MainViewController *mvc = [[MainViewController alloc]init];
        [self.navigationController pushViewController:mvc animated:YES];
    }
    else
    {
        MainTabbarViewController *mvc = [[MainTabbarViewController alloc]init];
        [self.navigationController pushViewController:mvc animated:YES];
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
