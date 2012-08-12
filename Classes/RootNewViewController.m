//
//  RootNewViewController.m
//  SampleTestPlay
//
//  Created by Ryzhkov Mihailo on 27.08.10.
//  Copyright 2010 n/a. All rights reserved.
//

#import "RootNewViewController.h"
#import "AudioStore.h"
#import "ChannelStore.h"
#import "EthernetFuckenWassup.h"


////////////////
#import "AudioStreamer.h"
#import <QuartzCore/CoreAnimation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CFNetwork/CFNetwork.h>
////////////////


@interface RootNewViewController (Private)
- (void)loadContentForVisibleCells;
@end

@implementation RootNewViewController
@synthesize types;
@synthesize tableView;
@synthesize patch, fuckenCat;


- (void) refreshChannels:(id)sender {
		NSLog(@"TEST2");

	//[appDelegate showView];
	wassup = [[EthernetFuckenWassup alloc] init];
	wassup.delegate = self;
	[wassup GetFuckenData:@"channel" audio:nil];
}

- (void)update:(EthernetFuckenWassup *)fuck successfully:(NSString *)successMsg {
	

	//[appDelegate hideView];
	[tableView reloadData];
	[self loadContentForVisibleCells]; 
	NSLog(@"update:(EthernetFuckenWassup *)fuck successfully");
}

- (void)update:(EthernetFuckenWassup *)fuck myError:(NSString *)errorMsg {
	//[appDelegate hideView];
	[tableView reloadData];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Внимание" message:@"Проблемы с интернет подключением!"  delegate:self cancelButtonTitle:@"Нихуя не OK" otherButtonTitles: nil];
	[alert show];	
	[alert release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	types = kTypeChannel;
	
	[self.view becomeFirstResponder]; 
	some = 4;
    appDelegate = (SampleTestPlayAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	MPVolumeView *volumeView = [[[MPVolumeView alloc] initWithFrame:volumeSlider.bounds] autorelease];
	[volumeSlider addSubview:volumeView];
	[volumeView sizeToFit];
	
	[self setButtonImage:[UIImage imageNamed:@"playbutton.png"]];
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
}

- (void)loadContentForVisibleCells
{
	if (types == kTypeChannel) {
		NSLog(@"loadContentForVisibleCells");
    NSArray *cells = [tableView visibleCells];
    [cells retain];
    for (int i = 0; i < [cells count]; i++) 
    { 
        // Go through each cell in the array and call its loadContent method if it responds to it.
        ChannelCell *bashCell = (ChannelCell *)[[cells objectAtIndex: i] retain];
        [bashCell loadImage];
        [bashCell release];
        bashCell = nil;
    }
    [cells release];
	}
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	
	[self refreshChannels:0];
	 [self loadContentForVisibleCells]; 
	//self.tableView.rowHeight = 60.0;
	NSLog(@"TEST1");

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	switch (types) {
		case kTypeAudio:
			return [appDelegate.audioArray count];
			//return 20;
			break;
		case kTypeChannel:
			return [appDelegate.channelArray count];
			break;
			
		default:
			NSLog(@"some error");
			break;
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	
    
	
    // Configure the cell...
	if (types == kTypeAudio) {
		
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		}
		AudioStore *camObj = [appDelegate.audioArray objectAtIndex:indexPath.row];
		cell.textLabel.text = camObj.singer;
		cell.detailTextLabel.text = camObj.song;
		cell.imageView.image = nil;
		NSLog(@"http://prostopleer.com/download/%@",camObj.file_id);
		cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rowBackground.png"]];
		return cell;
	} else if (types == kTypeChannel) {

		/*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		}
		
		ChannelStore *camObj = [appDelegate.channelArray objectAtIndex:indexPath.row];
		cell.textLabel.text = camObj.title;
		cell.detailTextLabel.text = camObj.city;
		if (camObj.img)
			//cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://prostopleer.com%@", camObj.img]]]];
			cell.imageView.image = camObj.thumbnail;*/
		ChannelStore *camObj = [appDelegate.channelArray objectAtIndex:indexPath.row];
		static NSString *identifier = @"ItemCell";
		ChannelCell *cell = (ChannelCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
		if (cell == nil) 
		{
			cell = [[[ChannelCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
			cell.delegate = self;
		
		}
		cell.item = camObj;
		
		return cell;
	}
	
    
}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	/*if (types == kTypeAudio) {
		types = kTypeChannel;
	}
	else if (){
		types = kTypeAudio;
	}*/

	
	switch (types) {
		case kTypeChannel:
			types = kTypeAudio;
			ChannelStore *chObj = [appDelegate.channelArray objectAtIndex:indexPath.row];
			patch = chObj.url;
			//patch =  @"/list494181tJqA";
			NSLog(@"patch: %@",patch);
			[wassup GetFuckenData:@"audio" audio:patch];
			[appDelegate.audioArray removeAllObjects];
			break;
		case kTypeAudio:
			NSLog(@"7");
			//if ([streamer isPlaying] || [streamer isPaused]) 
				//[self close:0];
			AudioStore *chOb = [appDelegate.audioArray objectAtIndex:indexPath.row];
			//types = kTypeChannel;
			audio = chOb.file_id;
			//url = [NSURL URLWithString:[NSString stringWithFormat:@"http://prostopleer.com%@", audio]];
			NSLog(@"%@", audio);
			[self setButtonImage:[UIImage imageNamed:@"playbutton.png"]];
			[self destroyStreamer];
			[self buttonPressed:1];
			//[streamer start];
			break;
		default:
			break;
	}
	
	[tableView reloadData];
	
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView; 
{
	NSLog(@"scrollViewDidEndDecelerating");
    [self loadContentForVisibleCells]; 
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    if (!decelerate) 
    {
		NSLog(@"scrollViewDidEndDragging");
        [self loadContentForVisibleCells]; 
    }
}



-(BOOL) canBecomeFirstResponder
{ 
    return YES; 
} 

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event 
{ 
	
	types = kTypeChannel;
	[tableView reloadData];
	[self loadContentForVisibleCells]; 
    NSLog(@"UIEventSubtype %d", some);
    [super motionEnded:motion withEvent:event]; 
}

- (void)viewDidAppear:(BOOL)animated
{ 
    [super viewDidAppear:animated]; 
    [self becomeFirstResponder]; 
} 


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

////////////////////////////////Начало проигрывателя//////////////////////////////////////////////////////////////////////////////////////////
//
// setButtonImage:
//
// Used to change the image on the playbutton. This method exists for
// the purpose of inter-thread invocation because
// the observeValueForKeyPath:ofObject:change:context: method is invoked
// from secondary threads and UI updates are only permitted on the main thread.
//
// Parameters:
//    image - the image to set on the play button.
//
- (void)setButtonImage:(UIImage *)image
{
	[button.layer removeAllAnimations];
	if (!image)
	{
		[button setImage:[UIImage imageNamed:@"playbutton.png"] forState:0];
	}
	else
	{
		[button setImage:image forState:0];
		
		if ([button.currentImage isEqual:[UIImage imageNamed:@"loadingbutton.png"]])
		{
			[self spinButton];
		}
	}
}

- (IBAction)close:(id)sender {
	//[streamer pause];
	[streamer stop];
	//[self setButtonImage:[UIImage imageNamed:@"playbutton.png"]];
	[self.navigationController popViewControllerAnimated:YES]; 
	
}

//
// destroyStreamer
//
// Removes the streamer, the UI update timer and the change notification
//
- (void)destroyStreamer
{
	if (streamer)
	{
		[[NSNotificationCenter defaultCenter]
		 removeObserver:self
		 name:ASStatusChangedNotification
		 object:streamer];
		[progressUpdateTimer invalidate];
		progressUpdateTimer = nil;
		
		[streamer stop];
		[streamer release];
		streamer = nil;
	}
}

//
// createStreamer
//
// Creates or recreates the AudioStreamer object.
//
- (void)createStreamer
{
	if (streamer)
	{
		return;
		NSLog(@"return");
	}
	NSLog(@"not return");
	[self destroyStreamer];
	//http://202.6.74.107:8060/triplej.mp3
	NSString *escapedValue =
	[(NSString *)CFURLCreateStringByAddingPercentEscapes(
														 nil,
														 (CFStringRef)[NSString stringWithFormat:@"http://prostopleer.com/download/%@",audio],
														 NULL,
														 NULL,
														 kCFStringEncodingUTF8)
	 autorelease];
	
	NSURL *url = [NSURL URLWithString:escapedValue];
	streamer = [[AudioStreamer alloc] initWithURL:url];
	
	progressUpdateTimer =
	[NSTimer
	 scheduledTimerWithTimeInterval:0.1
	 target:self
	 selector:@selector(updateProgress:)
	 userInfo:nil
	 repeats:YES];
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(playbackStateChanged:)
	 name:ASStatusChangedNotification
	 object:streamer];
}

//
// viewDidLoad
//
// Creates the volume slider, sets the default path for the local file and
// creates the streamer immediately if we already have a file at the local
// location.
//
/*- (void)viewDidLoad
{
	[super viewDidLoad];
	
	MPVolumeView *volumeView = [[[MPVolumeView alloc] initWithFrame:volumeSlider.bounds] autorelease];
	[volumeSlider addSubview:volumeView];
	[volumeView sizeToFit];
	
	[self setButtonImage:[UIImage imageNamed:@"playbutton.png"]];
	
}*/

//
// spinButton
//
// Shows the spin button when the audio is loading. This is largely irrelevant
// now that the audio is loaded from a local file.
//
- (void)spinButton
{
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	CGRect frame = [button frame];
	button.layer.anchorPoint = CGPointMake(0.5, 0.5);
	button.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
	[CATransaction commit];
	
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
	[CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];
	
	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	animation.fromValue = [NSNumber numberWithFloat:0.0];
	animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
	animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
	animation.delegate = self;
	[button.layer addAnimation:animation forKey:@"rotationAnimation"];
	
	[CATransaction commit];
}

//
// animationDidStop:finished:
//
// Restarts the spin animation on the button when it ends. Again, this is
// largely irrelevant now that the audio is loaded from a local file.
//
// Parameters:
//    theAnimation - the animation that rotated the button.
//    finished - is the animation finised?
//
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)finished
{
	if (finished)
	{
		[self spinButton];
	}
}

//
// buttonPressed:
//
// Handles the play/stop button. Creates, observes and starts the
// audio streamer when it is a play button. Stops the audio streamer when
// it isn't.
//
// Parameters:
//    sender - normally, the play/stop button.
//
- (IBAction)buttonPressed:(id)sender
{
	if ([button.currentImage isEqual:[UIImage imageNamed:@"playbutton.png"]])
	{
		//[downloadSourceField resignFirstResponder];
		
		[self createStreamer];
		[self setButtonImage:[UIImage imageNamed:@"loadingbutton.png"]];
		[streamer start];
	}
	else
	{
		[streamer pause];
	}
}

//
// sliderMoved:
//
// Invoked when the user moves the slider
//
// Parameters:
//    aSlider - the slider (assumed to be the progress slider)
//
- (IBAction)sliderMoved:(UISlider *)aSlider
{
	if (streamer.duration)
	{
		double newSeekTime = (aSlider.value / 100.0) * streamer.duration;
		[streamer seekToTime:newSeekTime];
	}
}

//
// playbackStateChanged:
//
// Invoked when the AudioStreamer
// reports that its playback status has changed.
//
- (void)playbackStateChanged:(NSNotification *)aNotification
{
	if ([streamer isWaiting])
	{
		[self setButtonImage:[UIImage imageNamed:@"loadingbutton.png"]];
	}
	else if ([streamer isPlaying])
	{
		[self setButtonImage:[UIImage imageNamed:@"stopbutton.png"]];
	}
	else if ([streamer isIdle])
	{
		[self destroyStreamer];
		[self setButtonImage:[UIImage imageNamed:@"playbutton.png"]];
		NSLog(@"destroyStreamer");
	}
}

//
// updateProgress:
//
// Invoked when the AudioStreamer
// reports that its playback progress has changed.
//
- (void)updateProgress:(NSTimer *)updatedTimer
{
	if (streamer.bitRate != 0.0)
	{
		double progress = streamer.progress;
		double duration = streamer.duration;
		
		if (duration > 0)
		{
			[positionLabel setText:
			 [NSString stringWithFormat:@"%.1f          %.1f",
			  progress,
			  duration]];
			[progressSlider setEnabled:YES];
			[progressSlider setValue:100 * progress / duration];
		}
		else
		{
			[progressSlider setEnabled:NO];
			NSLog(@"[progressSlider setEnabled:NO];");
		}
	}
	else
	{
		//positionLabel.text = @"Time Played:";
	}
}

//
// textFieldShouldReturn:
//
// Dismiss the text field when done is pressed
//
// Parameters:
//    sender - the text field
//
// returns YES
//
- (BOOL)textFieldShouldReturn:(UITextField *)sender
{
	[sender resignFirstResponder];
	[self createStreamer];
	return YES;
}
//////////////////////////////Конец проигрывателя//////////////////////////////

- (void)dealloc {
	[tempPatch release];
	[audio release];
	[fuckenCat release];
	[patch release];
	[wassup setDelegate:nil];
	[wassup release];
	[appDelegate release];
    [super dealloc];
}



@end
