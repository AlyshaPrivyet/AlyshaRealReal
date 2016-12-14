//
//  VerifyViewController.m
//  Real-real
//
//  Created by alysha on 2016/12/8.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import "VerifyViewController.h"
#import "PasswordView.h"
#import "Tools.h"
#import "FunctionViewController.h"
#import "MainTabbarViewController.h"

#import "AppDelegate.h"

@interface VerifyViewController ()
{
    NSString *randomNum;
    PasswordView *passwordView;
    AppDelegate* appDelegate;
}
@end

@implementation VerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    passwordView=[[PasswordView alloc]initWithSuperView:self.view];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [_holdingLbl setFrame:CGRectMake(SCREEN_WIDTH/2 - 90,SCREEN_HIGHT/4+50+20, 60, 30)];
    [_countLbl setFrame:CGRectMake(SCREEN_WIDTH/2 + 30,SCREEN_HIGHT/4+50+20, 60, 30)];
    [_reVerifyBtn setFrame:CGRectMake(SCREEN_WIDTH/2-50, _holdingLbl.frame.origin.y+_holdingLbl.frame.size.height + 30, 100, 30)];
    [self sendVerifyCode];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(verifyOKed) name:@"VerifyOK" object:nil];

    
}

#pragma mark - *********验证码验证成功*******
-(void)verifyOKed
{
//    [self connectToSDPServer];
    MainTabbarViewController *fvc = [[MainTabbarViewController alloc]init];
    [self.navigationController pushViewController:fvc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - *********重新发送验证码*******
- (IBAction)resendCode:(id)sender {
    [self sendVerifyCode];
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - *********发送验证码*******
-(void)sendVerifyCode
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //1.构造URL
    NSURL *url = [NSURL URLWithString:@"https://sms.yunpian.com/v1/sms/send.json"];
    
    //2.构造Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //(1)设置为POST请求
    [request setHTTPMethod:@"POST"];
    
    //(2)超时
    [request setTimeoutInterval:60];
    
    //(3)设置请求头
    //[request setAllHTTPHeaderFields:nil];
    
    
    NSString *apiKey = @"c87355342e56ba00729acd6e4042f7c7";
    NSString *phonenumber = [userDefaults objectForKey:@"PhoneNumber"];
    randomNum = [Tools getRandomCode];
    NSString *randomText = @"【芝麻开花】您的验证码是";
    randomText = [randomText stringByAppendingString:randomNum];
    //(4)设置请求体
//    NSString *bodyStr = @"apikey=%@&mobile=%@&text=%@";
    NSString *bodyStr = @"apikey=";
    bodyStr = [bodyStr stringByAppendingString:apiKey];
    bodyStr = [bodyStr stringByAppendingString:@"&"];
    bodyStr = [bodyStr stringByAppendingString:@"mobile="];
    bodyStr = [bodyStr stringByAppendingString:phonenumber];
    bodyStr = [bodyStr stringByAppendingString:@"&"];
    bodyStr = [bodyStr stringByAppendingString:@"text="];
    bodyStr = [bodyStr stringByAppendingString:randomText];
    NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //设置请求体
    [request setHTTPBody:bodyData];
    [request setValue:@"iOS+Android" forHTTPHeaderField:@"User-Agent"];
    
    
    //3.构造Session
    NSURLSession *session = [NSURLSession sharedSession];
    
    //4.task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"response : %@", response);
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"菜单请求返回值：%@",responseDict);
        if ([[responseDict objectForKey:@"msg"]isEqualToString:@"OK"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:randomNum forKey:@"VerifyCode"];
            NSString *codeStr = [userDefaults objectForKey:@"VerifyCode"];
            [passwordView setRightCode:codeStr];
        }
        
    }];
    
    //5.
    [task resume];
}


@end
















