//
//  Tools.h
//  Real-real
//
//  Created by alysha on 2016/12/6.
//  Copyright © 2016年 alysha. All rights reserved.
//
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HIGHT [UIScreen mainScreen].bounds.size.height

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface Tools : NSObject



+(BOOL)judgePhoneNumber:(NSString *)phoneNum;

+(NSString *)getRandomCode;
-(void)getAddressBook;
@end
