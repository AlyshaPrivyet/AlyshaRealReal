//
//  NetManager.m
//  RealReal
//
//  Created by alysha on 2016/12/10.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import "NetManager.h"
#import "MBProgressHUD+NJ.h"

@implementation NetManager
{
    NSString *para;
    NSMutableDictionary *MyresponseDict;

}

- (id)init{
    
    //调用父类的初始化方法
    self = [super init];
    
    if(self != nil){
        MyresponseDict = [[NSMutableDictionary alloc]init];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
 
        
    }
    
    return self;
}

-(void )postParamToUrl:(NSString *)urlstr withParamArray:(NSMutableArray *)paramArray WithBlock:(void(^)(NSMutableDictionary *mydict))requestResult
{
    //    [MBProgressHUD showMessage:@""];
    
    
    
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //    NSString *myurlstr = [ServerAddress stringByAppendingString:urlstr];
    NSString *myurlstr = [ServerIp stringByAppendingString:urlstr];
    
    for (int i = 0; i < paramArray.count; i ++) {
        if (i == 0)
        {
            NSMutableDictionary *dict = [paramArray objectAtIndex:i];
            NSString *paramName = [dict objectForKey:@"paramName"];
            NSString *paramValue = [dict objectForKey:@"paramValue"];
            para = paramName;
            
            para = [para stringByAppendingString:@"="];
            para = [para stringByAppendingString:paramValue];
        }
        else
        {
            NSMutableDictionary *dict = [paramArray objectAtIndex:i];
            NSString *paramName = [dict objectForKey:@"paramName"];
            NSString *paramValue = [dict objectForKey:@"paramValue"];
            
            para = @"&";
            para = [para stringByAppendingString:paramName];
            para = [para stringByAppendingString:@"="];
            para = [para stringByAppendingString:paramValue];
        }
        myurlstr = [myurlstr stringByAppendingString:para];
    }
    
    
    
    
    NSLog(@"url == %@",myurlstr);
    NSURL *url = [NSURL URLWithString:myurlstr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"" dataUsingEncoding:NSUTF8StringEncoding];
    
    //6.根据会话对象创建一个Task(发送请求）
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               
                               [MBProgressHUD showError:@"网络错误"];
                               return ;
                           });
            
            
        }
        if (data == nil) {
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               [MBProgressHUD showError:@"网络连接失败"];
                           });
            
            return ;
        }
        //8.解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"菜单请求返回值：%@",dict);
        
        if (dict != nil) {
            // 移除HUD
            MyresponseDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
            
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               //                              [MBProgressHUD hideHUD];
                               requestResult(dict);
                               
                               
                               
                           });
        }
        else
        {
            
        }
    }];
    //7.执行任务
    [dataTask resume];
    
    
}

-(void )postChineseParamToUrl:(NSString *)urlstr withParamArray:(NSMutableArray *)paramArray WithBlock:(void(^)(NSMutableDictionary *mydict))requestResult
{
    //    [MBProgressHUD showMessage:@""];
    
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //    NSString *myurlstr = [ServerAddress stringByAppendingString:urlstr];
    NSString *myurlstr = [ServerIp stringByAppendingString:urlstr];
    
    for (int i = 0; i < paramArray.count; i ++) {
        if (i == 0)
        {
            NSMutableDictionary *dict = [paramArray objectAtIndex:i];
            NSString *paramName = [dict objectForKey:@"paramName"];
            NSString *paramValue = [dict objectForKey:@"paramValue"];
            para = paramName;
            
            para = [para stringByAppendingString:@"="];
            para = [para stringByAppendingString:paramValue];
        }
        else
        {
            NSMutableDictionary *dict = [paramArray objectAtIndex:i];
            NSString *paramName = [dict objectForKey:@"paramName"];
            NSString *paramValue = [dict objectForKey:@"paramValue"];
            
            para = @"&";
            para = [para stringByAppendingString:paramName];
            para = [para stringByAppendingString:@"="];
            para = [para stringByAppendingString:paramValue];
        }
        myurlstr = [myurlstr stringByAppendingString:para];
    }
    
    
    
    
    NSLog(@"url == %@",myurlstr);
    myurlstr = [myurlstr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:myurlstr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"" dataUsingEncoding:NSUTF8StringEncoding];
    
    //6.根据会话对象创建一个Task(发送请求）
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //8.解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"菜单请求返回值：%@",dict);
        
        if (dict != nil) {
            // 移除HUD
            MyresponseDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
            
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               //                               [MBProgressHUD hideHUD];
                               
                               requestResult(dict);
                               
                               
                           });
        }
        else
        {
            
        }
    }];
    //7.执行任务
    [dataTask resume];
    
    
}

-(void)postjsonToUrl:(NSString *)urlStr withparam:(NSDictionary *)dict WithBlock:(void(^)(NSMutableDictionary *responseDict))requestResult
{
    NSString *postUrl = [ServerIp stringByAppendingString:urlStr];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];//
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"jason = %@",jsonString);
    
    NSURL *url = [NSURL URLWithString:postUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2.0f];
    request.HTTPMethod = @"POST";
    
    //序列化对象数据
    request.HTTPBody =  [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"text/html;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"text/html;charset=utf-8" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          if (data != nil)
                                          {
                                              NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                              NSLog(@"菜单请求返回值：%@",responseDict);
                                              // 移除HUD
                                              MyresponseDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
                                              dispatch_async(dispatch_get_main_queue(),
                                                             ^{
                                                                 requestResult(responseDict);
                                                             });
                                          }
                                          else
                                          {
                                              dispatch_async(dispatch_get_main_queue(),
                                                             ^{
                                                                 [MBProgressHUD showError:@"网络连接失败"];
                                                                 [MBProgressHUD hideHUD];
                                                             });
                                          }
                                      }];
    [dataTask resume];
}

-(void)postjsonWithBlankToUrl:(NSString *)urlStr withparam:(NSDictionary *)dict WithBlock:(void(^)(NSMutableDictionary *responseDict))requestResult
{
    NSString *postUrl = [ServerIp stringByAppendingString:urlStr];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];//
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSURL *url = [NSURL URLWithString:postUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2.0f];
    request.HTTPMethod = @"POST";
    
    //序列化对象数据
    request.HTTPBody =  [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"text/html;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"text/html;charset=utf-8" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"菜单请求返回值：%@",responseDict);
        if (dict != nil) {
            // 移除HUD
            MyresponseDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               requestResult(responseDict);
                           });
        }
        else
        {
            
        }
    }];
    [dataTask resume];
}





@end
