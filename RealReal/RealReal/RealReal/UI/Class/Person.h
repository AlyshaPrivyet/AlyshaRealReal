//
//  Person.h
//  通讯录自定义
//
//  Created by 苏若晞 on 12/5/16.
//  Copyright © 2016 苏若晞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *phone;

+(instancetype)initWithName:(NSString*)name andPhone:(NSString*)phone;

@end
