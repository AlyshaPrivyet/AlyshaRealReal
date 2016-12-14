//
//  Tools.m
//  Real-real
//
//  Created by alysha on 2016/12/6.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import "Tools.h"

@implementation Tools
+(BOOL)judgePhoneNumber:(NSString *)phoneNum
{
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    // 一个判断是否是手机号码的正则表达式
    NSString *pattern = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",CM_NUM,CU_NUM,CT_NUM];
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *mobile = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11) {
        NO;
    }
    // 无符号整型数据接收匹配的数据的数目
    NSUInteger numbersOfMatch = [regularExpression numberOfMatchesInString:mobile options:NSMatchingReportProgress range:NSMakeRange(0, mobile.length)];
    if (numbersOfMatch>0) return YES;
    return NO;
}

+(NSString *)getRandomCode
{
    int num = (arc4random() % 10000);
    NSString *randomNumber = [NSString stringWithFormat:@"%.4d", num];
    NSLog(@"%@", randomNumber);
    return randomNumber;
}


-(void)getAddressBook
{
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined)
    {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error)
        {
            CFErrorRef *error1 = NULL;
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error1);
            [self copyAddressBook:addressBook];
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized)
    {
        CFErrorRef *error = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        [self copyAddressBook:addressBook];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            NSLog(@"没有获取通讯录权限");
        });
    }
}


- (void)copyAddressBook:(ABAddressBookRef)addressBook
{
    CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    for ( int i = 0; i < numberOfPeople; i++)
    {
        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
        NSString *name = (NSString*)CFBridgingRelease(ABRecordCopyCompositeName(person));
        
        ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
        CFStringRef telValue = ABMultiValueCopyValueAtIndex(valuesRef,0);
//        NSLog(@"valuesRef = %@",valuesRef);
        NSLog(@"telValue = %@",telValue);
    }
    
}


@end
