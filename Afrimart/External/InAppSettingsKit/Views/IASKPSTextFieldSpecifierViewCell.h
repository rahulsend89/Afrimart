//
//  IASKPSTextFieldSpecifierViewCell.h
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IASKTextField;

@interface IASKPSTextFieldSpecifierViewCell : UITableViewCell {
    UILabel *_label;
    IASKTextField *_textField;
}

@property (nonatomic, assign) IBOutlet UILabel *label;
@property (nonatomic, assign) IBOutlet IASKTextField *textField;

@end
