//
//  EthernetFuckenWassup.m
//  SampleTestPlay
//
//  Created by Ryzhkov Mihailo on 28.08.10.
//  Copyright 2010 n/a. All rights reserved.
//

#import "EthernetFuckenWassup.h"
#import "ASIHTTPRequest.h"
#import "AudioStore.h"
#import "iPhoneStreamingPlayerViewController.h"
#import "ChannelStore.h"

@implementation EthernetFuckenWassup

@synthesize delegate;

-(void)GetFuckenData:(NSString *)string audio:(NSString *)audio
{
	
	appDelegate = (SampleTestPlayAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	patch = string;

	/*NSURL *url = [NSURL URLWithString:@"http://prostopleer.com/top?rand=1280150366392"];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    [request setDelegate:self];
    //[request setDidFinishSelector:@selector(requestDone:)];
    //[request setDidFailSelector:@selector(requestWentWrong:)];
	[request addRequestHeader:@"User-Agent" value:@"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; ru; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6"];
	[request addRequestHeader:@"X-Requested-With" value:@"XMLHttpRequest"];
	[request addRequestHeader:@"Referer" value:@"http://prostopleer.com/"];
    NSOperationQueue *queue = [SampleTestPlayAppDelegate sharedAppDelegate].downloadQueue;
    [queue addOperation:request];
    [request release]; 
	*/
	NSURL *url;
	if ([string isEqualToString:@"channel"]) 
		url = [NSURL URLWithString:@"http://prostopleer.com/top?rand=1280150366392"];
		//url = [NSURL URLWithString:@"http://music.yandex.ru/xml/top.xml?top=tracks&genre=all"];
	else if ([string isEqualToString:@"audio"])
		url = [NSURL URLWithString:[NSString stringWithFormat:@"http://prostopleer.com%@", audio]];
	
	NSLog(@"%@", url);
	//NSURL *url = [NSURL URLWithString:@"http://prostopleer.com/top?rand=1280150366392"];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request addRequestHeader:@"User-Agent" value:@"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; ru; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6"];
	[request addRequestHeader:@"X-Requested-With" value:@"XMLHttpRequest"];
	[request addRequestHeader:@"Referer" value:@"http://prostopleer.com/"];
	[request startAsynchronous];
		NSLog(@"TEST3");
	
	
	
	/*
	NSString *filePath = [self dataFilePath:FALSE];
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
	xpathParser = [[TFHpple alloc] initWithHTMLData:xmlData];
	NSArray * title = [xpathParser search:@"//div[@class='b-track__title']"];
	for (TFHppleElement*sik in title) {
		NSLog(@"%@", [[sik dig] objectForKey:0] );
	}*/
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSLog(@"TEST3error");
	[delegate update:self myError:@"error"];
	
}

- (NSString *)dataFilePath:(BOOL)forSave {
    return [[NSBundle mainBundle] pathForResource:@"topAll" ofType:@"xml"];
}
	

//-(void)myfu
- (void)requestFinished:(ASIHTTPRequest *)request
{
	//NSData *response = [request responseData];
	
	/*xpathParser = [[TFHpple alloc] initWithHTMLData:response];
	//NSArray * title = [xpathParser search:@"//div[@classs='b-track']"];
	NSArray * title = [xpathParser search:@"//div[@class='b-track__title']"];
	for (TFHppleElement*sik in title) {
		NSLog(@"%@", sik );
	}*/
	
	
	NSLog(@"TEST3yes");
	//NSString *badStr = @"";
	
	NSString *response = [request responseString];
	//NSLog(@"%@", response);
	NSDictionary *results = [response JSONValue];
	
	response = [results objectForKey:@"html"];
	//NSLog(@"%@", response);
	NSData* data=[response dataUsingEncoding:NSUTF8StringEncoding];
	//NSData* data=[response dataUsingEncoding:NSISOLatin1StringEncoding];
	xpathParser = [[TFHpple alloc] initWithHTMLData:data];
	//NSLog(@"%@", data);
	
	
	if ([patch isEqualToString:@"channel"]) {
	
	//NSArray * link = [xpathParser search:@"//li//a//@href"];
	NSArray * title = [xpathParser search:@"//li//a"];
		
	NSArray * city = [xpathParser search:@"//li"];
	int cityHook = 0;
	NSArray * img = [xpathParser search:@"//li//a//img//@src"];
	//NSLog(@"%@",response);
	for (TFHppleElement*sik in title) {
		//if (![[sik content] isEqualToString:badStr]) {
		if ([sik content]) {
		ChannelStore *audioObj = [[ChannelStore alloc] autorelease];

			audioObj.title = [sik content];
			audioObj.url = [sik objectForKey:@"href"];
			audioObj.city = [[city objectAtIndex:cityHook] content];
			audioObj.img = [[img objectAtIndex:cityHook] content];
		NSLog(@"nook %@ %@ \n", [sik content], [sik objectForKey:@"href"]);
			cityHook++;
		[appDelegate addChannel:audioObj];
			//NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat:@"http://prostopleer.com%@", audioObj.img]];
			//[audioObj loadURL:urls];
		//}
		//NSDictionary * translatedAttributes = [sik dig];
		//NSLog(@"%@",[translatedAttributes objectForKey:TFHppleNodeAttributeArrayKey]);
		
		}
		
		//[audioObj release];
		
		//if (![badStr isEqualToString:[sik content]]) {
		//	NSLog(@"%@",badStr );
		
		//badStr = [sik content];
		
		//}
		//NSLog(@"%@",[sik content] );
		//NSLog(@"%@",[[sik attributes] objectForKey:@"song"]);
		//NSLog(@"%@\n\n",[[sik attributes] objectForKey:@"file_id"]);
	}
	
		
	} else if ([patch isEqualToString:@"audio"]) {
		
		NSArray * imgfull = [xpathParser search:@"//li"];
		
		for (TFHppleElement*sik in imgfull) {
			AudioStore *audioObj = [[AudioStore alloc] autorelease];
			audioObj.song = [[sik attributes] objectForKey:@"song"];
			audioObj.file_id = [[sik attributes] objectForKey:@"file_id"];
			
			audioObj.duration = [[sik attributes] objectForKey:@"duration"];
			audioObj.link = [[sik attributes] objectForKey:@"link"];
			audioObj.rate = [[sik attributes] objectForKey:@"rate"];
			audioObj.singer = [[sik attributes] objectForKey:@"singer"];
			audioObj.size = [[sik attributes] objectForKey:@"size"];
			[appDelegate addAudio:audioObj];
			//[audioObj release];
			//[delegate update:self successfully:@"Ok"];

			//NSLog(@"%@",[sik attributes] );
			//NSLog(@"%@",[[sik attributes] objectForKey:@"song"]);
			//NSLog(@"%@\n\n",[[sik attributes] objectForKey:@"file_id"]);
		}
	}
	
	[delegate update:self successfully:@"Ok"];
	
}


- (void)dealloc {
	[patch release];
	[xpathParser release];
    [super dealloc];
}
@end
