//
//  YLT_BaseModular.m
//  Pods
//
//  Created by YLT_Alex on 2017/11/23.
//

#import "YLT_BaseModular.h"
#import "YLT_BaseMacro.h"
#import "NSObject+YLT_Extension.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"

@implementation YLT_BaseModular

- (void)ylt_init {
}

+ (void)applicationDidFinishLaunching:(UIApplication *)application {
    
}

+ (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions API_AVAILABLE(ios(6.0)) {
    
    return YES;
}
+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions API_AVAILABLE(ios(3.0)) {
    
    return YES;
}

+ (void)applicationDidBecomeActive:(UIApplication *)application {
    
}
+ (void)applicationWillResignActive:(UIApplication *)application {
    
}
+ (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url API_DEPRECATED_WITH_REPLACEMENT("application:openURL:options:", ios(2.0, 9.0)) API_UNAVAILABLE(tvos) {
    return YES;
}
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation API_DEPRECATED_WITH_REPLACEMENT("application:openURL:options:", ios(4.2, 9.0)) API_UNAVAILABLE(tvos) {
    return YES;
}

+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options API_AVAILABLE(ios(9.0)) {
    return YES;
    
} // no equiv. notification. return NO if the application can't open for some reason

+ (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
}
// try to clean up as much memory as possible. next step is to terminate app
+ (void)applicationWillTerminate:(UIApplication *)application {
    
}
+ (void)applicationSignificantTimeChange:(UIApplication *)application {
    
}        // midnight, carrier time update, daylight savings time change

+ (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration API_UNAVAILABLE(tvos) API_DEPRECATED("Use viewWillTransitionToSize:withTransitionCoordinator: instead.", ios(2.0, 13.0)) {
    
}
+ (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation API_UNAVAILABLE(tvos) API_DEPRECATED("Use viewWillTransitionToSize:withTransitionCoordinator: instead.", ios(2.0, 13.0)) {
    
}

+ (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame API_UNAVAILABLE(tvos) API_DEPRECATED("Use viewWillTransitionToSize:withTransitionCoordinator: instead.", ios(2.0, 13.0)) {
    
}   // in screen coordinates
+ (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame API_UNAVAILABLE(tvos) API_DEPRECATED("Use viewWillTransitionToSize:withTransitionCoordinator: instead.", ios(2.0, 13.0)) {
    
}

// This callback will be made upon calling -[UIApplication registerUserNotificationSettings:]. The settings the user has granted to the application will be passed in as the second argument.
 + (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings API_DEPRECATED("Use UserNotifications Framework's -[UNUserNotificationCenter requestAuthorizationWithOptions:completionHandler:]", ios(8.0, 10.0)) API_UNAVAILABLE(tvos) {
    
}

+ (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken API_AVAILABLE(ios(3.0)) {
    
}

+ (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error API_AVAILABLE(ios(3.0)) {
    
}

+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo API_DEPRECATED("Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications", ios(3.0, 10.0)) {
    
}

+ (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification API_DEPRECATED("Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]", ios(4.0, 10.0)) API_UNAVAILABLE(tvos) {
    
}

// Called when your app has been activated by the user selecting an action from a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling the action.
+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)(void))completionHandler API_DEPRECATED("Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]", ios(8.0, 10.0)) API_UNAVAILABLE(tvos) {
    
}

+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)(void))completionHandler API_DEPRECATED("Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]", ios(9.0, 10.0)) API_UNAVAILABLE(tvos) {
    
}

// Called when your app has been activated by the user selecting an action from a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling the action.
+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)(void))completionHandler API_DEPRECATED("Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]", ios(8.0, 10.0)) API_UNAVAILABLE(tvos) {
    
}

+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)(void))completionHandler API_DEPRECATED("Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]", ios(9.0, 10.0)) API_UNAVAILABLE(tvos) {
    
}

/*! This delegate method offers an opportunity for applications with the "remote-notification" background mode to fetch appropriate new data in response to an incoming remote notification. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
 
 This method will be invoked even if the application was launched or resumed because of the remote notification. The respective delegate methods will be invoked first. Note that this behavior is in contrast to application:didReceiveRemoteNotification:, which is not called in those cases, and which will not be invoked if this method is implemented. !*/
+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler API_AVAILABLE(ios(7.0)) {
    
}

/// Applications with the "fetch" background mode may be given opportunities to fetch updated content in the background or when it is convenient for the system. This method will be called in these situations. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
+ (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler API_DEPRECATED("Use a BGAppRefreshTask in the BackgroundTasks framework instead", ios(7.0, 13.0), tvos(11.0, 13.0)) {
    
}

// Called when the user activates your application by selecting a shortcut on the home screen,
// except when -application:willFinishLaunchingWithOptions: or -application:didFinishLaunchingWithOptions returns NO.
+ (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler API_AVAILABLE(ios(9.0)) API_UNAVAILABLE(tvos) {
    
}

// Applications using an NSURLSession with a background configuration may be launched or resumed in the background in order to handle the
// completion of tasks in that session, or to handle authentication. This method will be called with the identifier of the session needing
// attention. Once a session has been created from a configuration object with that identifier, the session's delegate will begin receiving
// callbacks. If such a session has already been created (if the app is being resumed, for instance), then the delegate will start receiving
// callbacks without any action by the application. You should call the completionHandler as soon as you're finished handling the callbacks.
+ (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(7.0)) {
    
}

+ (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary * __replyInfo))reply API_AVAILABLE(ios(8.2)) {
    
}

+ (void)applicationShouldRequestHealthAuthorization:(UIApplication *)application API_AVAILABLE(ios(9.0)) {
    
}

+ (void)application:(UIApplication *)application handleIntent:(INIntent *)intent completionHandler:(void(^)(INIntentResponse *intentResponse))completionHandler API_AVAILABLE(ios(11.0)) {
    
}

+ (void)applicationDidEnterBackground:(UIApplication *)application API_AVAILABLE(ios(4.0)) {
    
}
+ (void)applicationWillEnterForeground:(UIApplication *)application API_AVAILABLE(ios(4.0)) {
    
}

+ (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application API_AVAILABLE(ios(4.0)) {
    
}
+ (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application    API_AVAILABLE(ios(4.0)) {
    
}

//+ (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window  API_AVAILABLE(ios(6.0)) API_UNAVAILABLE(tvos) {
//    
//}

// Applications may reject specific types of extensions based on the extension point identifier.
// Constants representing common extension point identifiers are provided further down.
// If unimplemented, the default behavior is to allow the extension point identifier.
+ (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier API_AVAILABLE(ios(8.0)) {
    
    return YES;
}

#pragma mark -+ State Restoration protocol adopted by UIApplication delegate --

+ (UIViewController *) application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)identifierComponents coder:(NSCoder *)coder API_AVAILABLE(ios(6.0)) {
    
    return self.ylt_currentVC;
}
+ (BOOL)application:(UIApplication *)application shouldSaveSecureApplicationState:(NSCoder *)coder API_AVAILABLE(ios(13.2)) {
    
    return YES;
}
+ (BOOL)application:(UIApplication *)application shouldRestoreSecureApplicationState:(NSCoder *)coder API_AVAILABLE(ios(13.2)) {
    
    return YES;
}
+ (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder API_AVAILABLE(ios(6.0)) {
    
}
+ (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder API_AVAILABLE(ios(6.0)) {
    
}

// Deprecated State Restoration opt-in methods:
+ (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder API_DEPRECATED("Use application:shouldSaveSecureApplicationState: instead", ios(6.0, 13.2)) {
    
    return YES;
}
+ (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder API_DEPRECATED("Use application:shouldRestoreSecureApplicationState: instead", ios(6.0, 13.2)) {
    
    return YES;
}

#pragma mark -+ User Activity Continuation protocol adopted by UIApplication delegate --

// Called on the main thread as soon as the user indicates they want to continue an activity in your application. The NSUserActivity object may not be available instantly,
// so use this as an opportunity to show the user that an activity will be continued shortly.
// For each application:willContinueUserActivityWithType: invocation, you are guaranteed to get exactly one invocation of application:continueUserActivity: on success,
// or application:didFailToContinueUserActivityWithType:error: if an error was encountered.
+ (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType API_AVAILABLE(ios(8.0)) {
    
    return YES;
}

// Called on the main thread after the NSUserActivity object is available. Use the data you stored in the NSUserActivity object to re-create what the user was doing.
// You can create/fetch any restorable objects associated with the user activity, and pass them to the restorationHandler. They will then have the UIResponder restoreUserActivityState: method
// invoked with the user activity. Invoking the restorationHandler is optional. It may be copied and invoked later, and it will bounce to the main thread to complete its work and call
// restoreUserActivityState on all objects.
+ (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __restorableObjects))restorationHandler API_AVAILABLE(ios(8.0)) {
    
    return YES;
}

// If the user activity cannot be fetched after willContinueUserActivityWithType is called, this will be called on the main thread when implemented.
+ (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error API_AVAILABLE(ios(8.0)) {
    
}

// This is called on the main thread when a user activity managed by UIKit has been updated. You can use this as a last chance to add additional data to the userActivity.
+ (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity API_AVAILABLE(ios(8.0)) {
    
}

#pragma mark -+ CloudKit Sharing Invitation Handling --
// This will be called on the main thread after the user indicates they want to accept a CloudKit sharing invitation in your application.
// You should use the CKShareMetadata object's shareURL and containerIdentifier to schedule a CKAcceptSharesOperation, then start using
// the resulting CKShare and its associated record(s), which will appear in the CKContainer's shared database in a zone matching that of the record's owner.
+ (void)application:(UIApplication *)application userDidAcceptCloudKitShareWithMetadata:(CKShareMetadata *)cloudKitShareMetadata API_AVAILABLE(ios(10.0)) {
    
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
+ (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions API_AVAILABLE(ios(13.0)) {
    
}

@end

#pragma clang diagnostic pop
