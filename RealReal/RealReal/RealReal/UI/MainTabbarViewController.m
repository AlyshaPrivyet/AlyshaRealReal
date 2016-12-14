//
//  MainTabbarViewController.m
//  RealReal
//
//  Created by alysha on 2016/12/10.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import "MainTabbarViewController.h"
#import "FunctionViewController.h"
#import "AddressBookViewController.h"
#import "RecordViewController.h"
#import "ConverseViewController.h"

@interface MainTabbarViewController ()
{
    AppDelegate* appDelegate;
    
}
@property BOOL isCaller;
@property(nonatomic) RTCPeerClient* peerClient;
@end



@implementation MainTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.hidden = YES;
    
    AddressBookViewController *firstVc = [[AddressBookViewController alloc]init];
    FunctionViewController *secondVc = [[FunctionViewController alloc]init];
    RecordViewController *thirdVc = [[RecordViewController alloc]init];
    
    self.viewControllers = [NSArray arrayWithObjects:firstVc,secondVc,thirdVc,nil];

    self.selectedIndex = 1;
    
    
    UITabBar *tabBar = self.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];

    tabBarItem1.title = @"通讯录";
    tabBarItem2.title = @"拨号盘";
    tabBarItem3.title = @"通话记录";
    
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"backlogo.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"backlogo.png"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"backlogo.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"backlogo.png"]];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"backlogo.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"backlogo.png"]];
    
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    // register
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotification:) name:nil object:nil];
    _peerClient=[appDelegate peerClient];
    
    
//    _isCaller = NO;
//    //注册一个观察者
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInvited:) name:@"OnInvited" object:nil];
//    appDelegate = (id)[[UIApplication sharedApplication]delegate];
//    _peerClient = appDelegate.peerClient;

    [self connectToSDPServer];
}

#pragma mark - *********接收到通话邀请*******
- (void) onInvited:(NSNotification *)notification{
    NSDictionary* userInfo = notification.userInfo;
    if([notification.name isEqualToString:@"OnInvited"]) {
        _isCaller = NO;
        appDelegate.remoteUserId = userInfo[@"remoteUserId"];
        dispatch_async(dispatch_get_main_queue(), ^{
            //在主线程里跳到通话页面
            [self gotoConverseViewController];
        });
    }
}

//token和信令服务器URL共同组成了tokenStr,token将用手机号，URL写死
#pragma mark - *********连接到信令服务器*******
- (void)connectToSDPServer {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *phoneStr = [userDefaults objectForKey:@"PhoneNumber"];
    
    NSMutableDictionary *tokenDict=[[NSMutableDictionary alloc]init];
    [tokenDict setValue:phoneStr forKey:@"token"];
    [tokenDict setValue:@"http://139.196.12.59:8095" forKey:@"host"];
    [[NSUserDefaults standardUserDefaults] setValue:phoneStr forKey:@"userDefaultToken"];
    [[NSUserDefaults standardUserDefaults] setValue:@"http://139.196.12.59:8095" forKey:@"userDefaultURL"];
    
    NSLog(@"%@", tokenDict);
    NSError* error;
    NSData* tokenData=[NSJSONSerialization dataWithJSONObject:tokenDict options:NSJSONWritingPrettyPrinted error:&error];
    NSLog(@"%@", tokenData);
    NSString *tokenString=[[NSString alloc]initWithData:tokenData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", tokenString);
    if(error){
        NSLog(@"Failed to get token.");
        return;
    }
    [_peerClient connect:tokenString onSuccess:^(NSString *msg){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"登录信令服务器成功");
        });
    } onFailure:nil];
}

-(void)onNotification:(NSNotification *)notification{
    
}


#pragma mark - *********跳到通话页面*******
-(void)gotoConverseViewController
{
    ConverseViewController *cvc = [[ConverseViewController alloc]init];
    [self.navigationController pushViewController:cvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
