//
//  MakeAddressBook.m
//  RealReal
//
//  Created by alysha on 2016/12/13.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import "MakeAddressBook.h"
#import <Contacts/CNContactStore.h>
#import <Contacts/CNContact+Predicates.h>
#import <Contacts/CNContactFetchRequest.h>

@implementation MakeAddressBook

-(void )getAddressBook
{
//    self.personGroup=[PersonGroup sharedPersonGroup];
//    ABAuthorizationStatus status= ABAddressBookGetAuthorizationStatus();
//    
//    if(status!=kABAuthorizationStatusAuthorized)
//    {
//        return nil;
//    }
//    ABAddressBookRef addressBook=ABAddressBookCreateWithOptions(NULL, NULL);
//    CFArrayRef peopleArr= ABAddressBookCopyArrayOfAllPeople(addressBook);
//    CFIndex peopleCount= CFArrayGetCount(peopleArr);
//    for(CFIndex i=0;i<peopleCount;i++)
//    {
//        ABRecordRef personRef=CFArrayGetValueAtIndex(peopleArr, i);
//        NSString *lastName=(__bridge_transfer NSString*)ABRecordCopyValue(personRef, kABPersonLastNameProperty);
//        NSString *firstName=(__bridge_transfer NSString*)ABRecordCopyValue(personRef, kABPersonFirstNameProperty);
//        NSString *totalName=[NSString stringWithFormat:@"%@-%@",firstName,lastName];
//        NSLog(@"totalName:%@",totalName);
//        ABMultiValueRef phones= ABRecordCopyValue(personRef, kABPersonPhoneProperty);
//        CFIndex count=ABMultiValueGetCount(phones);
//        CFIndex i=0;
//        NSString *phone=(__bridge_transfer NSString*)ABMultiValueCopyValueAtIndex(phones, i);
//        NSLog(@"phone:%@",phone);
//        CFRelease(phones);
//        Person *person=[Person initWithName:totalName andPhone:phone];
//        [self.personGroup.personArray addObject:person];
//    }
//    return self.personGroup;
    
    CNContactStore * stroe = [[CNContactStore alloc]init];
    //检索条件，检索所有名字中有zhang的联系人
    NSPredicate * predicate = [CNContact predicateForContactsMatchingName:@"刘晓祥"];
    //提取数据
    NSArray * contacts = [[NSArray alloc]init];
    contacts = [stroe unifiedContactsMatchingPredicate:predicate keysToFetch:@[CNContactGivenNameKey] error:nil];
    for (int i ; i < contacts.count; i ++) {
        CNContact *contact = [[CNContact alloc]init];
        NSLog(@"contact:%@ - %@  - %@",contact.familyName,contact.givenName,contact.birthday);
    }
    

//    CNContactStore * stroe = [[CNContactStore alloc]init];
//    CNContactFetchRequest * request = [[CNContactFetchRequest alloc]initWithKeysToFetch:@[CNContactPhoneticFamilyNameKey]];
//    [stroe enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
//        NSLog(@"%@",contact);
//    }];
    
//    NSMutableArray *contactsArray = [[NSMutableArray alloc]init];
//    
//    CNContactStore * stroe = [[CNContactStore alloc]init];
//    CNContactFetchRequest * request =  [[CNContactFetchRequest alloc]initWithKeysToFetch:@[CNContactGivenNameKey]];
//    
//    request.predicate = [CNContact predicateForContactsMatchingName:@""];
//    
//    [stroe enumerateContactsWithFetchRequest:request  error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
//        NSLog(@"contact:%@ - %@  - %@",contact.familyName,contact.givenName,contact.birthday);
////        [contactsArray addObject:contact];
//    }];
}


@end
