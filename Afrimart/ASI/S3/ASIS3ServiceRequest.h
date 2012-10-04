//
//  ASIS3ServiceRequest.h
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIS3Request.h"

@class ASIS3Bucket;

@interface ASIS3ServiceRequest : ASIS3Request {
	
	// Internally used while parsing the response
	ASIS3Bucket *currentBucket;
	NSString *ownerName;
	NSString *ownerID;
	
	// A list of the buckets stored on S3 for this account
	NSMutableArray *buckets;
}

// Perform a GET request on the S3 service
// This will fetch a list of the buckets attached to the S3 account
+ (id)serviceRequest;

@property (retain, readonly) NSMutableArray *buckets;
@end
