//
//  RootViewController.m
//  SampleTestPlay
//
//  Created by Ryzhkov Mihailo on 07.08.10.
//  Copyright 2010 n/a. All rights reserved.
//

#import "RootViewController.h"

#import "AudioStore.h"
#import "ChannelStore.h"


@implementation RootViewController

@synthesize types;
#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	types = kTypeChannel;

	[self.view becomeFirstResponder]; 
	some = 4;
    appDelegate = (SampleTestPlayAppDelegate *)[[UIApplication sharedApplication] delegate];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	switch (types) {
		case kTypeAudio:
			return [appDelegate.audioArray count];
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
	
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	
    // Configure the cell...
	if (types == kTypeAudio) {
		AudioStore *camObj = [appDelegate.audioArray objectAtIndex:indexPath.row];
		cell.textLabel.text = camObj.song;
	} else if (types == kTypeChannel) {
		ChannelStore *camObj = [appDelegate.channelArray objectAtIndex:indexPath.row];
		cell.textLabel.text = camObj.url;
	}
   
    return cell;
}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (types == kTypeAudio) {
		types = kTypeChannel;
	}
	else {
		types = kTypeAudio;
	}
	
	[self.tableView reloadData];
}

-(BOOL) canBecomeFirstResponder
{ 
    return YES; 
} 

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event 
{ 
	
	types = kTypeChannel;
	[self.tableView reloadData];
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




- (void)dealloc {

	[appDelegate release];
    [super dealloc];
}


@end

