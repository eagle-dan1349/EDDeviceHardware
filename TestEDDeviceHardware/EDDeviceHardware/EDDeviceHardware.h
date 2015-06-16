//
//  EDDeviceHardware.h
//  EDDeviceHardware
//
//  Created by Daniil Eagle-dan Orlov on 9/6/12.
//  Copyright (c) 2012 Daniil Eagle-dan Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>



#pragma mark - Defining Friendly iOS Devices names
// -- iPhones
extern NSString* const kEDDHiPhone;
extern NSString* const kEDDHiPhone3G;
extern NSString* const kEDDHiPhone3GS;
extern NSString* const kEDDHiPhone4GSM;
extern NSString* const kEDDHiPhone4CDMA;
extern NSString* const kEDDHiPhone4S;
extern NSString* const kEDDHiPhone5GSM;
extern NSString* const kEDDHiPhone5CDMA;
extern NSString* const kEDDHiPhone5C;
extern NSString* const kEDDHiPhone5S;
extern NSString* const kEDDHiPhone6;
extern NSString* const kEDDHiPhone6Plus;

// -- iPods
extern NSString* const kEDDHiPodTouch;
extern NSString* const kEDDHiPodTouch2;
extern NSString* const kEDDHiPodTouch3;
extern NSString* const kEDDHiPodTouch4;
extern NSString* const kEDDHiPodTouch5;

// -- iPads
extern NSString* const kEDDHiPad;
extern NSString* const kEDDHiPad2WiFi;
extern NSString* const kEDDHiPad2GSM;
extern NSString* const kEDDHiPad2CDMA;
extern NSString* const kEDDHiPad3WiFi;
extern NSString* const kEDDHiPad3ATT;
extern NSString* const kEDDHiPad3Verizon;
extern NSString* const kEDDHiPad4WiFi;
extern NSString* const kEDDHiPad4ATT;
extern NSString* const kEDDHiPad4Verizon;
extern NSString* const kEDDHiPadAirWiFi;
extern NSString* const kEDDHiPadAirCellular;
extern NSString* const kEDDHiPadAirTDLTE;
extern NSString* const kEDDHiPadAir2WiFi;
extern NSString* const kEDDHiPadAir2Cellular;

// -- iPad Minis
extern NSString* const kEDDHiPadMiniWiFi;
extern NSString* const kEDDHiPadMiniATT;
extern NSString* const kEDDHiPadMiniVerizon;
extern NSString* const kEDDHiPadMini2Wifi;
extern NSString* const kEDDHiPadMini2Cellular;
extern NSString* const kEDDHiPadMini2China;
extern NSString* const kEDDHiPadMini3Wifi;
extern NSString* const kEDDHiPadMini3Cellular;
extern NSString* const kEDDHiPadMini3China;

// -- simulators
extern NSString* const kSimulatorIntelI386;
extern NSString* const kSimulatorIntelX86_64;

// -- unknown or newer than implementation time...
extern NSString* const kUnknownPlatform;



@interface EDDeviceHardware : NSObject

@property(nonatomic, readonly) NSString* platformName;
@property(nonatomic, readonly) NSString* platformCode;

+ (EDDeviceHardware*) currentDevice;

@end
