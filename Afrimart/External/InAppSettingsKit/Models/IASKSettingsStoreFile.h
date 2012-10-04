//
//  IASKSettingsStoreFile.h
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IASKSettingsStore.h"

@interface IASKSettingsStoreFile : IASKAbstractSettingsStore {
    NSString * _filePath;
    NSMutableDictionary * _dict;
}

- (id)initWithPath:(NSString*)path;

@end
