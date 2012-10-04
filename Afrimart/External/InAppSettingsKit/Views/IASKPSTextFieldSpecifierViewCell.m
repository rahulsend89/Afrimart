//
//  IASKPSTextFieldSpecifierViewCell.m
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "IASKPSTextFieldSpecifierViewCell.h"
#import "IASKTextField.h"
#import "IASKSettingsReader.h"

@implementation IASKPSTextFieldSpecifierViewCell

@synthesize label=_label,
            textField=_textField;

- (void)layoutSubviews {
    [super layoutSubviews];
	CGSize labelSize = [_label sizeThatFits:CGSizeZero];
	labelSize.width = MIN(labelSize.width, _label.bounds.size.width);

	CGRect textFieldFrame = _textField.frame;
	textFieldFrame.origin.x = _label.frame.origin.x + MAX(kIASKMinLabelWidth, labelSize.width) + kIASKSpacing;
	if (!_label.text.length)
		textFieldFrame.origin.x = _label.frame.origin.x;
	textFieldFrame.size.width = _textField.superview.frame.size.width - textFieldFrame.origin.x - _label.frame.origin.x;
	_textField.frame = textFieldFrame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
