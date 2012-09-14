//
//  EDDeviceHardware.m
//  Pic Frame
//
//  Created by Daniil Orlov on 9/6/12.
//  Copyright (c) 2012 Daniil Orlov. All rights reserved.
//

#import "EDDeviceHardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>

#pragma mark - Defining platform system names
// -- iPhones
#define K_PLATFORM_IPHONE_1_1 @"iPhone1,1"
#define K_PLATFORM_IPHONE_1_2 @"iPhone1,2"
#define K_PLATFORM_IPHONE_2_1 @"iPhone2,1"
#define K_PLATFORM_IPHONE_3_1 @"iPhone3,1"
#define K_PLATFORM_IPHONE_3_3 @"iPhone3,3"
#define K_PLATFORM_IPHONE_4_1 @"iPhone4,1"
// -- iPods
#define K_PLATFORM_IPOD_1_1 @"iPod1,1"
#define K_PLATFORM_IPOD_2_1 @"iPod2,1"
#define K_PLATFORM_IPOD_3_1 @"iPod3,1"
#define K_PLATFORM_IPOD_4_1 @"iPod4,1"
// -- iPads
#define K_PLATFORM_IPAD_1_1 @"iPad1,1"
#define K_PLATFORM_IPAD_2_1 @"iPad2,1"
#define K_PLATFORM_IPAD_2_2 @"iPad2,2"
#define K_PLATFORM_IPAD_2_3 @"iPad2,3"
// -- Simulators
#define K_PLATFORM_I386 @"i386"
#define K_PLATFORM_X86_64 @"x86_64"

#pragma mark - Defining user-friendly device names
// -- iPhones
#define K_DEVICE_IPHONE_1_1 @"iPhone 1G"
#define K_DEVICE_IPHONE_1_2 @"iPhone 3G"
#define K_DEVICE_IPHONE_2_1 @"iPhone 3GS"
#define K_DEVICE_IPHONE_3_1 @"iPhone 4"
#define K_DEVICE_IPHONE_3_3 @"Verizon iPhone 4"
#define K_DEVICE_IPHONE_4_1 @"iPhone 4S"
// -- iPods
#define K_DEVICE_IPOD_1_1 @"iPod Touch 1G"
#define K_DEVICE_IPOD_2_1 @"iPod Touch 2G"
#define K_DEVICE_IPOD_3_1 @"iPod Touch 3G"
#define K_DEVICE_IPOD_4_1 @"iPod Touch 4G"
// -- iPads
#define K_DEVICE_IPAD_1_1 @"iPad"
#define K_DEVICE_IPAD_2_1 @"iPad 2 (WiFi)"
#define K_DEVICE_IPAD_2_2 @"iPad 2 (GSM)"
#define K_DEVICE_IPAD_2_3 @"iPad 2 (CDMA)"
// -- Simulators
#define K_DEVICE_I386 @"Simulator (Intel i386)"
#define K_DEVICE_X86_64 @"Simulator (Intel x86_64)"
// -- Unknown device
#define K_DEVICE_UNKNOWN @"Unknown"

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

// -- iPhones
NSString* const kEDDHiPhone1G = K_DEVICE_IPHONE_1_1;
NSString* const kEDDHiPhone3G = K_DEVICE_IPHONE_1_2;
NSString* const kEDDHiPhone3GS = K_DEVICE_IPHONE_2_1;
NSString* const kEDDHiPhone4 = K_DEVICE_IPHONE_3_1;
NSString* const kEDDHVerizoniPhone4 = K_DEVICE_IPHONE_3_3;
NSString* const kEDDHiPhone4S = K_DEVICE_IPHONE_4_1;

// -- iPods
NSString* const kEDDHiPodTouch1G = K_DEVICE_IPOD_1_1;
NSString* const kEDDHiPodTouch2G = K_DEVICE_IPOD_2_1;
NSString* const kEDDHiPodTouch3G = K_DEVICE_IPOD_3_1;
NSString* const kEDDHiPodTouch4G = K_DEVICE_IPOD_4_1;

// -- iPads
NSString* const kEDDHiPad = K_DEVICE_IPAD_1_1;
NSString* const kEDDHiPad2WiFi = K_DEVICE_IPAD_2_1;
NSString* const kEDDHiPad2GSM = K_DEVICE_IPAD_2_2;
NSString* const kEDDHiPad2CDMA = K_DEVICE_IPAD_2_3;

// -- simulators
NSString* const kSimulatorIntelI386 = K_DEVICE_I386;
NSString* const kSimulatorIntelX86_64 = K_DEVICE_X86_64;

// -- unknown or Super-New
NSString* const kUnknownPlatform = K_DEVICE_UNKNOWN;

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
    NSArray* platformNames = [[NSArray alloc] initWithObjects:
                              K_PLATFORM_IPHONE_1_1,
                              K_PLATFORM_IPHONE_1_2,
                              K_PLATFORM_IPHONE_2_1,
                              K_PLATFORM_IPHONE_3_1,
                              K_PLATFORM_IPHONE_3_3,
                              K_PLATFORM_IPHONE_4_1,
                              K_PLATFORM_IPOD_1_1,
                              K_PLATFORM_IPOD_2_1,
                              K_PLATFORM_IPOD_3_1,
                              K_PLATFORM_IPOD_4_1,
                              K_PLATFORM_IPAD_1_1,
                              K_PLATFORM_IPAD_2_1,
                              K_PLATFORM_IPAD_2_2,
                              K_PLATFORM_IPAD_2_3,
                              K_PLATFORM_I386,
                              K_PLATFORM_X86_64,
                              nil];
    
    NSArray* deviceNames = [[NSArray alloc] initWithObjects:
                            K_DEVICE_IPHONE_1_1,
                            K_DEVICE_IPHONE_1_2,
                            K_DEVICE_IPHONE_2_1,
                            K_DEVICE_IPHONE_3_1,
                            K_DEVICE_IPHONE_3_3,
                            K_DEVICE_IPHONE_4_1,
                            K_DEVICE_IPOD_1_1,
                            K_DEVICE_IPOD_2_1,
                            K_DEVICE_IPOD_3_1,
                            K_DEVICE_IPOD_4_1,
                            K_DEVICE_IPAD_1_1,
                            K_DEVICE_IPAD_2_1,
                            K_DEVICE_IPAD_2_2,
                            K_DEVICE_IPAD_2_3,
                            K_DEVICE_I386,
                            K_DEVICE_X86_64,
                            nil];
    
    NSDictionary* platforms = [[NSDictionary alloc] initWithObjects:deviceNames forKeys:platformNames];
    [platformNames release];
    [deviceNames release];
    
    NSString* platformName = [platforms objectForKey:_platformCode];

    
    if (platformName == nil) {
        platformName = kUnknownPlatform;
    }
    [platformName retain];
    
    [platforms release];
    
    return [platformName autorelease];
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
