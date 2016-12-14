//
//  NetManager.h
//  RealReal
//
//  Created by alysha on 2016/12/10.
//  Copyright © 2016年 alysha. All rights reserved.
//

#define ServerIp (@"http://115.159.154.128:3000")

#import <Foundation/Foundation.h>

@interface NetManager : NSObject

-(void )postParamToUrl:(NSString *)urlstr withParamArray:(NSMutableArray *)paramArray WithBlock:(void(^)(NSMutableDictionary *mydict))requestResult;
-(void )postChineseParamToUrl:(NSString *)urlstr withParamArray:(NSMutableArray *)paramArray WithBlock:(void(^)(NSMutableDictionary *mydict))requestResult;


-(void )postJasonParamToUrl:(NSString *)urlstr withJason:(NSData *)requestdict WithBlock:(void(^)(NSMutableDictionary *mydict))requestResult;
-(void)postjsonToUrl:(NSString *)urlStr withparam:(NSDictionary *)dict WithBlock:(void(^)(NSMutableDictionary *responseDict))requestResult;
-(void)postjsonWithBlankToUrl:(NSString *)urlStr withparam:(NSDictionary *)dict WithBlock:(void(^)(NSMutableDictionary *responseDict))requestResult;


-(void)postMyInfo;
@end
