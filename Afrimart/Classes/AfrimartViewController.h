//
//  AfrimartViewController.h
//  Afrimart
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IASKAppSettingsViewController.h"
@class ASIFormDataRequest;
@class NWPickerField;
@interface AfrimartViewController : UIViewController <UIImagePickerControllerDelegate,UIPickerViewDataSource,UIActionSheetDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,IASKSettingsDelegate> {
	IBOutlet UIImageView *imageView;
	NSArray *regionData;
	IBOutlet UITextField *comment,*pincode;
    IBOutlet NWPickerField *sel;
    IBOutlet UIButton *sendbutton;
	NSInteger selectedScrollIndex;
	ASIFormDataRequest *request;
	IASKAppSettingsViewController *appSettingsViewController;
	IBOutlet UIProgressView *progressIndicator;
	IBOutlet UITextView *resultView;
    NSArray* states;
}
-(IBAction)sendFiles :(id)sender;
- (IBAction) showPicker:(id)sender;
-(IBAction)openLib:(id)sender;
-(IBAction)openCam:(id)sender;
- (IBAction)showSettingsModal:(id)sender;
- (void)createAndPresentImagePickerCam;
- (void)createAndPresentImagePicker;
-(void)moveDoit :(float)num;
- (void)sendfile;
- (void)imagePickerController:(UIImagePickerController *)imagePicker didFinishPickingMediaWithInfo:(NSDictionary *)info;
@property (retain, nonatomic) ASIFormDataRequest *request;
@property (nonatomic, retain) IASKAppSettingsViewController *appSettingsViewController;
-(void)startEditing:(id)target;

@end

