//
//  IASKSpecifier.h
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class IASKSettingsReader;

@interface IASKSpecifier : NSObject {
    NSDictionary    *_specifierDict;
    NSDictionary    *_multipleValuesDict;
	IASKSettingsReader *_settingsReader;
}
@property (nonatomic, retain) NSDictionary  *specifierDict;
@property (nonatomic, assign) IASKSettingsReader *settingsReader;

- (id)initWithSpecifier:(NSDictionary*)specifier;
- (NSString*)localizedObjectForKey:(NSString*)key;
- (NSString*)title;
- (NSString*)key;
- (NSString*)type;
- (NSString*)titleForCurrentValue:(id)currentValue;
- (NSInteger)multipleValuesCount;
- (NSArray*)multipleValues;
- (NSArray*)multipleTitles;
- (NSString*)file;
- (id)defaultValue;
- (id)defaultStringValue;
- (BOOL)defaultBoolValue;
- (id)trueValue;
- (id)falseValue;
- (float)minimumValue;
- (float)maximumValue;
- (NSString*)minimumValueImage;
- (NSString*)maximumValueImage;
- (BOOL)isSecure;
- (UIKeyboardType)keyboardType;
- (UITextAutocapitalizationType)autocapitalizationType;
- (UITextAutocorrectionType)autoCorrectionType;
- (NSString*)footerText;
- (Class)viewControllerClass;
- (SEL)viewControllerSelector;
-(Class)buttonClass;
-(SEL)buttonAction;
	
@end
