//
//  NBViewController.m
//  NBSunriseLoader
//
//  Created by Nick Brewer on 8/16/14.
//  Copyright (c) 2014 NicholasBrewer. All rights reserved.
//

#import "NBViewController.h"
#import "NBSunriseLoaderView.h"

@interface NBViewController ()
@property (strong, nonatomic) NBSunriseLoaderView *sunriseLoaderView;

@end

@implementation NBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.sunriseLoaderView = [[NBSunriseLoaderView alloc] initWithFrame:CGRectMake(60, 200, 200, 200)];
    [self.view addSubview:self.sunriseLoaderView];
    self.sunriseLoaderView.currentValue = 1;
    [self.sunriseLoaderView drawRect:self.sunriseLoaderView.frame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
