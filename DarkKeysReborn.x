#import "DarkKeysReborn.h"

static void refreshPrefs() { // prefs by skittyblock
	CFArrayRef keyList = CFPreferencesCopyKeyList((CFStringRef)bundleIdentifier, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	if (keyList) {
		settings = (NSMutableDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, (CFStringRef)bundleIdentifier, kCFPreferencesCurrentUser, kCFPreferencesAnyHost));
		CFRelease(keyList);
	} else settings = nil;
	if (!settings) settings = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier]];
		enabled          = [([settings objectForKey:@"enabled"] ?: @(true)) boolValue];
		darkKeyboard     = [([settings objectForKey:@"darkKeyboard"] ?: @(true)) boolValue];
		hideKeyCaps      = [([settings objectForKey:@"hideKeyCaps"] ?: @(true)) boolValue];
		disableWhenLight = [([settings objectForKey:@"disableWhenLight"] ?: @(false)) boolValue];
	}
	static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	refreshPrefs();
}

static bool isDarkMode() { // determine is the device is currently in dark mode
	return (UIScreen.mainScreen.traitCollection.userInterfaceStyle != 1); // 1 means light mode
}

%hook UIKeyboard
- (void) setFrame: (CGRect) arg1 {
	%orig;
	if (darkKeyboard) [self setBackgroundColor:[UIColor blackColor]]; // turn the background black
}
%end

%hook UIKeyboardDockView
- (void) _configureDockItem: (id) arg1 {
	%orig;
	if (darkKeyboard) [self setBackgroundColor:[UIColor blackColor]]; // turn different parts of the background black
}
%end

%hook UIKBKeyView
- (void) viewDidLoad {
	%orig;
	if (hideKeyCaps) { // hide function key caps
		self.layer.sublayers[0].hidden = true;
		self.layer.sublayers[0].opacity = 0.0;
	}
}
%end

%hook UIKeyboardLayoutStar
- (void) viewDidLoad {
	%orig;
	if (hideKeyCaps) { // hide alphanumeric key caps
		self.layer.sublayers[0].sublayers[1].sublayers[0].hidden = true;
		self.layer.sublayers[0].sublayers[1].sublayers[0].opacity = 0.0;
	}
}
%end

%hook UIKBRenderConfig // thanks u/demon-tk for reporting the bug
- (bool) lightKeyboard {
	if (darkKeyboard) return false; // set keyboard to dark mode
	return %orig;
}
%end

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, (CFStringRef)[NSString stringWithFormat:@"%@.prefschanged", bundleIdentifier], NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	refreshPrefs();
	if ((enabled && !disableWhenLight) || (enabled && disableWhenLight && isDarkMode())) %init;
}
