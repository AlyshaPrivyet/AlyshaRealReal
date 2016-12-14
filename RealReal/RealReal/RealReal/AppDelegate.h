//
//  AppDelegate.h
//  Real-real
//
//  Created by alysha on 2016/12/6.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Woogeen/Woogeen.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,RTCPeerClientObserver>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RTCPeerClient *peerClient;
@property (strong, nonatomic) NSString *remoteUserId;
@property (nonatomic, retain) NSMutableArray* connecters;
@property (nonatomic, retain) NSMutableArray *infos;

@end

