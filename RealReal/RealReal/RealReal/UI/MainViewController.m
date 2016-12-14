//
//  MainViewController.m
//  Real-real
//
//  Created by alysha on 2016/12/7.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import "MainViewController.h"
#import "Tools.h"
#import "VerifyViewController.h"
#import "NetManager.h"
#import "MBProgressHUD+NJ.h"
#import "MainTabbarViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    _nextBtn.hidden = YES;
    _numberInputer.keyboardType = UIKeyboardTypePhonePad;
    [_numberInputer addTarget:self action:@selector(textChangeAction:)forControlEvents:UIControlEventEditingChanged];

}

- (void) textChangeAction:(id) sender {
    NSLog(@"%@",_numberInputer.text);
    BOOL isnum = [Tools judgePhoneNumber:_numberInputer.text];
    if (isnum == YES) {
        _nextBtn.hidden = NO;
    }
    else
    {
        _nextBtn.hidden = YES;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_numberInputer resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{

    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goNext:(id)sender {
    [self registerMyPhone];
//    VerifyViewController *vvc = [[VerifyViewController alloc]init];
//    [self.navigationController pushViewController:vvc animated:YES];
}


/*
 /users/signup
 接口说明：注册
 请求类型：post
 参数说明：{“mobile”: 用户手机号,”username”:用户名（可以为空）}
 */
-(void)registerMyPhone
{        //1.构造URL
        NSURL *url = [NSURL URLWithString:@"http://115.159.154.128:3000/users/signup"];
        
        //2.构造Request
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        //(1)设置为POST请求
        [request setHTTPMethod:@"POST"];
        
        //(2)超时
        [request setTimeoutInterval:60];
        
        //(3)设置请求头
        //[request setAllHTTPHeaderFields:nil];
        
        //(4)设置请求体

    NSString *bodyStr = @"mobile=";
    bodyStr = [bodyStr stringByAppendingString:_numberInputer.text];
    bodyStr = [bodyStr stringByAppendingString:@"&"];
    bodyStr = [bodyStr stringByAppendingString:@"username="];
    bodyStr = [bodyStr stringByAppendingString:@""];
        NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
        
        //设置请求体
        [request setHTTPBody:bodyData];
        
        
        
        //3.构造Session
        NSURLSession *session = [NSURLSession sharedSession];
        
        //4.task
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"response : %@", response);
            if (data != nil)
            {
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSLog(@"菜单请求返回值：%@",responseDict);
                if ([[responseDict objectForKey:@"ERR_CODE"]isEqualToString:@"1"]) {
                    dispatch_async(dispatch_get_main_queue(),
                                   ^{
                                       [MBProgressHUD showSuccess:@"注册成功"];
                                       [MBProgressHUD hideHUD];
                                       NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                       [userDefaults setObject:_numberInputer.text forKey:@"PhoneNumber"];
                                       [userDefaults setObject:@"YES" forKey:@"isRegisted"];
                                        VerifyViewController *vvc = [[VerifyViewController alloc]init];
                                        [self.navigationController pushViewController:vvc animated:YES];
                                   });
                }
                if ( ([[responseDict objectForKey:@"ERR_CODE"]isEqualToString:@"-11"]) && ([[responseDict objectForKey:@"ERR_MSG"]isEqualToString:@"user has signed up"]))
                {
                    dispatch_async(dispatch_get_main_queue(),
                                   ^{
                                       [MBProgressHUD showSuccess:@"手机已经注册"];
                                       [MBProgressHUD hideHUD];
                                       NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                       [userDefaults setObject:_numberInputer.text forKey:@"PhoneNumber"];
                                       [userDefaults setObject:@"YES" forKey:@"isRegisted"];
                                       MainTabbarViewController *vvc = [[MainTabbarViewController alloc]init];
                                       [self.navigationController pushViewController:vvc animated:YES];

                                   });
                }
               
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(),
                               ^{

                               });
            }
            
        }];
        
        //5.
        [task resume];
    

}


@end





















