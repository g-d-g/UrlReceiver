//
//  AppDelegate.h
//  UrlReceiver
//
//  Created by Jesse Crocker on 2/4/16.
//  Copyright © 2016 Trailbehind inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GCDWebServer;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) GCDWebServer *webServer;


@end

