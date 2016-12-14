//
//  VerifyViewController.h
//  Real-real
//
//  Created by alysha on 2016/12/8.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Woogeen/Woogeen.h>

@interface VerifyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *noticeLbl;

@property(nonatomic) RTCPeerClient* peerClient;

@property (weak, nonatomic) IBOutlet UILabel *holdingLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UIButton *reVerifyBtn;
- (IBAction)resendCode:(id)sender;
- (IBAction)goback:(id)sender;

@end
