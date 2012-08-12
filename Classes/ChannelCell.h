//
//  ChannelCell.h
//  SampleTestPlay
//
//  Created by Ryzhkov Mihailo on 03.09.10.
//  Copyright 2010 n/a. All rights reserved.
//
@class ChannelCell;

@protocol ChannelCellDelegate

@required

@end



#import <UIKit/UIKit.h>
#import "ChannelStore.h"

@class ChannelStore;

@interface ChannelCell : UITableViewCell <ChannelStoreDelegate> {
@private
	ChannelStore *item;
	/*UILabel *textLabel;
	UILabel *detailTextLabel;
	UIImageView *imageView;*/
	UIActivityIndicatorView *scrollingWheel;
	UIImageView *photo;
	NSObject<ChannelCellDelegate> *delegate;


}

@property (nonatomic, retain) ChannelStore *item;
@property (nonatomic, assign) NSObject<ChannelCellDelegate> *delegate;
/*@property (nonatomic,retain) UILabel *textLabel;
@property (nonatomic,retain) UILabel *detailTextLabel;
@property (nonatomic,retain) UIImageView *imageView;
*/
- (void)loadImage;
@end
