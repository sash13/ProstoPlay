//
//  ChannelStore.m
//  ProstoPlay
//
//  Created by Ryzhkov Mihailo on 26.07.10.
//  Copyright 2010 n/a. All rights reserved.
//


#import "ChannelStore.h"
#import "ASIHTTPRequest.h"

@interface ChannelStore (Private)
- (void)loadURL:(NSURL *)urli;
@end

@implementation ChannelStore
@synthesize url, title, img, city, thumbnail;
@synthesize delegate;

- (UIImage *)thumbnail
{
    if (thumbnail == nil)
    {

        NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat:@"http://prostopleer.com%@", self.img]];

	    [self loadURL:urls];
    }
    return thumbnail;
}


- (NSString *) yesOrNo:(NSString *)string {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	//documentsDir = [documentsDir stringByAppendingPathComponent:@"tumb/"];
	NSString *newDocumentsDir = [documentsDir stringByAppendingPathComponent:@"tumb/"];
	
	return [newDocumentsDir stringByAppendingPathComponent:string];
}



- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSString *Path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"non.png"];
	UIImage *remoteImage = [[UIImage alloc] initWithContentsOfFile:Path];
	self.thumbnail = remoteImage;
    if ([delegate respondsToSelector:@selector(prosto:didLoadThumbnail:)])
    {
        [delegate prosto:self didLoadThumbnail:self.thumbnail];
    }
    [remoteImage release];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	
	NSLog(@"load");
	NSData *data = [request responseData];
    UIImage *remoteImage = [[UIImage alloc] initWithData:data];
    self.thumbnail = remoteImage;
    if ([delegate respondsToSelector:@selector(prosto:didLoadThumbnail:)])
    {
        [delegate prosto:self didLoadThumbnail:self.thumbnail];
		//NSLog(@"delegate prosto:self didLoadThumbnail:self.thumbnail");
    }
    [remoteImage release];
}
	



- (void)loadURL:(NSURL *)urli
{
	NSArray *listItems = [self.img componentsSeparatedByString:@"/"];
	NSString *MyTumb = [listItems lastObject];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	
	NSString *dbPath = [self yesOrNo:MyTumb];
	//NSLog(@"load %@", dbPath);
	BOOL success = [fileManager fileExistsAtPath:dbPath]; 
	if(!success) {
		
		/*ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
		[request setDelegate:self];
		[request setDidFinishSelector:@selector(requestDone:)];
		[request setDidFailSelector:@selector(requestWentWrong:)];
		[request setDownloadDestinationPath:dbPath];
		NSOperationQueue *queue = [BashComicsAppDelegate sharedAppDelegate].downloadQueue;
		[queue addOperation:request];
		[request release];  */
		
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:urli];
		[request setDelegate:self];
		[request addRequestHeader:@"User-Agent" value:@"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; ru; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6"];
		[request addRequestHeader:@"X-Requested-With" value:@"XMLHttpRequest"];
		[request addRequestHeader:@"Referer" value:@"http://prostopleer.com/"];
		[request setDownloadDestinationPath:dbPath];
		[request startAsynchronous];
	}
	else {
	
		UIImage *remoteImage = [[UIImage alloc] initWithContentsOfFile:dbPath];
		self.thumbnail = remoteImage;
		if ([delegate respondsToSelector:@selector(prosto:didLoadThumbnail:)])
		{
			[delegate prosto:self didLoadThumbnail:self.thumbnail];
		}
		[remoteImage release];
	}
	
}


- (BOOL)hasLoadedThumbnail
{
    return (thumbnail != nil);
}

- (void) dealloc {
	delegate = nil;
	[url release];
	[title release];
	[img release];

	[city release];
	[thumbnail retain];
	
	
	[super dealloc];
}
@end
