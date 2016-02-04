//
//  NSURLComponents+queryItemNamed.m
//  UrlReceiver
//
//  Created by Jesse Crocker on 2/4/16.
//  Copyright © 2016 Trailbehind inc. All rights reserved.
//

#import "NSURLComponents+queryItemNamed.h"

@implementation NSURLComponents(queryItemNamed)

- (NSURLQueryItem * __nullable)queryItemWithName:(NSString*)name {
  for(NSURLQueryItem *item in self.queryItems) {
    if([item.name isEqualToString:name]) {
      return item;
    }
  }
  
  return nil;
}

@end
