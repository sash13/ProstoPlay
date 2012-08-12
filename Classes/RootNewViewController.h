//
//  RootNewViewController.h
//  SampleTestPlay
//
//  Created by Ryzhkov Mihailo on 27.08.10.
//  Copyright 2010 n/a. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EthernetFuckenWassup.h"
#import "ChannelCell.h"

@class EthernetFuckenWassup;


@class AudioStreamer;

typedef enum 
{
	kTypeChannel,
	kTypeAudio,
	kTypePlaylist
} Store;

@interface RootNewViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, EthernetFuckenWassupDelegate, ChannelCellDelegate> {

	SampleTestPlayAppDelegate *appDelegate;
	EthernetFuckenWassup *wassup;
	Store types;
	int some;
	IBOutlet UITableView *tableView;
	NSString *patch;
	NSString *audio;
	NSString *tempPatch;
	NSArray *fuckenCat;
	
	/////////////////////
	IBOutlet UILabel *info;
	IBOutlet UIButton *button;
	IBOutlet UIView *volumeSlider;
	IBOutlet UILabel *positionLabel;
	IBOutlet UISlider *progressSlider;
	AudioStreamer *streamer;
	NSTimer *progressUpdateTimer;
	/////////////////////

}

@property (nonatomic) Store types;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSString *patch;
@property (nonatomic, retain) NSString *audio;
@property (nonatomic, retain) NSString *tempPatch;
@property (nonatomic, retain) NSArray *fuckenCat;


//////////////////////
- (IBAction)buttonPressed:(id)sender;
- (IBAction)close:(id)sender;
- (void)spinButton;
- (void)updateProgress:(NSTimer *)aNotification;
- (IBAction)sliderMoved:(UISlider *)aSlider;
//////////////////////
@end
