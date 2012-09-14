//
//  EDDeviceHardware.h
//  EDDeviceHardware
//
//  Created by Daniil Eagle-dan Orlov on 9/6/12.
//  Copyright (c) 2012 Daniil Eagle-dan Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDDeviceHardware : NSObject

// -- iPhones
extern NSString* const kEDDHiPhone1G;
extern NSString* const kEDDHiPhone3G;
extern NSString* const kEDDHiPhone3GS;
extern NSString* const kEDDHiPhone4;
extern NSString* const kEDDHVerizoniPhone4;
extern NSString* const kEDDHiPhone4S;

// -- iPods
extern NSString* const kEDDHiPodTouch1G;
extern NSString* const kEDDHiPodTouch2G;
extern NSString* const kEDDHiPodTouch3G;
extern NSString* const kEDDHiPodTouch4G;

// -- iPads
extern NSString* const kEDDHiPad;
extern NSString* const kEDDHiPad2WiFi;
extern NSString* const kEDDHiPad2GSM;
extern NSString* const kEDDHiPad2CDMA;

// -- simulators
extern NSString* const kSimulatorIntelI386;
extern NSString* const kSimulatorIntelX86_64;

// -- unknown or Super-New
extern NSString* const kUnknownPlatform;

@property(nonatomic, readonly) NSString* platformName;
@property(nonatomic, readonly) NSString* platformCode;

+ (EDDeviceHardware*) currentDevice;

@end
