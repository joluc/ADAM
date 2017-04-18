//
//  EHPlainAlert.h
//  HMTest
//
//  Created by Danila Gusev on 09/10/15.
//  Copyright © 2015 josshad. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    ViewAlertError,
    ViewAlertSuccess,
    ViewAlertInfo,
    ViewAlertPanic,
    ViewAlertUnknown
} ViewAlertType;

typedef void (^ ActionBlock)();


@interface EHPlainAlert : UIViewController

/*!
 * @brief Block that is invoked on notification tap
 *
 */
@property (nonatomic, strong) ActionBlock action;

/*!
 * @brief Font for a title message. Default font: [UIFont fontWithName:@"HelveticaNeue-Light" size:15]
 *
 */
@property (nonatomic, strong) UIFont * titleFont;

/*!
 * @brief Font for a subtitle message. Default font: [UIFont fontWithName:@"HelveticaNeue-Light" size:12]
 *
 */
@property (nonatomic, strong) UIFont * subTitleFont;

/*!
 * @brief Color of notification.
 *
 */
@property (nonatomic, strong) UIColor * messageColor;

/*!
 * @brief Icon of the notification.
 *
 */
@property (nonatomic, strong) UIImage * iconImage;

/*!
 * @brief Title of the notification;
 *
 */
@property (nonatomic, copy) NSString * titleString;

/*!
 * @brief Subtitle of the notification;
 *
 */
@property (nonatomic, copy) NSString * subtitleString;

/*!
 * @brief show notification with title "Error" and subtitle error.localizedDescription
 *
 * @param error Error to show in alert
 */
+ (instancetype)showError:(NSError *)error;

/*!
 * @brief show notification with title error.domain and subtitle error.localizedDescription
 *
 * @param error Error to show in alert
 */
+ (instancetype)showDomainError:(NSError *)error;

/*!
 * @brief show default notification
 *
 * @param title Title of the notification
 *
 * @param message Subtitle of the notification
 *
 * @param type The type of the notification, e.g. ViewAlertSuccess
 */
+ (instancetype)showAlertWithTitle:(NSString *)title message:(NSString *)message type:(ViewAlertType)type;


/*!
 * @brief initialize notification
 *
 * @param title Title of the notification
 *
 * @param message Subtitle of the notification
 *
 * @param type The type of the notification, e.g. ViewAlertSuccess
 */
- (id)initWithTitle:(NSString *)title message:(NSString *)message type:(ViewAlertType)type;


/*!
 * @brief show notification
 */
- (void)show;

/*!
 * @brief change maximum number of alerts on screen
 *
 * @param numberOfAlerts Number of alertviews. Default is 3
 */
+ (void)updateNumberOfAlerts:(NSInteger)numberOfAlerts;

/*!
 * @brief change onscreen time of alertview
 *
 * @param delay Time after which an alert is automatically hidden. Default is 4
 */
+ (void)updateHidingDelay:(float)delay;

/*!
 * @brief change default title font
 *
 * @param titleFont Title font. Default is HelveticaNeue-Light 15
 */
+ (void)updateTitleFont:(UIFont *)titleFont;

/*!
 * @brief change default message font
 *
 * @param titleFont Message font. Default is HelveticaNeue-Light 12
 */
+ (void)updateSubTitleFont:(UIFont *)subtitleFont;


/*!
 * @brief change default alert color
 *
 * @param color Background color
 *
 * @param type Message type
 */
+ (void)updateAlertColor:(UIColor *)color forType:(ViewAlertType)type;

/*!
 * @brief change default alert icon
 *
 * @param image Icon image
 *
 * @param type Message type
 */
+ (void)updateAlertIcon:(UIImage *)image forType:(ViewAlertType)type;
@end
