//
//  ASIS3Bucket.m
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "ASIS3Bucket.h"


@implementation ASIS3Bucket

+ (id)bucketWithOwnerID:(NSString *)anOwnerID ownerName:(NSString *)anOwnerName
{
	ASIS3Bucket *bucket = [[[self alloc] init] autorelease];
	[bucket setOwnerID:anOwnerID];
	[bucket setOwnerName:anOwnerName];
	return bucket;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"Name: %@ creationDate: %@ ownerID: %@ ownerName: %@",[self name],[self creationDate],[self ownerID],[self ownerName]];
}


@synthesize name;
@synthesize creationDate;
@synthesize ownerID;
@synthesize ownerName;
@end
