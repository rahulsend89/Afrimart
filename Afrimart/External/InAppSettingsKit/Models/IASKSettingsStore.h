//
//  IASKSettingsStore.h
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IASKSettingsStore <NSObject>
@required
- (void)setBool:(BOOL)value      forKey:(NSString*)key;
- (void)setFloat:(float)value    forKey:(NSString*)key;
- (void)setDouble:(double)value  forKey:(NSString*)key;
- (void)setInteger:(int)value    forKey:(NSString*)key;
- (void)setObject:(id)value      forKey:(NSString*)key;
- (BOOL)boolForKey:(NSString*)key;
- (float)floatForKey:(NSString*)key;
- (double)doubleForKey:(NSString*)key;
- (int)integerForKey:(NSString*)key;
- (id)objectForKey:(NSString*)key;
- (BOOL)synchronize; // Write settings to a permanant storage. Returns YES on success, NO otherwise
@end


@interface IASKAbstractSettingsStore : NSObject <IASKSettingsStore> {
}

@end
