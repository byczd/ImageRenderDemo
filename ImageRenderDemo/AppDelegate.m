//
//  AppDelegate.m
//  ImageRenderDemo
//
//  Created by 黄龙 on 2019/3/12.
//  Copyright © 2019年 adong. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

#define WEEX_COLOR [UIColor colorWithRed:0.27 green:0.71 blue:0.94 alpha:1]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UIViewController *tmpVC=[[ViewController alloc]init];
    self.window.rootViewController=[[UINavigationController alloc]initWithRootViewController:tmpVC];
  
    
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    [self startSplashScreen];
    return YES;
}

- (void)startSplashScreen
{
    UIView* splashView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    splashView.backgroundColor = WEEX_COLOR;
    
    UIImageView *iconImageView = [UIImageView new];
    UIImage *icon = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weex-icon" ofType:@"png"]];
    if ([icon respondsToSelector:@selector(imageWithRenderingMode:)]) {
        iconImageView.image = [icon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        iconImageView.tintColor = [UIColor whiteColor];
    } else {
        iconImageView.image = icon;
    }
    iconImageView.frame = CGRectMake(0, 0, 320, 320);
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    iconImageView.center = splashView.center;
    [splashView addSubview:iconImageView];
    
    [self.window addSubview:splashView];
    
    float animationDuration = 1.4;
    CGFloat shrinkDuration = animationDuration * 0.3;
    CGFloat growDuration = animationDuration * 0.7;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [UIView animateWithDuration:shrinkDuration delay:1.0 usingSpringWithDamping:0.7f initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.75, 0.75);
            iconImageView.transform = scaleTransform;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:growDuration animations:^{
                CGAffineTransform scaleTransform = CGAffineTransformMakeScale(20, 20);
                iconImageView.transform = scaleTransform;
                splashView.alpha = 0;
            } completion:^(BOOL finished) {
                [splashView removeFromSuperview];
            }];
        }];
    } else {
        [UIView animateWithDuration:shrinkDuration delay:1.0 options:0 animations:^{
            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.75, 0.75);
            iconImageView.transform = scaleTransform;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:growDuration animations:^{
                CGAffineTransform scaleTransform = CGAffineTransformMakeScale(20, 20);
                iconImageView.transform = scaleTransform;
                splashView.alpha = 0;
            } completion:^(BOOL finished) {
                [splashView removeFromSuperview];
            }];
        }];
    }
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
