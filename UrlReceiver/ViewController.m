//
//  ViewController.m
//  UrlReceiver
//
//  Created by Jesse Crocker on 2/4/16.
//  Copyright © 2016 Trailbehind inc. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <GCDWebServer.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *serverUrlLabel;

@end

@implementation ViewController


- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.serverUrlLabel.text = ((AppDelegate*)[UIApplication sharedApplication].delegate).webServer.serverURL.absoluteString;
}

@end
