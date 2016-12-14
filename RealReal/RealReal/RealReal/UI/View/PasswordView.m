//
//  PasswordView.m
//  realreal_copy
//
//  Created by 苏若晞 on 07/12/2016.
//  Copyright © 2016 苏若晞. All rights reserved.
//

#import "PasswordView.h"
#import "Tools.h"
#import "FunctionViewController.h"
#import "MBProgressHUD+NJ.h"

@interface PasswordView()<UITextFieldDelegate>
//记录正在输入第几个密码
@property(nonatomic,assign)NSInteger inputStep;
@property(nonatomic,strong)UITextField *realTextField;
//记录输入的密码
@property(nonatomic,strong)NSMutableArray *recordPasswordArr;
@property(nonatomic,strong)NSString *rightCode;
@end

@implementation PasswordView

-(instancetype)initWithSuperView:(UIView*)view
{
    self=[super init];
    
    if(self)
    {
        self.inputStep=0;
        self.recordPasswordArr=[NSMutableArray array];
        self.frame=[UIScreen mainScreen].bounds;
        self.backgroundColor=[UIColor clearColor];
        [self createPassWordTexts];
        [view addSubview:self];
        [view insertSubview:self atIndex:0];
    }
    
    return self;
}



-(void)createPassWordTexts
{
    self.realTextField=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.realTextField.backgroundColor=[UIColor redColor];
    self.realTextField.center=CGPointMake(SCREEN_WIDTH/2, SCREEN_HIGHT/6*1);
    self.realTextField.keyboardType=UIKeyboardTypePhonePad;
    self.realTextField.delegate=self;
    [self.realTextField becomeFirstResponder];
    [self addSubview:self.realTextField];
    
    for(int i=0;i<4;i++)
    {
        UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        textField.tag=(i+1);
        textField.font=[UIFont boldSystemFontOfSize:28];
        textField.userInteractionEnabled=NO;
        textField.tintColor=[UIColor clearColor];
//        [textField setSecureTextEntry:YES];//验证码无需保密
        textField.keyboardType=UIKeyboardTypePhonePad;
        textField.textAlignment=NSTextAlignmentCenter;
        textField.center=CGPointMake(SCREEN_WIDTH/5*(i+1), SCREEN_HIGHT/4);
        //底部横线
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(textField.frame.origin.x, CGRectGetMaxY(textField.frame), textField.frame.size.width, 1)];
        view.backgroundColor=[UIColor blackColor];
        [self addSubview:view];
        [self addSubview:textField];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.text.length+string.length>4)
        return NO;
    
    if(string.length==0)
    {
        UITextField *FaTextField=(UITextField*) [self viewWithTag:self.inputStep];
        [self.recordPasswordArr removeLastObject];
        FaTextField.text=string;
        self.inputStep--;
    }
    else
    {
        [self.recordPasswordArr addObject:string];
        self.inputStep++;
        UITextField *FaTextField=(UITextField*) [self viewWithTag:self.inputStep];
        FaTextField.text=string;
    }
    if(self.recordPasswordArr.count==4)
    {
        NSString *recordPasswordStr=[[NSString alloc]init];
        for(int i=0;i<4;i++)
            recordPasswordStr=[recordPasswordStr stringByAppendingString:self.recordPasswordArr[i]];
        NSLog(@"recordPasswordStr:%@",recordPasswordStr);
        
        if([recordPasswordStr isEqualToString:_rightCode])
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"VerifyOK" object:nil];
        }
        else
        {
            [MBProgressHUD showMessage:@"验证码错误，请重新输入"];
        }
        
    }

    
    return YES;
}


-(void)setRightCode:(NSString *)str
{
    _rightCode = str;
}

@end
