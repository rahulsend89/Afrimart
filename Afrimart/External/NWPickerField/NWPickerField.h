//
//  CNPickerField.h
//  NWFieldPicker
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* UIPickerViewBoundsUserInfoKey;

extern NSString* UIPickerViewWillShownNotification;
extern NSString* UIPickerViewDidShowNotification;
extern NSString* UIPickerViewWillHideNotification;
extern NSString* UIPickerViewDidHideNotification;

@class NWPickerView;
@protocol NWPickerFieldDelegate;


@interface NWPickerField : UITextField<UIPickerViewDataSource,UIPickerViewDelegate> {
@private
	NWPickerView* pickerView;
	NSMutableArray* componentStrings;
	NSString* formatString;
	UIImageView* indicator;
    UIButton *doneButton;
	id<NWPickerFieldDelegate> delegate;
    
}

@property(nonatomic,assign) IBOutlet id<NWPickerFieldDelegate> delegate;
@property(nonatomic, copy) NSString* formatString;

-(void) selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
-(NSInteger) selectedRowInComponent:(NSInteger)component;
-(void)done;
- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)inSelector frame:(CGRect)frame :(int)fontSize;

@end

@protocol NWPickerFieldDelegate
@required
-(NSInteger) numberOfComponentsInPickerField:(NWPickerField*)pickerField;
-(NSInteger) pickerField:(NWPickerField*)pickerField numberOfRowsInComponent:(NSInteger)component;
-(NSString*) pickerField:(NWPickerField *)pickerField titleForRow:(NSInteger)row forComponent:(NSInteger)component;
-(void)hideView;
@end
