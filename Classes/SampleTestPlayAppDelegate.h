//
//  SampleTestPlayAppDelegate.h
//  SampleTestPlay
//
//  Created by Ryzhkov Mihailo on 07.08.10.
//  Copyright n/a 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@class AudioStore;
@class ChannelStore;

@interface SampleTestPlayAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;

	RootViewController *viewController;
	
	NSMutableArray *audioArray;
	NSMutableArray *channelArray;
	
	NSOperationQueue *downloadQueue;
	
	UIView *View;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RootViewController *viewController;

@property (nonatomic, retain) NSMutableArray *audioArray;
@property (nonatomic, retain) NSMutableArray *channelArray;


@property (nonatomic, retain) NSOperationQueue *downloadQueue;

+ (SampleTestPlayAppDelegate *)sharedAppDelegate;
- (void) addAudio:(AudioStore *)audioObj;
- (void) addChannel:(ChannelStore *)channelObj;

- (void)showView;
- (void)hideView;

- (void) createTumbIfNo;
- (NSString *) getFileTumb;
@end

