//
//  AudioStore.h
//  ProstoPlay
//
//  Created by Ryzhkov Mihailo on 26.07.10.
//  Copyright 2010 n/a. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AudioStore : NSObject {

	NSString *duration;
	NSString *file_id;
	NSString *link;
	NSString *rate;
	NSString *singer;
	NSString *size;
	NSString *song;
	
}

@property (nonatomic, copy) NSString *duration;
@property (nonatomic, copy) NSString *file_id;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *rate;
@property (nonatomic, copy) NSString *singer;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *song;

@end
