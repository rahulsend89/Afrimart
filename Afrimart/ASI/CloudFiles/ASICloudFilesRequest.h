//
//  ASICloudFilesRequest.h
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"


@interface ASICloudFilesRequest : ASIHTTPRequest {
}

+ (NSString *)storageURL;
+ (NSString *)cdnManagementURL;
+ (NSString *)authToken;

#pragma mark Rackspace Cloud Authentication

+ (id)authenticationRequest;
+ (NSError *)authenticate;
+ (NSString *)username;
+ (void)setUsername:(NSString *)username;
+ (NSString *)apiKey;
+ (void)setApiKey:(NSString *)apiKey;

// helper to parse dates in the format returned by Cloud Files
-(NSDate *)dateFromString:(NSString *)dateString;


@end
