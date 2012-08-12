//
//  ChannelStore.h
//  ProstoPlay
//
//  Created by Ryzhkov Mihailo on 26.07.10.
//  Copyright 2010 n/a. All rights reserved.
//

@class ChannelStore;

@protocol ChannelStoreDelegate

@required
- (void)prosto:(ChannelStore *)thumbnail couldNotLoadImageError:(NSError *)error;

@optional
- (void)prosto:(ChannelStore *)thumbnail didLoadThumbnail:(UIImage *)image;

@end





#import <Foundation/Foundation.h>


@interface ChannelStore : NSObject {
	NSString *url;
	NSString *title;
	NSString *img;
	NSString *city;
	UIImage *thumbnail;
	
    NSObject<ChannelStoreDelegate> *delegate;

}
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, retain) UIImage *thumbnail;

@property (nonatomic, assign) NSObject<ChannelStoreDelegate> *delegate;

- (BOOL)hasLoadedThumbnail;
@end
