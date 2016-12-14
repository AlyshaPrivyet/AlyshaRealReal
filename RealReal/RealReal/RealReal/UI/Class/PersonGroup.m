//
//  PersonGroup.m
//  通讯录自定义
//
//  Created by 苏若晞 on 12/5/16.
//  Copyright © 2016 苏若晞. All rights reserved.
//

#import "PersonGroup.h"

@interface PersonGroup()<NSCopying>

@end

@implementation PersonGroup

static PersonGroup *_personGroup;

+(instancetype)sharedPersonGroup
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _personGroup=[[self alloc]init];
        _personGroup.personArray=[NSMutableArray array];
    });
    
    return _personGroup;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _personGroup=[super allocWithZone:zone];
    });
    return _personGroup;
}

-(id)copyWithZone:(NSZone *)zone
{
    return _personGroup;
}

@end
