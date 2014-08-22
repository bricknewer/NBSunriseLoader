//
//  NBSunriseLoaderView.m
//  NBSunriseLoader
//
//  Created by Nick Brewer on 8/16/14.
//  Copyright (c) 2014 NicholasBrewer. All rights reserved.
//

#import "NBSunriseLoaderView.h"

#define barHeight self.frame.size.height/20

@implementation NBSunriseLoaderView

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor purpleColor];
    for (UIView *view in self.barViews) {
        [self addSubview:view];
    }
    self.whiteOverlayView = [[UIView alloc] init];
    self.whiteOverlayView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.whiteOverlayView];
}

- (NSArray *)barViews
{
    if (!_barViews) {
        _barViews = [[NSArray alloc] init];
        NSMutableArray *barViews = [[NSMutableArray alloc] init];
        BOOL on = YES;
        for (int i = 0; i < 8; i++) {
            UIView *barView = [[UIView alloc] init];
            if (on) {
                barView.frame = CGRectMake(0, self.frame.size.height + (2 * i * barHeight) + barHeight * 0.05, self.frame.size.width, barHeight * 0.9);
            } else {
                barView.frame = CGRectMake(0, self.frame.size.height + (2 * i * barHeight), self.frame.size.width, barHeight);
            }
            
            barView.backgroundColor = [UIColor whiteColor];
            if (on) {
                [barViews addObject:barView];
            }
            on = !on;
        }
        _barViews = barViews;
    }
    return _barViews;
}

-(void)setCurrentValue:(CGFloat)currentValue
{
    if (currentValue > 1) {
        currentValue = 1;
    }
    _currentValue = currentValue;
    [self setNeedsDisplay];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.whiteOverlayView.alpha = 1 - self.currentValue;
    self.whiteOverlayView.frame = self.bounds;
    
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Setup bounds
    CGFloat min = MIN(rect.size.width, rect.size.height);
    
    CGRect circleBounds = CGRectMake(0, 0, min, min);
    self.bounds = circleBounds;
    self.layer.cornerRadius = min/2;
    
    //// Color setup
    UIColor *redColor = [UIColor redColor];
    UIColor *orangeColor = [UIColor orangeColor];
    
    //// Gradient setup
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)orangeColor.CGColor, (id)redColor.CGColor], gradientLocations);
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:circleBounds];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(circleBounds.origin.x + (circleBounds.size.width / 2), circleBounds.origin.y), CGPointMake(circleBounds.origin.x + (circleBounds.size.width / 2), circleBounds.origin.y + circleBounds.size.height), 0);
    CGContextRestoreGState(context);
    
    //// Bars placement
    CGFloat finalY = 3 * self.bounds.size.height / 5;
    CGFloat partialY = (1 - self.currentValue) * (2 * self.bounds.size.height / 5) + finalY;
    
    int i = 0;
    for (UIView *view in self.barViews) {
        CGRect frame = view.frame;
        frame.origin.y = partialY + (2 * i * barHeight);
        view.frame = frame;
        i++;
    }
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
