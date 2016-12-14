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

-(NSMutableArray*)getAddressBook
{
    
    self.personGroup=[PersonGroup sharedPersonGroup];
    
    
    CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (authorizationStatus == CNAuthorizationStatusAuthorized) {
        
        NSArray *keysToFetch = @[CNContactGivenNameKey,  CNContactPhoneNumbersKey];
        CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        
        [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            
            NSLog(@"-------------------------------------------------------");
            NSString *givenName = contact.givenName;
            
            NSLog(@"givenName=%@", givenName);
            
            
            NSArray *phoneNumbers = contact.phoneNumbers;
            
            CNLabeledValue *labelValue=phoneNumbers[0];
            
            CNPhoneNumber *phoneNumber = labelValue.value;
            
            NSLog(@"phone:%@",labelValue.value);
            
            Person *person=[Person initWithName:givenName andPhone:phoneNumber.stringValue];
            
            [self.personGroup.personArray addObject:person];
            
            
        }];
        
        return self.personGroup.personArray;
        
    }
    else
        return nil;
    
    
    
    
    
    
}


@end
