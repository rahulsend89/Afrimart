//
//  IASKSwitch.m
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//
#import "IASKSwitch.h"


@implementation IASKSwitch

@synthesize key=_key;

- (void)dealloc {
    [_key release], _key = nil;
	
    [super dealloc];
}


@end
