//
//  NWPickerField.m
//  NWFieldPicker
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "NWPickerField.h"
#import "NSString+NSArrayExtension.h"
#import "NWPickerView.h"


NSString* UIPickerViewBoundsUserInfoKey = @"UIPickerViewBoundsUserInfoKey";
NSString* UIPickerViewWillShownNotification = @"UIPickerViewWillShownNotification";
NSString* UIPickerViewDidShowNotification = @"UIPickerViewDidShowNotification";
NSString* UIPickerViewWillHideNotification = @"UIPickerViewWillHideNotification";
NSString* UIPickerViewDidHideNotification = @"UIPickerViewDidHideNotification";



@implementation NWPickerField

@synthesize delegate;
@synthesize formatString;

- (BOOL)canBecomeFirstResponder {
	return YES;
	
}

-(BOOL) becomeFirstResponder {
	// we will toggle our view here. This allows us to react properly 
    // when in a table cell.
    //[delegate fieldSelect];
    if (pickerView.hidden = YES)
        [pickerView toggle];
    return YES;
}


-(void) dealloc {
	delegate = nil;
	
    // clean up..
	[pickerView release];
	[componentStrings release];
	[formatString release];
	[indicator release];
	[doneButton release];
	[super dealloc];
}

-(void) didMoveToSuperview {
	// lets create a hidden picker view.
	pickerView = [[NWPickerView alloc] initWithFrame:CGRectZero];
	pickerView.hidden = YES;
	pickerView.dataSource = self;
	pickerView.delegate = self;
	pickerView.showsSelectionIndicator = YES;
	pickerView.field = self;
    
	// lets load our indecicator image and get its size.
	CGRect bounds = self.bounds;
	UIImage* image = [UIImage imageNamed:@"downArrow.png"];
	CGSize imageSize = image.size;
	
	// create our indicator imageview and add it as a subview of our textview.
    doneButton = [self buttonWithTitle:@"Done" target:self selector:@selector(done) frame:CGRectMake(200,418, 80, 40) : 12];
    [doneButton setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0.0f]];
    [doneButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [doneButton setBackgroundImage:[UIImage imageNamed:@"button-highlight.png"] forState:UIControlStateHighlighted];
	CGRect imageViewRect = CGRectMake((bounds.origin.x + bounds.size.width) - imageSize.width - 5, (bounds.size.height/2) - (imageSize.height/2), imageSize.width, imageSize.height);
	indicator = [[UIImageView alloc] initWithFrame:imageViewRect];
	[self addSubview:indicator];
	indicator.image = image;
	indicator.hidden = YES;
	doneButton.hidden = YES;
    [self.superview addSubview:doneButton];
    // set our default format string.
	self.formatString = @"%@";
}
-(void)done{
    [pickerView toggle];
    [delegate hideView];
}
- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)inSelector frame:(CGRect)frame :(int)fontSize{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setFrame:frame];
	[button setTitle:title forState:UIControlStateNormal];
	button.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
	button.userInteractionEnabled = YES;
	button.titleLabel.textAlignment = UITextAlignmentCenter;
	button.titleLabel.lineBreakMode   = UILineBreakModeTailTruncation;
	button.titleLabel.shadowOffset    = CGSizeMake (1.0, 0.0);
	button.titleLabel.textColor = [UIColor blackColor];
	button.showsTouchWhenHighlighted = YES;
	button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleTopMargin|
    UIViewAutoresizingFlexibleHeight|
    UIViewAutoresizingFlexibleBottomMargin;
	[button addTarget:self action:inSelector forControlEvents:UIControlEventTouchUpInside];
    //[button autorelease];
    return button;
}

-(void) didMoveToWindow {
	UIWindow* appWindow = [self window];
    
    // the app window can be null when being popped off 
    // the controller stack.
	if (appWindow != nil) {
        CGRect windowBounds = [appWindow bounds];
        // caluclate our hidden rect.
        CGRect pickerHiddenFrame = windowBounds;
        pickerHiddenFrame.origin.y = pickerHiddenFrame.size.height+216;
        pickerHiddenFrame.size.height = 216;
	
        // calucate our visible rect
        CGRect pickerVisibleFrame = windowBounds;
        pickerVisibleFrame.origin.y = windowBounds.size.height - 216;
        pickerVisibleFrame.size.height = 216;
	
        // tell the picker view the frames.
        pickerView.hiddenFrame = pickerHiddenFrame;
        pickerView.visibleFrame = pickerVisibleFrame;
        
	
        // set the initial frame so its hidden.
        pickerView.frame = pickerHiddenFrame;
        pickerView.frame = pickerHiddenFrame;
        
        // add the picker view to our window so its top most like a keyboard.
        [appWindow addSubview:pickerView];

        int component = 0;
	
        // select the first items in each component by default.
        for (component = 0; component < [pickerView numberOfComponents]; component++) 
            [self selectRow:0 inComponent:component animated:NO];
    }
}


-(void) pickerViewHidden:(BOOL)wasHidden {
	// hide our show our indicator when notified by the picker.
	indicator.hidden = wasHidden;
    doneButton.hidden = wasHidden;
}


#pragma mark -
#pragma mark UIPickerView wrappers
#pragma mark -

-(void) selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated {
	
	// when selection is given then make sure we update our edit control and the picker.
	[pickerView selectRow:row inComponent:component animated:animated];
	[self pickerView:pickerView didSelectRow:row inComponent:component];
}

-(NSInteger) selectedRowInComponent:(NSInteger)component {
    return [pickerView selectedRowInComponent:component];
}

#pragma mark -
#pragma mark UIPickerViewDataSource handlers
#pragma mark -

// returns the number of 'columns' to display.
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	// we always have 1..
	NSInteger count = [delegate numberOfComponentsInPickerField:self];
	NSInteger item = 0;
	
    // if we have component strings release them.
    if (componentStrings != nil)
        [componentStrings release];
    
	componentStrings = [[NSMutableArray alloc] init];
	
    // put a blank place holder in here for nothing.
	for (item = 0; item < count; item++) {
		[componentStrings addObject:@""];
	}
		
	return count;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {	
	return [delegate pickerField:self numberOfRowsInComponent:component];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [delegate pickerField:self titleForRow:row forComponent:component];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	NSString* string = [delegate pickerField:self titleForRow:row forComponent:component];
	[componentStrings replaceObjectAtIndex:component withObject:string];
	
    // format our text representing the change in the selection.
	self.text = [NSString stringWithFormat:formatString array:componentStrings];
}
-(void)hideView{
    [delegate hideView];
}
@end
