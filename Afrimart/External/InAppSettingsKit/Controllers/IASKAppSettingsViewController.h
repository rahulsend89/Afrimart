//
//  IASKAppSettingsViewController.h
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import "IASKSettingsStore.h"

@class IASKSettingsReader;
@class IASKAppSettingsViewController;
@class IASKSpecifier;

@protocol IASKSettingsDelegate
- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender;
@optional
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderForKey:(NSString*)key;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderForKey:(NSString*)key;

- (CGFloat)tableView:(UITableView*)tableView heightForSpecifier:(IASKSpecifier*)specifier;
- (UITableViewCell*)tableView:(UITableView*)tableView cellForSpecifier:(IASKSpecifier*)specifier;

- (NSString*)mailComposeBody;
- (UIViewController<MFMailComposeViewControllerDelegate>*)viewControllerForMailComposeView;

- (void)settingsViewController:(IASKAppSettingsViewController*)sender buttonTappedForKey:(NSString*)key;
@end


@interface IASKAppSettingsViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate> {
	id<IASKSettingsDelegate>  _delegate;
    UITableView    			*_tableView;
    
    NSMutableArray          *_viewList;
    NSIndexPath             *_currentIndexPath;
	NSIndexPath				*_topmostRowBeforeKeyboardWasShown;
	
	IASKSettingsReader		*_settingsReader;
    id<IASKSettingsStore>  _settingsStore;
	NSString				*_file;
	
	id                      _currentFirstResponder;
    
    BOOL                    _showCreditsFooter;
    BOOL                    _showDoneButton;
}

@property (nonatomic, assign) IBOutlet id delegate;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSIndexPath   *currentIndexPath;
@property (nonatomic, retain) IASKSettingsReader *settingsReader;
@property (nonatomic, retain) id<IASKSettingsStore> settingsStore;
@property (nonatomic, copy) NSString *file;
@property (nonatomic, retain) id currentFirstResponder;
@property (nonatomic, assign) BOOL showCreditsFooter;
@property (nonatomic, assign) BOOL showDoneButton;

- (void)synchronizeSettings;
- (IBAction)dismiss:(id)sender;

// subclassing: optionally override these methods to customize appearance and functionality
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIView *)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section;
@end
