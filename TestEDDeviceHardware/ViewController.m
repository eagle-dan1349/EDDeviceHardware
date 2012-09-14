//
//  ViewController.m
//  TestEDDeviceHardware
//
//  Created by Daniil Orlov on 9/6/12.
//  Copyright (c) 2012 Daniil Orlov. All rights reserved.
//

#import "ViewController.h"
#import "EDDeviceHardware/EDDeviceHardware.h"

@interface ViewController ()

@property(nonatomic, retain) UILabel* deviceLabel;

@end

@implementation ViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.deviceLabel = [[[UILabel alloc] init] autorelease];
    self.deviceLabel.text = [[EDDeviceHardware currentDevice] platformName];
    NSLog(@"%@", [[EDDeviceHardware currentDevice] platformName]);
    self.deviceLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    
    [self.deviceLabel sizeToFit];
    [self.view addSubview:self.deviceLabel];
    self.deviceLabel.center = self.view.center;
}
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    self.deviceLabel.center = self.view.center;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void) dealloc
{
    self.deviceLabel = nil;
    [super dealloc];
}

@end
