//
//  IASKSpecifierValuesViewController.h
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IASKSettingsStore.h"

@class IASKSpecifier;
@class IASKSettingsReader;

@interface IASKSpecifierValuesViewController : UIViewController {
    UITableView				*_tableView;
    
    IASKSpecifier			*_currentSpecifier;
    NSIndexPath             *_checkedItem;
	IASKSettingsReader		*_settingsReader;
    id<IASKSettingsStore>	_settingsStore;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSIndexPath *checkedItem;
@property (nonatomic, retain) IASKSpecifier *currentSpecifier;
@property (nonatomic, retain) IASKSettingsReader *settingsReader;
@property (nonatomic, retain) id<IASKSettingsStore> settingsStore;

@end
