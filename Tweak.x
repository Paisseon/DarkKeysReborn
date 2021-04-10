#import <UIKit/UIKit.h>

@interface UIKeyboard : UIView
@end

@interface UIKeyboardDockView : UIView
@end

%hook UIKeyboard
- (void) setFrame: (CGRect) arg1 {
	%orig;
	[self setBackgroundColor:[UIColor blackColor]];
}
%end

%hook UIKeyboardDockView
- (void) _configureDockItem: (id) arg1 {
	%orig;
	[self setBackgroundColor:[UIColor blackColor]];
}
%end