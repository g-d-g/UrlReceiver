//
//  NSURLComponents+queryItemNamed.h
//  UrlReceiver
//
//  Created by Jesse Crocker on 2/4/16.
//  Copyright © 2016 Trailbehind inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLComponents(queryItemNamed)

- (NSURLQueryItem * __nullable)queryItemWithName:(NSString* __nonnull)name;

@end
