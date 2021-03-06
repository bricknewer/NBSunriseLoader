//
//  NBSunriseLoaderView.h
//  NBSunriseLoader
//
//  Created by Nick Brewer on 8/16/14.
//  Copyright (c) 2014 NicholasBrewer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBSunriseLoaderView : UIView
@property (nonatomic) CGFloat currentValue;
@property (strong, nonatomic) NSArray *barViews; // of views
@property (strong, nonatomic) UIView *whiteOverlayView;
@property (strong, nonatomic) UIColor *color1;
@property (strong, nonatomic) UIColor *color2;
@end
