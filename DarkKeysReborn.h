#import <UIKit/UIKit.h>

static NSString* bundleIdentifier = @"ai.paisseon.darkkeysreborn";
static NSMutableDictionary *settings;

static bool enabled;
static bool darkKeyboard;
static bool hideKeyCaps;
static bool disableWhenLight;

@interface UIKeyboard : UIView
@end

@interface UIKeyboardDockView : UIView
@end

@interface UIKeyboardLayoutStar : UIView
@end

@interface UIKBKeyView : UIView
@end

@interface UIUserInterfaceStyleArbiter : NSObject
+ (id) sharedInstance;
- (long long) currentStyle;
@end