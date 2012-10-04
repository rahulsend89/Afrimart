//
//  ASIS3Bucket.h
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ASIS3Bucket : NSObject {
	
	// The name of this bucket (will be unique throughout S3)
	NSString *name;
	
	// The date this bucket was created
	NSDate *creationDate;
	
	// Information about the owner of this bucket
	NSString *ownerID;
	NSString *ownerName;
}

+ (id)bucketWithOwnerID:(NSString *)ownerID ownerName:(NSString *)ownerName;

@property (retain) NSString *name;
@property (retain) NSDate *creationDate;
@property (retain) NSString *ownerID;
@property (retain) NSString *ownerName;
@end
