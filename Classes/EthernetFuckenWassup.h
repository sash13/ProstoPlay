//
//  EthernetFuckenWassup.h
//  SampleTestPlay
//
//  Created by Ryzhkov Mihailo on 28.08.10.
//  Copyright 2010 n/a. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#import "TFHpple.h"
#import "SampleTestPlayAppDelegate.h"
#import "EthernetFuckenWassupDelegate.h"



@interface EthernetFuckenWassup : NSObject {
@private
	TFHpple * xpathParser;
	SampleTestPlayAppDelegate *appDelegate;
	NSObject<EthernetFuckenWassupDelegate> *delegate;
	NSString *patch;


	
}

@property (nonatomic, assign) NSObject<EthernetFuckenWassupDelegate> *delegate;

-(void)GetFuckenData:(NSString *)string audio:(NSString *)audio;
//-(void)GetFuckenAudio;

@end
