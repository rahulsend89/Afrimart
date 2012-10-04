//
//  IASKPSSliderSpecifierViewCell.h
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IASKSlider;

@interface IASKPSSliderSpecifierViewCell : UITableViewCell {
    IASKSlider *_slider;
    UIImageView *_minImage;
    UIImageView *_maxImage;
}

@property (nonatomic, assign) IBOutlet IASKSlider *slider;
@property (nonatomic, assign) IBOutlet UIImageView *minImage;
@property (nonatomic, assign) IBOutlet UIImageView *maxImage;

@end
