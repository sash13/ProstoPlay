//
//  AudioStore.m
//  ProstoPlay
//
//  Created by Ryzhkov Mihailo on 26.07.10.
//  Copyright 2010 n/a. All rights reserved.
//

#import "AudioStore.h"


@implementation AudioStore

@synthesize duration, file_id,link, rate,singer,size,song ;



- (void) dealloc {
	[duration release];
	[file_id release];
	[link release];
	[rate release];
	[singer release];
	[size release];
	[song release];

	
	[super dealloc];
}
@end
