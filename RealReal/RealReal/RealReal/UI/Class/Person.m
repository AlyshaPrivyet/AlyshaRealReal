//
//  Person.m
//  通讯录自定义
//
//  Created by 苏若晞 on 12/5/16.
//  Copyright © 2016 苏若晞. All rights reserved.
//

#import "Person.h"

@implementation Person

+(instancetype)initWithName:(NSString*)name andPhone:(NSString*)phone
{
    Person *person=[[self alloc]init];
    person.name=name;
    person.phone=phone;
    
    return person;
}

@end
