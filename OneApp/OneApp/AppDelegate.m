//
//  AppDelegate.m
//  OneApp
//
//  Created by 冷锐鹏 on 2022/1/6.
//

#import "AppDelegate.h"
#import "GTNewsViewController.h"
#import "GTVideoViewController.h"
#import "GTRecommendViewController.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
	UITabBarController *tabBarController = [[UITabBarController alloc]init];
	[[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];

	GTNewsViewController *newsViewController = [[GTNewsViewController alloc]init];

	GTVideoViewController *videoController = [[GTVideoViewController alloc]init];

	GTRecommendViewController *recommendViewController = [[GTRecommendViewController alloc]init];

	//页面4
	UIViewController *mineViewController = [[UIViewController alloc]init];
	mineViewController.view.backgroundColor = [UIColor    lightGrayColor];
	mineViewController.tabBarItem.title = @"我的";
	mineViewController.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x"];
	mineViewController.tabBarItem.selectedImage =[UIImage imageNamed:@"icon.bundle/page_selected@2x"];

	[tabBarController setViewControllers:@[newsViewController,videoController,recommendViewController,mineViewController]];
	tabBarController.delegate = self;
	UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:tabBarController];

	self.window.rootViewController = navigationController;
	[self.window makeKeyAndVisible];
	return YES;
}


#pragma mark - UISceneSession lifecycle


-(void)applicationWillResignActive:(UIApplication *)application {
}
-(void)applicationDidEnterBackground:(UIApplication *)application {
}
-(void)applicationWillEnterForeground:(UIApplication *)application {
}
-(void)applicationDidBecomeActive:(UIApplication *)application {
}
- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
	NSLog(@"didselect");
}
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
