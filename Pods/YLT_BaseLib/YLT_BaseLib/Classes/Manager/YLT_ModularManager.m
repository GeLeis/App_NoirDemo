//
//  YLT_ModularManager.m
//  Pods
//
//  Created by YLT_Alex on 2017/11/23.
//

#import "YLT_ModularManager.h"
#import "NSObject+YLT_Extension.h"

NS_ASSUME_NONNULL_BEGIN
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"

@interface YLT_ModularManager() {
}
/**
 模块列表
 */
@property (nonatomic, strong) NSMutableArray *modularList;

YLT_ShareInstanceHeader(YLT_ModularManager);

@end

@implementation YLT_ModularManager

YLT_ShareInstance(YLT_ModularManager);

- (void)ylt_init {
}

- (NSMutableArray *)modularList {
    if (!_modularList) {
        _modularList = [[NSMutableArray alloc] init];
    }
    return _modularList;
}
/**
 模块初始化

 @param plistPath 路径
 */
+ (void)ylt_modularWithPlistPath:(NSString *)plistPath {
    [[NSArray arrayWithContentsOfFile:plistPath] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[YLT_ModularManager shareInstance].modularList addObject:NSClassFromString(obj)];
    }];
}

+ (void)applicationDidFinishLaunching:(UIApplication *)application {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(applicationDidFinishLaunching:)]) {
            [cls applicationDidFinishLaunching:application];
        }
    }
}

+ (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions API_AVAILABLE(ios(6.0)) {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:willFinishLaunchingWithOptions:)]) {
            [cls application:application willFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}
+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions API_AVAILABLE(ios(3.0)) {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
            [cls application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}

+ (void)applicationDidBecomeActive:(UIApplication *)application {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(applicationDidBecomeActive:)]) {
            [cls applicationDidBecomeActive:application];
        }
    }
}
+ (void)applicationWillResignActive:(UIApplication *)application {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(applicationWillResignActive:)]) {
            [cls applicationWillResignActive:application];
        }
    }
}
+ (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:handleOpenURL:)]) {
            [cls application:application handleOpenURL:url];
        }
    }
    return YES;
}
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:openURL:sourceApplication:annotation:)]) {
            [cls application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
        }
    }
    return YES;
}

+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options API_AVAILABLE(ios(9.0)) {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:openURL:options:)]) {
            [cls application:app openURL:url options:options];
        }
    }
    return YES;
    
} // no equiv. notification. return NO if the application can't open for some reason

+ (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(applicationDidReceiveMemoryWarning:)]) {
            [cls applicationDidReceiveMemoryWarning:application];
        }
    }
}
// try to clean up as much memory as possible. next step is to terminate app
+ (void)applicationWillTerminate:(UIApplication *)application {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(applicationWillTerminate:)]) {
            [cls applicationWillTerminate:application];
        }
    }
}
+ (void)applicationSignificantTimeChange:(UIApplication *)application {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(applicationSignificantTimeChange:)]) {
            [cls applicationSignificantTimeChange:application];
        }
    }
}        // midnight, carrier time update, daylight savings time change

+ (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:willChangeStatusBarOrientation:duration:)]) {
            [cls application:application willChangeStatusBarOrientation:newStatusBarOrientation duration:duration];
        }
    }
}
+ (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:didChangeStatusBarOrientation:)]) {
            [cls application:application didChangeStatusBarOrientation:oldStatusBarOrientation];
        }
    }
}

+ (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:willChangeStatusBarFrame:)]) {
            [cls application:application willChangeStatusBarFrame:newStatusBarFrame];
        }
    }
}   // in screen coordinates
+ (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:didChangeStatusBarFrame:)]) {
            [cls application:application didChangeStatusBarFrame:oldStatusBarFrame];
        }
    }
}

// This callback will be made upon calling -[UIApplication registerUserNotificationSettings:]. The settings the user has granted to the application will be passed in as the second argument.
 + (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:didRegisterUserNotificationSettings:)]) {
            [cls application:application didRegisterUserNotificationSettings:notificationSettings];
        }
    }
}

+ (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]) {
            [cls application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

+ (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)]) {
            [cls application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }
}

+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:didReceiveRemoteNotification:)]) {
            [cls application:application didReceiveRemoteNotification:userInfo];
        }
    }
}

+ (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:didReceiveLocalNotification:)]) {
            [cls application:application didReceiveLocalNotification:notification];
        }
    }
}

// Called when your app has been activated by the user selecting an action from a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling the action.
+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)(void))completionHandler {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:handleActionWithIdentifier:forLocalNotification:completionHandler:)]) {
            [cls application:application handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
        }
    }
}

+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)(void))completionHandler {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:handleActionWithIdentifier:forRemoteNotification:withResponseInfo:completionHandler:)]) {
            [cls application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo withResponseInfo:responseInfo completionHandler:completionHandler];
        }
    }
}

// Called when your app has been activated by the user selecting an action from a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling the action.
+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)(void))completionHandler {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:handleActionWithIdentifier:forRemoteNotification:completionHandler:)]) {
            [cls application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo completionHandler:completionHandler];
        }
    }
}

+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)(void))completionHandler {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:handleActionWithIdentifier:forLocalNotification:withResponseInfo:completionHandler:)]) {
            [cls application:application handleActionWithIdentifier:identifier forLocalNotification:notification withResponseInfo:responseInfo completionHandler:completionHandler];
        }
    }
}

/*! This delegate method offers an opportunity for applications with the "remote-notification" background mode to fetch appropriate new data in response to an incoming remote notification. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
 
 This method will be invoked even if the application was launched or resumed because of the remote notification. The respective delegate methods will be invoked first. Note that this behavior is in contrast to application:didReceiveRemoteNotification:, which is not called in those cases, and which will not be invoked if this method is implemented. !*/
+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)]) {
            [cls application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }
    }
}

/// Applications with the "fetch" background mode may be given opportunities to fetch updated content in the background or when it is convenient for the system. This method will be called in these situations. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
+ (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:performFetchWithCompletionHandler:)]) {
            [cls application:application performFetchWithCompletionHandler:completionHandler];
        }
    }
}

// Called when the user activates your application by selecting a shortcut on the home screen,
// except when -application:willFinishLaunchingWithOptions: or -application:didFinishLaunchingWithOptions returns NO.
+ (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:performActionForShortcutItem:completionHandler:)]) {
            [cls application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    }
}

// Applications using an NSURLSession with a background configuration may be launched or resumed in the background in order to handle the
// completion of tasks in that session, or to handle authentication. This method will be called with the identifier of the session needing
// attention. Once a session has been created from a configuration object with that identifier, the session's delegate will begin receiving
// callbacks. If such a session has already been created (if the app is being resumed, for instance), then the delegate will start receiving
// callbacks without any action by the application. You should call the completionHandler as soon as you're finished handling the callbacks.
+ (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:handleEventsForBackgroundURLSession:completionHandler:)]) {
            [cls application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
        }
    }
}

+ (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary * __replyInfo))reply {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:handleWatchKitExtensionRequest:reply:)]) {
            [cls application:application handleWatchKitExtensionRequest:userInfo reply:reply];
        }
    }
}

+ (void)applicationShouldRequestHealthAuthorization:(UIApplication *)application {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(applicationShouldRequestHealthAuthorization:)]) {
            [cls applicationShouldRequestHealthAuthorization:application];
        }
    }
}

+ (void)application:(UIApplication *)application handleIntent:(INIntent *)intent completionHandler:(void(^)(INIntentResponse *intentResponse))completionHandler {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:handleIntent:completionHandler:)]) {
            [cls application:application handleIntent:intent completionHandler:completionHandler];
        }
    }
}

+ (void)applicationDidEnterBackground:(UIApplication *)application {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(applicationDidEnterBackground:)]) {
            [cls applicationDidEnterBackground:application];
        }
    }
}
+ (void)applicationWillEnterForeground:(UIApplication *)application {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(applicationWillEnterForeground:)]) {
            [cls applicationWillEnterForeground:application];
        }
    }
}

+ (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(applicationProtectedDataWillBecomeUnavailable:)]) {
            [cls applicationProtectedDataWillBecomeUnavailable:application];
        }
    }
}
+ (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(applicationProtectedDataDidBecomeAvailable:)]) {
            [cls applicationProtectedDataDidBecomeAvailable:application];
        }
    }
}

//+ (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window  API_AVAILABLE(ios(6.0)) API_UNAVAILABLE(tvos) {
//
//}

// Applications may reject specific types of extensions based on the extension point identifier.
// Constants representing common extension point identifiers are provided further down.
// If unimplemented, the default behavior is to allow the extension point identifier.
+ (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:shouldAllowExtensionPointIdentifier:)]) {
            [cls application:application shouldAllowExtensionPointIdentifier:extensionPointIdentifier];
        }
    }
    return YES;
}

#pragma mark -+ State Restoration protocol adopted by UIApplication delegate --

+ (UIViewController *) application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)identifierComponents coder:(NSCoder *)coder {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:viewControllerWithRestorationIdentifierPath:coder:)]) {
            [cls application:application viewControllerWithRestorationIdentifierPath:identifierComponents coder:coder];
        }
    }
    return self.ylt_currentVC;
}
+ (BOOL)application:(UIApplication *)application shouldSaveSecureApplicationState:(NSCoder *)coder {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:shouldSaveSecureApplicationState:)]) {
            [cls application:application shouldSaveSecureApplicationState:coder];
        }
    }
    return YES;
}
+ (BOOL)application:(UIApplication *)application shouldRestoreSecureApplicationState:(NSCoder *)coder {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:shouldRestoreSecureApplicationState:)]) {
            [cls application:application shouldRestoreSecureApplicationState:coder];
        }
    }
    return YES;
}
+ (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:willEncodeRestorableStateWithCoder:)]) {
            [cls application:application willEncodeRestorableStateWithCoder:coder];
        }
    }
}
+ (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:didDecodeRestorableStateWithCoder:)]) {
            [cls application:application didDecodeRestorableStateWithCoder:coder];
        }
    }
}

// Deprecated State Restoration opt-in methods:
+ (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:shouldSaveSecureApplicationState:)]) {
            [cls application:application shouldSaveSecureApplicationState:coder];
        }
    }
    return YES;
}
+ (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:shouldRestoreApplicationState:)]) {
            [cls application:application shouldRestoreApplicationState:coder];
        }
    }
    return YES;
}

#pragma mark -+ User Activity Continuation protocol adopted by UIApplication delegate --

// Called on the main thread as soon as the user indicates they want to continue an activity in your application. The NSUserActivity object may not be available instantly,
// so use this as an opportunity to show the user that an activity will be continued shortly.
// For each application:willContinueUserActivityWithType: invocation, you are guaranteed to get exactly one invocation of application:continueUserActivity: on success,
// or application:didFailToContinueUserActivityWithType:error: if an error was encountered.
+ (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:willContinueUserActivityWithType:)]) {
            [cls application:application willContinueUserActivityWithType:userActivityType];
        }
    }
    return YES;
}

// Called on the main thread after the NSUserActivity object is available. Use the data you stored in the NSUserActivity object to re-create what the user was doing.
// You can create/fetch any restorable objects associated with the user activity, and pass them to the restorationHandler. They will then have the UIResponder restoreUserActivityState: method
// invoked with the user activity. Invoking the restorationHandler is optional. It may be copied and invoked later, and it will bounce to the main thread to complete its work and call
// restoreUserActivityState on all objects.
+ (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __restorableObjects))restorationHandler {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:continueUserActivity:restorationHandler:)]) {
            [cls application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
        }
    }
    return YES;
}

// If the user activity cannot be fetched after willContinueUserActivityWithType is called, this will be called on the main thread when implemented.
+ (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(scene:didFailToContinueUserActivityWithType:error:)]) {
            [cls application:application didFailToContinueUserActivityWithType:userActivityType error:error];
        }
    }
}

// This is called on the main thread when a user activity managed by UIKit has been updated. You can use this as a last chance to add additional data to the userActivity.
+ (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:didUpdateUserActivity:)]) {
            [cls application:application didUpdateUserActivity:userActivity];
        }
    }
}

#pragma mark -+ CloudKit Sharing Invitation Handling --
// This will be called on the main thread after the user indicates they want to accept a CloudKit sharing invitation in your application.
// You should use the CKShareMetadata object's shareURL and containerIdentifier to schedule a CKAcceptSharesOperation, then start using
// the resulting CKShare and its associated record(s), which will appear in the CKContainer's shared database in a zone matching that of the record's owner.
+ (void)application:(UIApplication *)application userDidAcceptCloudKitShareWithMetadata:(CKShareMetadata *)cloudKitShareMetadata API_AVAILABLE(ios(10.0)) {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:userDidAcceptCloudKitShareWithMetadata:)]) {
            [cls application:application userDidAcceptCloudKitShareWithMetadata:cloudKitShareMetadata];
        }
    }
}

#pragma mark -+ UIScene Support --
// Called when the UIKit is about to create & vend a new UIScene instance to the application.
// The application delegate may modify the provided UISceneConfiguration within this method.
// If the UISceneConfiguration instance returned from this method does not have a systemType which matches the connectingSession's, UIKit will assert
//+ (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options API_AVAILABLE(ios(13.0)) {
//
//}

// Called when the system, due to a user interaction or a request from the application itself, removes one or more representation from the -[UIApplication openSessions] set
// If sessions are discarded while the application is not running, this method is called shortly after the applications next launch.
+ (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    for (Class cls in YLT_ModularManager.shareInstance.modularList) {
        if ([cls respondsToSelector:@selector(application:didDiscardSceneSessions:)]) {
            [cls application:application didDiscardSceneSessions:sceneSessions];
        }
    }
}

+ (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(userNotificationCenter:willPresentNotification:withCompletionHandler:)]) {
            [cls userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
        }
    }
}
+ (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:)]) {
            [cls userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
        }
    }
}

@end
#pragma clang diagnostic pop
NS_ASSUME_NONNULL_END
