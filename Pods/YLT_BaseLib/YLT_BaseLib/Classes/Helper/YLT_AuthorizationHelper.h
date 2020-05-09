//
//  YLT_AuthorizationHelper.h
//  Pods
//
//  Created by YLT_Alex on 2017/11/8.
//

#import <Foundation/Foundation.h>
#import "YLT_BaseMacro.h"

typedef NS_ENUM(NSInteger, ylt_authorizationType) {
    /**
     *  相册/PhotoLibrary
     */
    YLT_PhotoLibrary = 0,
    /**
     *  网络/Cellular Network
     */
    YLT_NetWork,
    /**
     *  相机/Camera
     */
    YLT_Camera,
    /**
     *  麦克风/Audio
     */
    YLT_Microphone,
    /**
     *  通讯录/AddressBook
     */
    YLT_AddressBook,
    /**
     *  日历/Calendar
     */
    YLT_Calendar,
    /**
     *  提醒事项/Reminder
     */
    YLT_Reminder,
    /**
     *  一直请求定位权限/AlwaysAuthorization
     */
    YLT_MapAlways,
    /**
     *  使用时请求定位权限/WhenInUseAuthorization
     */
    YLT_MapWhenInUse,
    /**
     *  媒体资料库/AppleMusic
     */
    YLT_AppleMusic,
    /**
     *  语音识别/SpeechRecognizer
     */
    YLT_SpeechRecognizer,
    /**
     *  Siri(must in iOS10 or later)
     */
    YLT_Siri,
    /**
     *  蓝牙共享/Bluetooth
     */
    YLT_Bluetooth,
    /**
     * 通知权限
     */
    YLT_Notification,
};

@interface YLT_AuthorizationHelper : NSObject

YLT_ShareInstanceHeader(YLT_AuthorizationHelper);

- (void)ylt_authorizationType:(ylt_authorizationType)type
                      success:(void(^)(void))success
                       failed:(void(^)(void))failed;

@end
