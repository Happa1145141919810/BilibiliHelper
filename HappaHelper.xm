// See http://iphonedevwiki.net/index.php/Logos

#if TARGET_OS_SIMULATOR
#error Do not support the simulator, please use the real iPhone Device.
#endif

#import <UIKit/UIKit.h>

%hook ClassName

+ (id)sharedInstance
{
	%log;

	return %orig;
}

- (void)messageWithNoReturnAndOneArgument:(id)originalArgument
{
	%log;

	%orig(originalArgument);
	
	// or, for exmaple, you could use a custom value instead of the original argument: %orig(customValue);
}

- (id)messageWithReturnAndNoArguments
{
	%log;

	id originalReturnOfMessage = %orig;
	
	// for example, you could modify the original return value before returning it: [SomeOtherClass doSomethingToThisObject:originalReturnOfMessage];

	return originalReturnOfMessage;
}

%end

%hook UIViewController

- (void)viewWillAppear:(BOOL)animated{
    %orig;
    NSLog(@"\n***********************************************\n\t%@ appear\n***********************************************\n",NSStringFromClass([(NSObject*)self class]));
    UILongPressGestureRecognizer *rec = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerQuadrupleTap:)];
    rec.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:rec];
     BOOL isHome = [[NSString stringWithFormat:@"%@",self] containsString:@"HomeView"];
     if (!isHome){return;}
     BOOL isShow = [NSUserDefaults.standardUserDefaults boolForKey:@"happa"];
     if (!isShow) {
         [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"happa"];
         [NSUserDefaults.standardUserDefaults synchronize];

     }
}


%new
- (void)handleTwoFingerQuadrupleTap:(id *)tapRecognizer
{

}
%end


/// 地区
%hook BBPgcPhoneScheduleVM
- (id)area_id{
    return [NSUserDefaults.standardUserDefaults objectForKey: @"happa"];
}
%end


/// 大会员
%hook BFCUserVipModel
- (int)vipStatus{
    return 1;
}
- (BOOL)isValidYearVip{
    return YES;
}
- (BOOL)isValidVip{
    return YES;
}

- (int)vipType{
    return 2;
}

- (long long)vipDueDate{
    return 1490544000000 + 1000 * 24 * 3600 *365 * 2;
}
%end


%hook BiliAppDelegate

- (_Bool)handleOpenUrl:(id)arg1{
    NSLog(@"==================\n%@\n==================\n",arg1);
    return %orig();
}
- (_Bool)application:(id)arg1 openURL:(id)arg2 options:(id)arg3{
    NSLog(@"==================\n%@\n==================\n",arg2);
    return %orig();
}
- (_Bool)application:(id)arg1 openURL:(id)arg2 sourceApplication:(id)arg3 annotation:(id)arg4{
    NSLog(@"==================\n%@\n==================\n",arg2);
    return %orig();
}
- (_Bool)application:(id)arg1 handleOpenURL:(id)arg2{
    NSLog(@"==================\n%@\n==================\n",arg2);
    return %orig();
}

%end


%hook BBPgcMPMainVC

- (_Bool)isOpenVIP{
   return YES;
}

- (void)setParams:(id)arg1{
    NSLog(@"==================\n%@\n==================\n",arg1);
    %orig();
}
%end

%hook BBPhonePlayerTagViewController

- (void)jumpWithVideoInfo:(id)arg1{
    NSLog(@"==================\n%@\n==================\n",arg1);
    %orig();
}

%end

//解锁画质
%hook BBPgcPlayerQualityHelper
- (bool)isPgcVipQualityWith:(long long)arg1 {
    return false;
}
%end
%hook BBPlayerQualityHelper
- (bool)isPgcVipQualityWith:(long long)arg1 {
    return false;
}
%end
%hook BBResolverPGCHelper
- (bool)isPgcVipQualityWith:(long long)arg1 {
    return false;
}
%end
%hook BBCheesePlayerQualityHelper
- (bool)isPgcVipQualityWith:(long long)arg1 {
    return false;
}
%end
%hook BBPlayerCastQualityService
- (bool)needVip {
    return false;
}
%end
%hook BBResolverVideoQuality
- (bool)needVip {
    return false;
}
%end


