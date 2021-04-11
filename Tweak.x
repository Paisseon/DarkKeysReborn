#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>

HBPreferences *preferences;
bool enabled;
bool darkkeys;
bool nocaps;

@interface UIKeyboard : UIView
@end

@interface UIKeyboardDockView : UIView
@end

@interface UIKeyboardLayoutStar : UIView
@end

@interface UIKBKeyView : UIView
@end

%hook UIKeyboard
- (void) setFrame: (CGRect) arg1 {
	%orig;
	if (enabled && darkkeys) [self setBackgroundColor:[UIColor blackColor]]; // turn the background black
}
%end

%hook UIKeyboardDockView
- (void) _configureDockItem: (id) arg1 {
	%orig;
	if (enabled && darkkeys) [self setBackgroundColor:[UIColor blackColor]]; // turn different parts of the background black
}
%end

%hook UIKBKeyView
- (void) viewDidLoad {
	if (enabled && nocaps) self.layer.sublayers[0].hidden = 1; // hide function key caps
	if (enabled && nocaps) self.layer.sublayers[0].opacity = 0.0; // hide function key caps
}
%end

%hook UIKeyboardLayoutStar
- (void) viewDidLoad {
	%orig;
	if (enabled && nocaps) self.layer.sublayers[0].sublayers[1].sublayers[0].hidden = 1; // hide alphanumeric key caps
	if (enabled && nocaps) self.layer.sublayers[0].sublayers[1].sublayers[0].opacity = 0.0; // hide alphanumeric key caps
}
%end

%ctor { // prefs stuff
    preferences = [[HBPreferences alloc] initWithIdentifier:@"ai.paisseon.darkkeysreborn"];

    [preferences registerDefaults:@{
        @"Enabled": @YES,
        @"DarkKeys": @YES,
        @"NoCaps": @YES,
    }];

    [preferences registerBool:&enabled default:YES forKey:@"Enabled"];
    [preferences registerBool:&darkkeys default:YES forKey:@"DarkKeys"];
    [preferences registerBool:&nocaps default:YES forKey:@"NoCaps"];
}