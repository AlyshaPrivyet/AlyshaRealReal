//
//  PersonGroup.h
//  通讯录自定义
//
//  Created by 苏若晞 on 12/5/16.
//  Copyright © 2016 苏若晞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonGroup : NSObject

@property(nonatomic,strong)NSMutableArray *personArray;

+(instancetype)sharedPersonGroup;

@end
