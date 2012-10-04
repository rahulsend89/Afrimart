//
//  IASKPSToggleSwitchSpecifierViewCell.m
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "IASKPSToggleSwitchSpecifierViewCell.h"
#import "IASKSwitch.h"

@implementation IASKPSToggleSwitchSpecifierViewCell

@synthesize label=_label, 
            toggle=_toggle;
            
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
