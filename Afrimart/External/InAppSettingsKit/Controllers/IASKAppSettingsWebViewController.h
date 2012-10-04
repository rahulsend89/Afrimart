//
//  IASKAppSettingsWebViewController.h
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface IASKAppSettingsWebViewController : UIViewController <UIWebViewDelegate, MFMailComposeViewControllerDelegate> {
  UIWebView *webView;
  NSURL *url;
}

- (id)initWithFile:(NSString*)htmlFileName key:(NSString*)key;

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSURL *url;

@end
