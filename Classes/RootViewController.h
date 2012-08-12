//
//  RootViewController.h
//  SampleTestPlay
//
//  Created by Ryzhkov Mihailo on 07.08.10.
//  Copyright 2010 n/a. All rights reserved.
//

#import <UIKit/UIKit.h>

/*typedef enum _WhatTheView {
	kTypeChannel = 0,
    kTypeAudio = 1,
	kTypePlaylist = 2,
} WhatTheView;
*/

typedef enum 
{
	kTypeChannel,
	kTypeAudio,
	kTypePlaylist
} Animals;

@interface RootViewController : UITableViewController {
	
	SampleTestPlayAppDelegate *appDelegate;
	Animals types;
	int some;

}

@property (nonatomic) Animals types;

@end
