//
//  PasswordView.h
//  realreal_copy
//
//  Created by 苏若晞 on 07/12/2016.
//  Copyright © 2016 苏若晞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^backBlock)();

@interface PasswordView : UIView

@property(nonatomic,copy)backBlock block;

-(instancetype)initWithSuperView:(UIView*)view;
@property(nonatomic,strong)NSString *CodeStr;
-(void)setRightCode:(NSString *)str;


@end
