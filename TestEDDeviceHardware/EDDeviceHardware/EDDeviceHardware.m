//
//  EDDeviceHardware.m
//  EDDeviceHardware
//
//  Created by Daniil Orlov on 9/6/12.
//  Copyright (c) 2012 Daniil Orlov. All rights reserved.
//

#import "EDDeviceHardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>



#pragma mark - Defining Friendly iOS Devices names
// -- iPhones
NSString* const kEDDHiPhone         = @"iPhone (EDGE)";
NSString* const kEDDHiPhone3G       = @"iPhone 3G";
NSString* const kEDDHiPhone3GS      = @"iPhone 3GS";
NSString* const kEDDHiPhone4GSM     = @"iPhone 4 (GSM)";
NSString* const kEDDHiPhone4CDMA    = @"iPhone 4 (CDMA)";
NSString* const kEDDHiPhone4S       = @"iPhone 4S";
NSString* const kEDDHiPhone5GSM     = @"iPhone 5 (GSM)";
NSString* const kEDDHiPhone5CDMA    = @"iPhone 5 (CDMA)";
NSString* const kEDDHiPhone5C       = @"iPhone 5C";
NSString* const kEDDHiPhone5S       = @"iPhone 5S";
NSString* const kEDDHiPhone6        = @"iPhone 6";
NSString* const kEDDHiPhone6Plus    = @"iPhone 6 Plus";

// -- iPods
NSString* const kEDDHiPodTouch  = @"iPod Touch";
NSString* const kEDDHiPodTouch2 = @"iPod Touch 2";
NSString* const kEDDHiPodTouch3 = @"iPod Touch 3";
NSString* const kEDDHiPodTouch4 = @"iPod Touch 4";
NSString* const kEDDHiPodTouch5 = @"iPod Touch 5";

// -- iPads
NSString* const kEDDHiPad             = @"iPad";
NSString* const kEDDHiPad2WiFi        = @"iPad 2 WiFi";
NSString* const kEDDHiPad2GSM         = @"iPad 2 GSM";
NSString* const kEDDHiPad2CDMA        = @"iPad 2 CDMA";
NSString* const kEDDHiPad3WiFi        = @"iPad 3 WiFi";
NSString* const kEDDHiPad3ATT         = @"iPad 3 AT&T";
NSString* const kEDDHiPad3Verizon     = @"iPad 3 Verizon";
NSString* const kEDDHiPad4WiFi        = @"iPad 4 WiFi";
NSString* const kEDDHiPad4ATT         = @"iPad 4 AT&T";
NSString* const kEDDHiPad4Verizon     = @"iPad 4 Verizon";
NSString* const kEDDHiPadAirWiFi      = @"iPad Air WiFi";
NSString* const kEDDHiPadAirCellular  = @"iPad Air Cellular";
NSString* const kEDDHiPadAirTDLTE     = @"iPad Air TD-LTE";
NSString* const kEDDHiPadAir2WiFi     = @"iPad Air 2 WiFi";
NSString* const kEDDHiPadAir2Cellular = @"iPad Air 2 Cellular";

// -- iPad Minis
NSString* const kEDDHiPadMiniWiFi      = @"iPad Mini WiFi";
NSString* const kEDDHiPadMiniATT       = @"iPad Mini AT&T";
NSString* const kEDDHiPadMiniVerizon   = @"iPad Mini Verizon";
NSString* const kEDDHiPadMini2Wifi     = @"iPad Mini 2 Wifi";
NSString* const kEDDHiPadMini2Cellular = @"iPad Mini 2 Cellular";
NSString* const kEDDHiPadMini2China    = @"iPad Mini 2 China";
NSString* const kEDDHiPadMini3Wifi     = @"iPad Mini 3 Wifi";
NSString* const kEDDHiPadMini3Cellular = @"iPad Mini 3 Cellular";
NSString* const kEDDHiPadMini3China    = @"iPad Mini 3 China";

// -- simulators
NSString* const kSimulatorIntelI386 = @"Simulator (Intel i386)";
NSString* const kSimulatorIntelX86_64 = @"Simulator (Intel x86_64)";

// -- unknown or newer than implementation time...
NSString* const kUnknownPlatform = @"Unknown";



@interface EDDeviceHardware ()
{
    NSString* _platformName;
    NSString* _platformCode;
}

- (NSString*) getPlatformCode;
- (NSString*) getPlatformName;

@end

@implementation EDDeviceHardware

@synthesize platformName = _platformName;
@synthesize platformCode = _platformCode;

#pragma mark - Singleton allocation
static EDDeviceHardware* _sharedInstance = nil;

+ (EDDeviceHardware*) currentDevice
{
    @synchronized(self)
    {
        if (!_sharedInstance)
        {
            _sharedInstance = [[EDDeviceHardware alloc] init];
        }
    }
    return _sharedInstance;
}

+ (id) allocWithZone: (NSZone*) zone
{
    @synchronized(self)
    {
        if(_sharedInstance == nil)
        {
            _sharedInstance = [super allocWithZone:zone];
            return _sharedInstance;
        }
    }
    return nil;
}

#pragma mark - Actual methods
//actual methods of instance are likely to be here

//No methods only one property :P

#pragma mark - Inner utility methods
//specific inner methods that are hidden from user
- (NSString*) getPlatformCode
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

- (NSString*) getPlatformName
{
    /* Source: http://www.everymac.com */
    NSDictionary *platforms = @{/* iPhone */
                                @"iPhone1,1": kEDDHiPhone,
                                @"iPhone1,2": kEDDHiPhone3G,  /* Also, iPhone 3G,  China only (no Wi-Fi) */
                                @"iPhone2,1": kEDDHiPhone3GS, /* Also, iPhone 3GS, China only (no Wi-Fi) */
                                @"iPhone3,1": kEDDHiPhone4GSM,
                                @"iPhone3,2": kEDDHiPhone4GSM,  /* Wikipedia has this model, but not found on everymac */
                                @"iPhone3,3": kEDDHiPhone4CDMA, /* (Verizon, Sprint) */
                                @"iPhone4,1": kEDDHiPhone4S,    /* GSM and CDMA. Also, iPhone 4S, China only (Wi-Fi replaced by its Chinese equivalent: WAPI) */
                                @"iPhone5,1": kEDDHiPhone5GSM,  /* Multiple versions of this iPhone exists, each supporting different communication bands; all GSM though */
                                @"iPhone5,2": kEDDHiPhone5CDMA, /* Also, iPhone 5 CDMA China only (no LTE, but UIM and Wi-Fi replaced by its Chinese equivalent: WAPI) */
                                @"iPhone5,3": kEDDHiPhone5C,    /* GSM and CDMA */
                                @"iPhone5,4": kEDDHiPhone5C,    /* GSM and CDMA; other countries than previous model. */
                                @"iPhone6,1": kEDDHiPhone5S,    /* GSM and CDMA */
                                @"iPhone6,2": kEDDHiPhone5S,    /* GSM and CDMA; other countries than previous model. */
                                @"iPhone7,1": kEDDHiPhone6Plus, /* GSM, CDMA & Global */
                                @"iPhone7,2": kEDDHiPhone6,     /* GSM, CDMA & Global */
                                /* iPods */
                                @"iPod1,1": kEDDHiPodTouch,
                                @"iPod2,1": kEDDHiPodTouch2, /* 2009 & 2010 */
                                @"iPod3,1": kEDDHiPodTouch3,
                                @"iPod4,1": kEDDHiPodTouch4, /* 2011 & 2012, with and without FaceTime */
                                @"iPod5,1": kEDDHiPodTouch5,
                                /* iPads */
                                @"iPad1,1": kEDDHiPad, /* With and without 3G/GPS */
                                @"iPad2,1": kEDDHiPad2WiFi,
                                @"iPad2,2": kEDDHiPad2GSM,
                                @"iPad2,3": kEDDHiPad2CDMA,
                                @"iPad2,4": kEDDHiPad2WiFi, /* Don't know the difference with iPad2,1... */
                                @"iPad2,5": kEDDHiPadMiniWiFi,
                                @"iPad2,6": kEDDHiPadMiniATT,
                                @"iPad2,7": kEDDHiPadMiniVerizon,
                                @"iPad3,1": kEDDHiPad3WiFi,
                                @"iPad3,2": kEDDHiPad3Verizon,
                                @"iPad3,3": kEDDHiPad3ATT,
                                @"iPad3,4": kEDDHiPad4WiFi,
                                @"iPad3,5": kEDDHiPad4ATT,
                                @"iPad3,6": kEDDHiPad4Verizon,
                                @"iPad4,1": kEDDHiPadAirWiFi,
                                @"iPad4,2": kEDDHiPadAirCellular,
                                @"iPad4,3": kEDDHiPadAirTDLTE, /* China */
                                @"iPad4,4": kEDDHiPadMini2Wifi,
                                @"iPad4,5": kEDDHiPadMini2Cellular,
                                @"iPad4,6": kEDDHiPadMini2China,
                                @"iPad4,7": kEDDHiPadMini3Wifi,
                                @"iPad4,8": kEDDHiPadMini3Cellular,
                                @"iPad4,9": kEDDHiPadMini3China,
                                @"iPad5,3": kEDDHiPadAir2WiFi,
                                @"iPad5,4": kEDDHiPadAir2Cellular,
                                /* Simulators */
                                @"i386":   kSimulatorIntelI386,
                                @"x86_64": kSimulatorIntelX86_64
                                };
    
    NSString* platformName = platforms[_platformCode];
    if (platformName == nil) platformName = kUnknownPlatform;
    
    return [[platformName retain] autorelease];
}

#pragma mark - Singleton initialization
- (id) init
{
    self = [super init];
    
    if (self != nil)
    {
        //Custom initialization
        
        //Logics behind is the following: our program is not likely to suddenly teleport to other device,
        //Therefore, we initialize our code and name only once.
        
        if (_platformCode == nil) {
            _platformCode = [[self getPlatformCode] retain];
        }
        
        if (_platformName == nil) {
            _platformName = [[self getPlatformName] retain];
        }
    }
    
    return self;
}

- (id) retain
{
    return self;
}

- (oneway void) release
{
    // Does nothing here.
}

- (id) autorelease
{
    return self;
}

- (NSUInteger) retainCount
{
    return NSUIntegerMax;
}

@end
