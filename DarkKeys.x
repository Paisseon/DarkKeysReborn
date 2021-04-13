#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>
#import "DarkKeys.h"

HBPreferences *preferences;

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
	if (enabled && nocaps) self.layer.sublayers[0].opacity = 0.0;
}
%end

%hook UIKeyboardLayoutStar
- (void) viewDidLoad {
	%orig;
	if (enabled && nocaps) self.layer.sublayers[0].sublayers[1].sublayers[0].hidden = 1; // hide alphanumeric key caps
	if (enabled && nocaps) self.layer.sublayers[0].sublayers[1].sublayers[0].opacity = 0.0;
}
%end

%hook TUIPredictionViewStackView
- (void) viewDidLoad {
	%orig;
	if (enabled && darkkeys) [self setBackgroundColor:[UIColor blackColor]]; // make the prediction bar black
}
%end

%hook UIKBRenderConfig // thanks u/demon-tk for reporting the bug
- (BOOL) lightKeyboard {
	if (enabled && darkkeys) return 0; // set keyboard to darkmode
	return %orig;
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