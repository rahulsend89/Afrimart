//
//  IASKSettingsStoreFile.m
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "IASKSettingsStoreFile.h"


@implementation IASKSettingsStoreFile

- (id)initWithPath:(NSString*)path {
    if((self = [super init])) {
        _filePath = [path retain];
        _dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        if(_dict == nil) {
            _dict = [[NSMutableDictionary alloc] init];
        }
    }
    return self;
}

- (void)dealloc {
    [_dict release], _dict = nil;
    [_filePath release], _filePath = nil;

    [super dealloc];
}


- (void)setObject:(id)value forKey:(NSString *)key {
    [_dict setObject:value forKey:key];
}

- (id)objectForKey:(NSString *)key {
    return [_dict objectForKey:key];
}

- (BOOL)synchronize {
    return [_dict writeToFile:_filePath atomically:YES];
}

@end
