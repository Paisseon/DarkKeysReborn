#import "DKRSettingsController.h"

@implementation DKRSettingsController
- (void) viewDidLoad {
	[super viewDidLoad];
}

- (void) layoutHeader {
	[super layoutHeader];
}

- (NSBundle *)resourceBundle {
	return [NSBundle bundleWithPath:@"/Library/PreferenceBundles/DarkKeysRebornPrefs.bundle"];
}

- (void) respring {
	pid_t pid;
	const char *args[] = {"sbreload", NULL, NULL, NULL};
	posix_spawn(&pid, "usr/bin/sbreload", NULL, NULL, (char *const *)args, NULL);
}
@end
