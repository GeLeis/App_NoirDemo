//
//  YLT_BaseModular.h
//  Pods
//
//  Created by YLT_Alex on 2017/11/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YLT_BaseMacro.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

NS_ASSUME_NONNULL_BEGIN
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"
@interface YLT_BaseModular : NSObject

+ (void)applicationDidFinishLaunching:(UIApplication *)application;
#if UIKIT_STRING_ENUMS
+ (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions NS_AVAILABLE_IOS(6_0);
+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions NS_AVAILABLE_IOS(3_0);
#else
+ (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions NS_AVAILABLE_IOS(6_0);
+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions NS_AVAILABLE_IOS(3_0);
#endif

+ (void)applicationDidBecomeActive:(UIApplication *)application;
+ (void)applicationWillResignActive:(UIApplication *)application;
+ (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url NS_DEPRECATED_IOS(2_0, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED;
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options NS_AVAILABLE_IOS(9_0);

+ (void)applicationDidReceiveMemoryWarning:(UIApplication *)application;
+ (void)applicationWillTerminate:(UIApplication *)application;
+ (void)applicationSignificantTimeChange:(UIApplication *)application;

+ (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration __TVOS_PROHIBITED;
+ (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation __TVOS_PROHIBITED;

+ (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame __TVOS_PROHIBITED;
+ (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame __TVOS_PROHIBITED;

+ (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings NS_DEPRECATED_IOS(8_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenter requestAuthorizationWithOptions:completionHandler:]") __TVOS_PROHIBITED;

+ (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken NS_AVAILABLE_IOS(3_0);

+ (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error NS_AVAILABLE_IOS(3_0);

+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo NS_DEPRECATED_IOS(3_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications");

+ (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification NS_DEPRECATED_IOS(4_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]") __TVOS_PROHIBITED;

+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler NS_DEPRECATED_IOS(8_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]") __TVOS_PROHIBITED;

+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler NS_DEPRECATED_IOS(9_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]") __TVOS_PROHIBITED;

+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler NS_DEPRECATED_IOS(8_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]") __TVOS_PROHIBITED;

+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler NS_DEPRECATED_IOS(9_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]") __TVOS_PROHIBITED;

+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler NS_AVAILABLE_IOS(7_0);

+ (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler API_AVAILABLE(ios(7.0), tvos(11.0));

+ (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler NS_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED;

+ (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler NS_AVAILABLE_IOS(7_0);

+ (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary * __replyInfo))reply NS_AVAILABLE_IOS(8_2);

+ (void)applicationShouldRequestHealthAuthorization:(UIApplication *)application NS_AVAILABLE_IOS(9_0);

+ (void)application:(UIApplication *)application handleIntent:(INIntent *)intent completionHandler:(void(^)(INIntentResponse *intentResponse))completionHandler NS_AVAILABLE_IOS(11_0);

+ (void)applicationDidEnterBackground:(UIApplication *)application NS_AVAILABLE_IOS(4_0);
+ (void)applicationWillEnterForeground:(UIApplication *)application NS_AVAILABLE_IOS(4_0);

+ (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application NS_AVAILABLE_IOS(4_0);
+ (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application    NS_AVAILABLE_IOS(4_0);

+ (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window  NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED;
+ (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier NS_AVAILABLE_IOS(8_0);

#pragma mark -+ State Restoration protocol adopted by UIApplication delegate --

+ (UIViewController *) application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder NS_AVAILABLE_IOS(6_0);
+ (BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder NS_AVAILABLE_IOS(6_0);
+ (BOOL) application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder NS_AVAILABLE_IOS(6_0);
+ (void) application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder NS_AVAILABLE_IOS(6_0);
+ (void) application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder NS_AVAILABLE_IOS(6_0);

#pragma mark -+ User Activity Continuation protocol adopted by UIApplication delegate --

+ (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType NS_AVAILABLE_IOS(8_0);

+ (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __restorableObjects))restorationHandler NS_AVAILABLE_IOS(8_0);

+ (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error NS_AVAILABLE_IOS(8_0);

+ (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity NS_AVAILABLE_IOS(8_0);

#pragma mark -+ CloudKit Sharing Invitation Handling --

+ (void) application:(UIApplication *)application userDidAcceptCloudKitShareWithMetadata:(CKShareMetadata *)cloudKitShareMetadata NS_AVAILABLE_IOS(10_0);

+ (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler __IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0);
+ (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler __IOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0) __TVOS_PROHIBITED;

@end

#pragma clang diagnostic pop
NS_ASSUME_NONNULL_END
