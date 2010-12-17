//
//  AppDelegate.h
//  TKComponentCocoaApp
//
//  Created by tnesland on 12/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <TKUtility/TKUtility.h>

@interface AppDelegate : NSObject {

  IBOutlet NSWindow *setupWindow;
  IBOutlet NSWindow *sessionWindow;
  IBOutlet TKSubject *subject;
  TKComponentController *component;
  NSString *pathToDefinition;
}

@property (assign) IBOutlet NSWindow *setupWindow;
@property (assign) IBOutlet NSWindow *sessionWindow;
@property (nonatomic, retain) IBOutlet TKSubject *subject;
@property (nonatomic, retain) NSString *pathToDefinition;

#pragma mark ACTIONS
- (IBAction)browseForDefinition: (id)sender;
- (IBAction)start: (id)sender;

#pragma mark RESPONSES
- (void)theComponentWillBegin: (NSNotification *)aNote;
- (void)theComponentDidBegin: (NSNotification *)aNote;
- (void)theComponentDidFinish: (NSNotification *)aNote;

#pragma mark HELPER FUNCTIONS
- (void)createTabDelimitedSubjectFile;

@end
