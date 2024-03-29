//
//  String_NSArrayExtension.m
//  NWFieldPicker
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//
// This was a great find on stack overflow. Can't claim it as mine..
#import "NSString+NSArrayExtension.h"

@implementation NSString(NSArrayExtension)

+ (id)stringWithFormat:(NSString *)format array:(NSArray*) arguments;
{
    char *argList = (char *)malloc(sizeof(NSString *) * [arguments count]);
    [arguments getObjects:(id *)argList];
    NSString* result = [[NSString alloc] initWithFormat:format arguments:argList];
    free(argList);
    return [result autorelease];
}

@end
