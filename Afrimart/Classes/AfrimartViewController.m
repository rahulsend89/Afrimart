//
//  AfrimartViewController.m
//  Afrimart
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "AfrimartViewController.h"
#import "ASIFormDataRequest.h"
#import "NWPickerField.h"
@implementation AfrimartViewController
@synthesize request;
@synthesize appSettingsViewController;

/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */
- (IASKAppSettingsViewController*)appSettingsViewController {
	if (!appSettingsViewController) {
		appSettingsViewController = [[IASKAppSettingsViewController alloc] initWithNibName:@"IASKAppSettingsView" bundle:nil];
		appSettingsViewController.delegate = self;
	}
	return appSettingsViewController;
}

- (void)uploadFailed:(ASIHTTPRequest *)theRequest
{
	NSLog(@"Fail");
	[resultView setText:[NSString stringWithFormat:@"Request failed:\r\n%@",[[theRequest error] localizedDescription]]];
}

- (void)uploadFinished:(ASIHTTPRequest *)theRequest
{
    progressIndicator.hidden = TRUE;
	UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"Thank you!" 
													 message:@"Thank You. AfriMARKT has posted your request"
													delegate:nil 
										   cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	[prompt show];
	[prompt release];
	NSLog(@"Done :%@",[theRequest responseString]);
	[resultView setText:[NSString stringWithFormat:@"Finished uploading %llu bytes of data",[theRequest postLength]]];
	
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    // Clear out the old notification before scheduling a new one.
    if ([[[UIApplication sharedApplication] scheduledLocalNotifications] count] > 0)
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
	
    // Create a new notification
    UILocalNotification* alarm = [[[UILocalNotification alloc] init] autorelease];
    if (alarm) {
		[alarm setFireDate:[NSDate date]];
		[alarm setTimeZone:[NSTimeZone defaultTimeZone]];
		[alarm setRepeatInterval:0];
		[alarm setSoundName:@"alarmsound.caf"];
		[alarm setAlertBody:@"Boom!\r\n\r\nUpload is finished!"];
        [[UIApplication sharedApplication] scheduleLocalNotification:alarm];
    }
#endif
}

- (void)dealloc
{
	[request setDelegate:nil];
	[request setUploadProgressDelegate:nil];
	[request cancel];
	[request release];
	[progressIndicator release];
	[resultView release];
    [super dealloc];
}

/*
 Most of the code below here relates to the table view, and isn't that interesting
 */




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//[[[self navigationBar] topItem] setTitle:@"Tracking Upload Progress"];
	//resultView = [[UITextView alloc] initWithFrame:CGRectZero];
	//[resultView setBackgroundColor:[UIColor clearColor]];
	//progressIndicator = [[UIProgressView alloc] initWithFrame:CGRectZero];
	
	[sel setDelegate:self];
	[comment setDelegate:self];
	[pincode setDelegate:self];
	selectedScrollIndex = 0;
	regionData = [[NSArray arrayWithObjects:
				   @"Select Your Region",
				   @"North",
				   @"South",
				   @"East",
				   @"West",
				   @"All", nil] retain];
    
    NSString* statesPlist = [[NSBundle mainBundle] pathForResource:@"States" ofType:@"plist"];
    states = [[NSArray alloc] initWithContentsOfFile:statesPlist];
    
    [sel addTarget:self action:@selector(startEditing:) forControlEvents:UIControlEventTouchDown];
}
-(void)startEditing:(id)target{
    NSLog(@":)");
    [self moveDoit:-210.0f];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	//return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    return NO;
}
-(IBAction)openCam:(id)sender{
	[self createAndPresentImagePickerCam];
}
-(IBAction)openLib:(id)sender{
	[self createAndPresentImagePicker];
}
- (void)createAndPresentImagePickerCam{
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	[self presentModalViewController:picker animated:YES];
	[picker release];
}
- (void)createAndPresentImagePicker
{
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePicker.delegate = self;
	[self presentModalViewController:imagePicker animated:YES];
	[imagePicker release];
}
- (IBAction) showPicker:(id)sender {
	//NSLog(@"Do this times");
	selectedScrollIndex = 0;
	UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:[regionData objectAtIndex:0]
													  delegate:self
											 cancelButtonTitle:@"Done"
										destructiveButtonTitle:@"Cancel"
											 otherButtonTitles:nil];
	// Add the picker
	UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,185,0,0)];
	
	pickerView.delegate = self;
	pickerView.showsSelectionIndicator = YES;    // note this is default to NO
	pickerView.dataSource = self;
	[menu addSubview:pickerView];
	[menu showInView:self.view];
	[menu setBounds:CGRectMake(0,0,320, 700)];
	
	[pickerView release];
	[menu release];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView { // This method needs to be used. It asks how many columns will be used in the UIPickerView
	return 1; // We only need one column so we will return 1.
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component { // This method also needs to be used. This asks how many rows the UIPickerView will have.
	return [regionData count]; // We will need the amount of rows that we used in the pickerViewArray, so we will return the count of the array.
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component { // This method asks for what the title or label of each row will be.
	return [regionData objectAtIndex:row]; // We will set a new row for every string used in the array.
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	selectedScrollIndex = row;
	NSLog(@"row : %d : %@",row,[regionData objectAtIndex:row]);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
	[picker.parentViewController dismissModalViewControllerAnimated:YES];
	imageView.image = image;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self moveDoit:0.0f];
	if (buttonIndex == 0 || selectedScrollIndex == 0) {
		NSLog(@"Cancle");
	}else {
		NSLog(@"Working %d",selectedScrollIndex);
		NSString *str =[NSString stringWithFormat:@"%@",[regionData objectAtIndex:selectedScrollIndex]];
		sel.text = str;
	}
}

/*
- (void)textFieldDidBeginEditing:(UITextField *)textField{
	if (textField == sel) {
        [sendbutton becomeFirstResponder];
        [textField resignFirstResponder];
		//NSLog(@"Do this");
		//[self showPicker:nil];
		//return NO;
	}
}*/

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if (textField == pincode) {
		NSString *textEntered = string;
		NSCharacterSet *myMacAddress = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
		for (int i = 0; i < [textEntered length]; i++) 
		{
			unichar c = [textEntered characterAtIndex:i];
			//NSLog(@"%d : val",[myMacAddress characterIsMember:c]);
			if (![myMacAddress characterIsMember:c]) 
			{
				return NO;
			}else {
				NSUInteger newLength = [textField.text length] + [string length] - range.length;
				if ((newLength > 8)) {
					return NO;
				}else {
					return YES;
				}
			}
		}
	}
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[self moveDoit:0.0f];
	[textField resignFirstResponder];
	return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	if (textField !=sel) {
        [self moveDoit:-210.0f];
        return YES;
	}else{
        //[self moveDoit:0.0f];
        //[comment resignFirstResponder];
        //[pincode resignFirstResponder];
        //[self showPicker:nil];
    }
	return NO;
}


-(void)moveDoit :(float)num{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDone)];
	CGAffineTransform doit = CGAffineTransformMakeTranslation(0.0, num);
	self.view.transform = doit;
	[UIView commitAnimations];
	NSLog(@"Animating");
}
-(IBAction)sendFiles :(id)sender{
    //NSLog(@"Working : %@ : %@",name,phone);
	NSString *comment_ = comment.text;
	NSString *sel_ = sel.text;
	NSString *pincode_ = pincode.text;
	//NSLog(@"imageView.image %@",imageView.image);
	if (imageView.image == NULL) {
		UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"Blank Field!" 
														 message:@"Please select your image"
														delegate:nil 
											   cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[prompt show];
		[prompt release];
	}
	else if ([comment_ isEqualToString:@""]) {
		UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"Blank Field!" 
														 message:@"Please fill up your comment"
														delegate:nil 
											   cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[prompt show];
		[prompt release];
	}else if ([sel_ isEqualToString:@"--"]) {
		UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"Blank Field!" 
														 message:@"Please select your region"
														delegate:nil 
											   cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[prompt show];
		[prompt release];
	}else if ([pincode_ length]!=8 || [pincode_ isEqualToString:@""]) {
		UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"Blank Field!" 
														 message:@"Please fill up your pincode"
														delegate:nil 
											   cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[prompt show];
		[prompt release];
	}else {
		[self sendfile];
	}
}
- (void)sendfile {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"name_preference"];
    NSString *phone = [defaults objectForKey:@"phone_preference"];
	progressIndicator.hidden = FALSE;
	[request cancel];
	[self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.22/Afrimart/post.php"]]];
	NSData *imageData = UIImageJPEGRepresentation(imageView.image, 90);
	NSLog(@"comment.text : %@",comment.text);
	NSLog(@"pincode.text : %@",pincode.text);
	NSLog(@"sel.text : %@",sel.text);
	[request setPostValue:[NSString stringWithFormat:@"%@",comment.text] forKey:@"comment"];
	[request setPostValue:[NSString stringWithFormat:@"%@",pincode.text] forKey:@"pincode"];
	[request setPostValue:[NSString stringWithFormat:@"%@",sel.text] forKey:@"region"];
    [request setPostValue:[NSString stringWithFormat:@"%@",name] forKey:@"name"];
    [request setPostValue:[NSString stringWithFormat:@"%@",phone] forKey:@"phone"];
	[request setTimeOutSeconds:20];
	
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
//#endif
	[request setUploadProgressDelegate:progressIndicator];
	[request setDelegate:self];
	[request setDidFailSelector:@selector(uploadFailed:)];
	[request setDidFinishSelector:@selector(uploadFinished:)];
	
	[request setFile:imageData withFileName:@".jpg" andContentType:@"image/jpeg" forKey:@"userfile"];
	[request startAsynchronous];
	[resultView setText:@"Uploading data..."];
	
	
	
	/*
	 NSData *imageData = UIImageJPEGRepresentation(imageView.image, 90);
	 NSString *urlString = @"http://localhost/Afrimart/upload.php";
	 
	 NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	 [request setURL:[NSURL URLWithString:urlString]];
	 [request setHTTPMethod:@"POST"];
	 
	 NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
	 NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
	 [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
	 
	 NSMutableData *body = [NSMutableData data];
	 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	 [body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"amresh.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	 [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     
     NSData * data = UIImagePNGRepresentation(image);
     [fbAgent uploadPhotoAsData:[NSData dataWithData:data] withCaption:@"my image" toAlbum:nil];
     
	 [body appendData:[NSData dataWithData:imageData]];
	 [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	 [request setHTTPBody:body];
	 
	 NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	 NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	 
	 NSLog(@"return %@",returnString);*/
}
- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender {
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"Ended");
}
- (IBAction)showSettingsModal:(id)sender {
    UINavigationController *aNavController = [[UINavigationController alloc] initWithRootViewController:self.appSettingsViewController];
    //[viewController setShowCreditsFooter:NO];   // Uncomment to not display InAppSettingsKit credits for creators.
    // But we encourage you not to uncomment. Thank you!
    self.appSettingsViewController.showDoneButton = YES;
    [self presentModalViewController:aNavController animated:YES];
    [aNavController release];
}


#pragma mark -
#pragma mark NWPickerField
#pragma mark -

-(NSInteger) numberOfComponentsInPickerField:(NWPickerField*)pickerField {
	switch(pickerField.tag) {
        case 2000:
            return 1;
            break;
            
        default:
            return -1;
    }
    
}


-(NSInteger) pickerField:(NWPickerField*)pickerField numberOfRowsInComponent:(NSInteger)component{
	switch(pickerField.tag) {
        case 2000:
            return [states count];
            break;
            
        default:
            return 0;
    }
    
}


-(NSString *) pickerField:(NWPickerField *)pickerField titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch(pickerField.tag) {
        case 2000:
            return [states objectAtIndex:row];
            break;
            
        default:
            return nil;
    }	
}
-(void)hideView{
    [self moveDoit:0.0f];
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


@end
