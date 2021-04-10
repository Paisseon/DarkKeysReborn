#import <UIKit/UIKit.h>

@interface UIKeyboard : UIView
@end

@interface UIKeyboardDockView : UIView
@end

%hook UIKeyboard
- (void) layoutSubviews {
	%orig;
	[self setBackgroundColor:[UIColor blackColor]];
}
%end

%hook UIKBRenderConfig
- (void) setLightKeyboard: (BOOL) arg1 {
	%orig(0);
}
%end

%hook UIKeyboardDockView
- (void) layoutSubviews {
	%orig;
	[self setBackgroundColor:[UIColor blackColor]];
}
%end