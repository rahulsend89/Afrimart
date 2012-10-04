//
//  AfrimartAppDelegate.h
//  Afrimart
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AfrimartViewController;

@interface AfrimartAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AfrimartViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AfrimartViewController *viewController;

@end

