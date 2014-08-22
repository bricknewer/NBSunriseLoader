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
@property (weak, nonatomic) IBOutlet UIView *placeholderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loadingBarDistanceFromRightEdgeConstraint;
@property (strong, nonatomic) NBSunriseLoaderView *sunriseLoaderView;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation NBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.sunriseLoaderView = [[NBSunriseLoaderView alloc] initWithFrame:self.placeholderView.frame];
    [self.view addSubview:self.sunriseLoaderView];
    self.loadingBarDistanceFromRightEdgeConstraint.constant = 300;
    [self.view layoutIfNeeded];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self beginLoadingAnimation];
    self.sunriseLoaderView.currentValue = 0;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.sunriseLoaderView.currentValue = .25;
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.sunriseLoaderView.currentValue = .5;
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.sunriseLoaderView.currentValue = .75;
//    });

    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(beginLoadingAnimation) userInfo:nil repeats:YES];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)beginLoadingAnimation
{

    self.sunriseLoaderView.currentValue = 0;
    
    [self.sunriseLoaderView drawRect:self.sunriseLoaderView.frame];
    
//    [self.sunriseLoaderView setNeedsDisplay];
//   [self.sunriseLoaderView setNeedsLayout];
    self.loadingBarDistanceFromRightEdgeConstraint.constant = 300;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.loadingBarDistanceFromRightEdgeConstraint.constant = 20;
        self.sunriseLoaderView.currentValue = 1;
    
        [self.sunriseLoaderView drawRect:self.sunriseLoaderView.frame];
    
//        [self.sunriseLoaderView setNeedsDisplay];
//        [self.sunriseLoaderView setNeedsLayout];

        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
    

}

@end
