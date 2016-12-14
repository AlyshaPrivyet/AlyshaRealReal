//
//  AppDelegate.m
//  Real-real
//
//  Created by alysha on 2016/12/6.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomeViewController.h"
#import "FunctionViewController.h"
#import "MainViewController.h"
#import "MainTabbarViewController.h"
#import "SocketSignalingChannel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _infos = [[NSMutableArray alloc]init];
    _connecters = [[NSMutableArray alloc] init];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *telphoneNum = [userDefaults objectForKey:@"PhoneNumber"];
    BOOL isregisted = [userDefaults objectForKey:@"isRegisted"];
    NSString *isFirstTimeLaunchAPP = [userDefaults objectForKey:@"isFirstTimeLaunchAPP"];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstTimeLaunchAPP"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstTimeLaunchAPP"];
        NSLog(@"第一次启动");
        isFirstTimeLaunchAPP = @"YES";
    }else{
        NSLog(@"不是第一次启动");
        isFirstTimeLaunchAPP = @"NO";
    }
    
    
    
    
    if ([isFirstTimeLaunchAPP isEqualToString:@"YES"]) {
        WelcomeViewController *wvc = [[WelcomeViewController alloc] init];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:wvc];
        nav.navigationBar.hidden = YES;
        self.window.rootViewController = nav;
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
        return YES;
    }
    else if(([isFirstTimeLaunchAPP isEqualToString:@"NO"]) || (isFirstTimeLaunchAPP == nil))
    {
        if (isregisted == NO) {
            MainViewController *fvc = [[MainViewController alloc] init];
            UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:fvc];
            nav.navigationBar.hidden = YES;
            self.window.rootViewController = nav;
            self.window.backgroundColor = [UIColor whiteColor];
            [self.window makeKeyAndVisible];
            return YES;
        }
        else if (isregisted == YES)
        {
            MainTabbarViewController *fvc = [[MainTabbarViewController alloc] init];
            UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:fvc];
            nav.navigationBar.hidden = YES;
            self.window.rootViewController = nav;
            self.window.backgroundColor = [UIColor whiteColor];
            [self.window makeKeyAndVisible];
            return YES;
        }
    }
    
    
    return YES;

}

#pragma mark - *********连接信令服务器*******
- (RTCPeerClient*)peerClient{
    if (_peerClient==nil){
        id<RTCP2PSignalingChannelProtocol> scc=[[SocketSignalingChannel alloc]init];
        RTCPeerClientConfiguration* config=[[RTCPeerClientConfiguration alloc]init];
        NSArray *ice=[[NSArray alloc]initWithObjects:[[RTCIceServer alloc]initWithURLStrings:[[NSArray alloc]initWithObjects:@"stun:61.152.239.56", nil]], nil];
        config.ICEServers=ice;
        config.mediaCodec.videoCodec=VideoCodecH264;
        _peerClient=[[RTCPeerClient alloc]initWithConfiguration:config signalingChannel:scc];
        [_peerClient addObserver:self];
    }
    return _peerClient;
}


-(void)onInvited:(NSString *)remoteUserId{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OnInvited" object:self userInfo:[NSDictionary dictionaryWithObject:remoteUserId forKey:@"remoteUserId"]];
    NSLog(@"AppDelegate on invited.");
}

-(void)onAccepted:(NSString*)remoteUserId {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OnAccepted" object:self userInfo:[NSDictionary dictionaryWithObject:remoteUserId forKey:@"remoteUserId"]];
    NSLog(@"AppDelegate on accepted.");
}

-(void)onDenied:(NSString *)remoteUserId {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OnDenied" object:self userInfo:[NSDictionary dictionaryWithObject:remoteUserId forKey:@"remoteUserId"]];
    NSLog(@"AppDelegate on denied.");
}

-(void)onStreamAdded:(RTCRemoteStream *)stream{
    NSLog(@"AppDelegate on stream added");
    [stream retain];
    [_infos addObject:[NSDictionary dictionaryWithObject:stream forKey:@"stream"]];
    NSLog(@"%@", _infos);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OnStreamAdded" object:self userInfo:[NSDictionary dictionaryWithObject:stream forKey:@"stream"]];
}

-(void)onStreamRemoved:(RTCRemoteStream *)stream{
    [_infos removeObject:[NSDictionary dictionaryWithObject:stream forKey:@"stream"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OnStreamRemoved" object:self userInfo:[NSDictionary dictionaryWithObject:stream forKey:@"stream"]];
    NSLog(@"AppDelegate on stream removed.");
}

-(void)onDisconnected{
    NSLog(@"AppDelegate on server disconnected.");
}

- (void) onChatStarted:(NSString *)remoteUserId {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OnStarted" object:self userInfo:[NSDictionary dictionaryWithObject:remoteUserId forKey:@"remoteUserId"]];
    NSLog(@"AppDelegate on chat started.");
}

- (void) onChatStopped:(NSString *)remoteUserId {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OnStopped" object:self userInfo:[NSDictionary dictionaryWithObject:remoteUserId forKey:@"remoteUserId"]];
    NSLog(@"AppDelegate on stopped.");
}

-(void)onDataReceived:(NSString *)remoteUserId message:(NSString *)message{
    NSLog(@"Recieved data from %@, message: %@", remoteUserId, message);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
