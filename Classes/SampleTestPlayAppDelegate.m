//
//  SampleTestPlayAppDelegate.m
//  SampleTestPlay
//
//  Created by Ryzhkov Mihailo on 07.08.10.
//  Copyright n/a 2010. All rights reserved.
//

#import "SampleTestPlayAppDelegate.h"

#import "RootViewController.h"

#import "AudioStore.h"
#import "ChannelStore.h"

@implementation SampleTestPlayAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize audioArray;
@synthesize channelArray;
@synthesize downloadQueue;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	[self createTumbIfNo];
	
	int audio;
	int channel;
    [window addSubview:viewController.view];
	
	
	
	NSMutableArray *tempArrays = [[NSMutableArray alloc] init];
	self.audioArray = tempArrays;
	[tempArrays release];
	
	NSMutableArray *tempArrayss = [[NSMutableArray alloc] init];
	self.channelArray = tempArrayss;
	[tempArrayss release];
	
	/*for (audio = 0; audio<=20; audio++) {
		AudioStore *audioObj = [[AudioStore alloc] autorelease];
		audioObj.song = [NSString stringWithFormat:@"audio %d", audio];
		[self addAudio:audioObj];
		
	}*/

	/*for (channel = 0; channel<=20; channel++) {
		ChannelStore *channelObj = [[ChannelStore alloc] autorelease];
		channelObj.url = [NSString stringWithFormat:@"Channel %d", channel];
		[self addChannel:channelObj];
	}*/
	
    [window makeKeyAndVisible];
downloadQueue = [[NSOperationQueue alloc] init];
    return YES;
}

-(void)createTumbIfNo {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *path = [self getFileTumb];
	if (![fileManager fileExistsAtPath:path])
		[fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}
- (NSString *) getFileTumb {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"tumb"];
}
+ (SampleTestPlayAppDelegate *)sharedAppDelegate
{
    return (SampleTestPlayAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

- (void) addAudio:(AudioStore *)audioObj {
	
	
	[audioArray addObject:audioObj];
}

- (void) addChannel:(ChannelStore *)channelObj {
	
	
	[channelArray addObject:channelObj];
}

- (void)showView
{
    if (View == nil)
    {
        View = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
        View.opaque = NO;
        View.backgroundColor = [UIColor blackColor];
        View.alpha = 0.5;
		
        UIActivityIndicatorView *spinningWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(90.0, 222.0, 37.0, 37.0)];
        [spinningWheel startAnimating];
        spinningWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [View addSubview:spinningWheel];
		
		UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(140.0, 222.0, 90.0, 37.0)] autorelease];
		//label.font = [UIFont systemFontOfSize:10];
		label.backgroundColor = [UIColor clearColor];
		label.text = @"Загрузка...";
		label.textColor = [UIColor whiteColor];
		[View addSubview:label];
        [spinningWheel release];
    }
    
    [window addSubview:View];
}

- (void)hideView
{
    [View removeFromSuperview];
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[downloadQueue release];
	[channelArray release];
	[audioArray release];
    [viewController release];
    [window release];
    [super dealloc];
}


@end
