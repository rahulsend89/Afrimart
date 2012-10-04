//
//  IASKPSToggleSwitchSpecifierViewCell.h
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IASKSwitch;

@interface IASKPSToggleSwitchSpecifierViewCell : UITableViewCell {
    UILabel *_label;
    IASKSwitch *_toggle;
}

@property (nonatomic, assign) IBOutlet UILabel *label;
@property (nonatomic, assign) IBOutlet IASKSwitch *toggle;

@end
