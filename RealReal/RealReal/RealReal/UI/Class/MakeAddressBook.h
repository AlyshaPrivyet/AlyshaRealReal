//
//  MakeAddressBook.h
//  RealReal
//
//  Created by alysha on 2016/12/13.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import "PersonGroup.h"
#import "Person.h"

@interface MakeAddressBook : NSObject

@property(nonatomic,strong)PersonGroup *personGroup;
-(NSMutableArray*)getAddressBook;

@end
