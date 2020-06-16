// デバッグ用のアラート関数
void alertDebug(NSString *text){
	UIViewController *view = [UIApplication sharedApplication].keyWindow.rootViewController;
	while (view.presentedViewController != nil && !view.presentedViewController.isBeingDismissed) { view = view.presentedViewController;}
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Log" message:text preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}]];
    [view presentViewController:alertController animated:YES completion:nil];
}

@interface UIKeyboardLayoutStar : UIView

@property (nonatomic, copy, getter = keyboardName) NSString* keyboardName;
@property (nonatomic, copy, getter = layoutTag) NSString * layoutTag;
@property (nonatomic, copy, getter = description) NSString * description; 
@property (nonatomic, copy, getter = debugDescription) NSString * debugDescription;
@property (nonatomic,retain, getter = activeTouchUUID) NSUUID * activeTouchUUID; 


@end

%hook UIKeyboardLayoutStar

-(instancetype)initWithFrame:(CGRect)frame {
    if (self == %orig) {
		UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onKeyboardTouch:)];
        gestureRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:gestureRecognizer];
     }
     return self;
}

%new
-(void)onKeyboardTouch:(UITapGestureRecognizer *)gestureRecognizer {
	NSLog(@"%@", self.activeTouchUUID.UUIDString);
	NSLog(@"%@", self.layoutTag);
	NSLog(@"%@", self.description);
	NSLog(@"%@", self.debugDescription);
}

%end