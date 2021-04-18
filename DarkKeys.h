bool enabled;
bool darkkeys;
bool nocaps;
bool nolight;
bool nlm;

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