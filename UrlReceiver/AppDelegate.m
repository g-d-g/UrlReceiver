//
//  AppDelegate.m
//  UrlReceiver
//
//  Created by Jesse Crocker on 2/4/16.
//  Copyright © 2016 Trailbehind inc. All rights reserved.
//

#import "AppDelegate.h"
#import "NSURLComponents+queryItemNamed.h"

#import <GCDWebServer.h>
#import <GCDWebServerDataResponse.h>


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.webServer = [[GCDWebServer alloc] init];
  
  [self setupWebRoutes];
  
  [self.webServer startWithOptions:@{
                                     GCDWebServerOption_AutomaticallySuspendInBackground: @NO,
                                     GCDWebServerOption_Port: @8080
                                     }
                             error:nil];
  NSLog(@"Server is listening at %@", self.webServer.serverURL);
  
  return YES;
}


- (void)setupWebRoutes {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
  [self.webServer addHandlerForMethod:@"GET"
                                 path:@"/"
                         requestClass:[GCDWebServerRequest class]
                         processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
                           return [GCDWebServerDataResponse responseWithHTML:[self getHtmlForm:nil]];
                         }];
  
  [self.webServer addHandlerForMethod:@"GET"
                                 path:@"/open/"
                                requestClass:[GCDWebServerRequest class]
                                processBlock:
   ^GCDWebServerResponse *(GCDWebServerRequest* request) {

     NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:request.URL
                                                 resolvingAgainstBaseURL:NO];
     BOOL success = NO;
     NSURLQueryItem *urlItem = [urlComponents queryItemWithName:@"url"];
     if(urlItem) {
       success = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlItem.value]];
     }
     
     NSURLQueryItem *formItem = [urlComponents queryItemWithName:@"form"];
     if(formItem) {
       return [GCDWebServerDataResponse responseWithHTML:
               [self getHtmlForm:[NSString stringWithFormat:@"Success:%@<br/>", success?@"YES":@"NO"]]];
     }
     return [GCDWebServerDataResponse responseWithJSONObject:@{@"success": @(success)}];
   }];
#pragma clang diagnostic pop
}


- (NSString*)getHtmlForm:(NSString*)statusLine {
  if(!statusLine) {
    statusLine = @"";
  }
  return [NSString stringWithFormat:@"<html><body> \
          %@ \
  <form name=\"input\" action=\"/open/\" method=\"get\" enctype=\"application/x-www-form-urlencoded\"> \
  URL: <input type=\"text\" name=\"url\" /> \
  <input type=\"hidden\" name=\"form\" value=\"1\" /> \
  <input type=\"submit\" value=\"Submit\" /> \
  </form> \
  </body></html>", statusLine];
}

@end
