//
//  CNPickerView.h
//  NWPickerField
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NWPickerField;

@interface NWPickerView : UIPickerView {
@private
	CGRect hiddenFrame;
	CGRect visibleFrame;
	NWPickerField* field;
}

@property(nonatomic, assign) CGRect hiddenFrame;
@property(nonatomic, assign) CGRect visibleFrame;
@property(nonatomic, assign) NWPickerField* field;

-(void) toggle;

@end
