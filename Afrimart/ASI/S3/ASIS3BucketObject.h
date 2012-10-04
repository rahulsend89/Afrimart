//
//  ASIS3BucketObject.h
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ASIS3ObjectRequest;

@interface ASIS3BucketObject : NSObject <NSCopying> {
	
	// The bucket this object belongs to
	NSString *bucket;
	
	// The key (path) of this object in the bucket
	NSString *key;
	
	// When this object was last modified
	NSDate *lastModified;
	
	// The ETag for this object's content
	NSString *ETag;
	
	// The size in bytes of this object
	unsigned long long size;
	
	// Info about the owner
	NSString *ownerID;
	NSString *ownerName;
}

+ (id)objectWithBucket:(NSString *)bucket;

// Returns a request that will fetch this object when run
- (ASIS3ObjectRequest *)GETRequest;

// Returns a request that will replace this object with the contents of the file at filePath when run
- (ASIS3ObjectRequest *)PUTRequestWithFile:(NSString *)filePath;

// Returns a request that will delete this object when run
- (ASIS3ObjectRequest *)DELETERequest;

@property (retain) NSString *bucket;
@property (retain) NSString *key;
@property (retain) NSDate *lastModified;
@property (retain) NSString *ETag;
@property (assign) unsigned long long size;
@property (retain) NSString *ownerID;
@property (retain) NSString *ownerName;
@end
