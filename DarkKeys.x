#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>
#import "DarkKeys.h"

HBPreferences *preferences;

%hook UIKeyboard
- (void) setFrame: (CGRect) arg1 {
	%orig;
	if (nolight && UIScreen.mainScreen.traitCollection.userInterfaceStyle == 1) nlm = 0; // returns nlm false if in light mode and disable on light is enabled
	else nlm = 1; // otherwise nlm is true
	if (darkkeys && nlm) [self setBackgroundColor:[UIColor blackColor]]; // turn the background black
}
%end

%hook UIKeyboardDockView
- (void) _configureDockItem: (id) arg1 {
	%orig;
	if (nolight && UIScreen.mainScreen.traitCollection.userInterfaceStyle == 1) nlm = 0;
	else nlm = 1;
	if (darkkeys && nlm) [self setBackgroundColor:[UIColor blackColor]]; // turn different parts of the background black
}
%end

%hook UIKBKeyView
- (void) viewDidLoad {
	if (nocaps) self.layer.sublayers[0].hidden = 1; // hide function key caps
	if (nocaps) self.layer.sublayers[0].opacity = 0.0;
}
%end

%hook UIKeyboardLayoutStar
- (void) viewDidLoad {
	%orig;
	if (nocaps) self.layer.sublayers[0].sublayers[1].sublayers[0].hidden = 1; // hide alphanumeric key caps
	if (nocaps) self.layer.sublayers[0].sublayers[1].sublayers[0].opacity = 0.0;
}
%end

%hook UIKBRenderConfig // thanks u/demon-tk for reporting the bug
- (BOOL) lightKeyboard {
	if (nolight && UIScreen.mainScreen.traitCollection.userInterfaceStyle == 1) nlm = 0;
	else nlm = 1;
	if (darkkeys && nlm) return 0; // set keyboard to darkmode
	return %orig;
}
%end

%ctor { // prefs stuff
    preferences = [[HBPreferences alloc] initWithIdentifier:@"ai.paisseon.darkkeysreborn"];

    [preferences registerDefaults:@{
        @"Enabled": @YES,
        @"DarkKeys": @YES,
        @"NoCaps": @YES,
        @"NoLight": @NO,
    }];

    [preferences registerBool:&enabled default:YES forKey:@"Enabled"];
    [preferences registerBool:&darkkeys default:YES forKey:@"DarkKeys"];
    [preferences registerBool:&nocaps default:YES forKey:@"NoCaps"];
    [preferences registerBool:&nolight default:NO forKey:@"NoLight"]; // idea by u/regloid

    if (enabled) %init;
}
