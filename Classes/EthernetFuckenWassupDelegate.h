//
//  EthernetFuckenWassupDelegate.h
//  SampleTestPlay
//
//  Created by Ryzhkov Mihailo on 28.08.10.
//  Copyright 2010 n/a. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EthernetFuckenWassup;

@protocol EthernetFuckenWassupDelegate

@required
- (void)update:(EthernetFuckenWassup *)fuck successfully:(NSString *)successMsg;
- (void)update:(EthernetFuckenWassup *)fuck myError:(NSString *)errorMsg;

@end
