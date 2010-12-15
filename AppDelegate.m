//
//  AppDelegate.m
//  TKComponentCocoaApp
//
//  Created by tnesland on 12/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

@synthesize setupWindow,sessionWindow,subject,pathToDefinition;

- (void)awakeFromNib {
  // register for notifications
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(theComponentWillBegin:)
                                               name:TKComponentWillBeginNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(theComponentDidBegin:)
                                               name:TKComponentDidBeginNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(theComponentDidFinish:)
                                               name:TKComponentDidFinishNotification
                                             object:nil];
}

- (IBAction)browseForDefinition: (id)sender {
  NSOpenPanel *box = [[NSOpenPanel alloc] init];
  [box setCanChooseDirectories:NO];
  [box setAllowsMultipleSelection:NO];
  NSInteger response = [box runModalForTypes:nil];
  if(response == NSOKButton) {
    [self setPathToDefinition:[[box filenames] objectAtIndex:0]];
  }
  [box release];
}

- (IBAction)start: (id)sender {
  NSDictionary *definition =
    [NSDictionary dictionaryWithContentsOfFile:
     [pathToDefinition stringByStandardizingPath]];
  component = [[TKComponentController loadFromDefinition:definition] retain];
  [component setSubject:subject];
  [component setSessionWindow:sessionWindow];
  if([component isClearedToBegin]) {
    [component begin];
  } else {
    // bleh
  }
}

- (void)theComponentWillBegin: (NSNotification *)aNote {
  
  NSLog(@"The component will begin");
}

- (void)theComponentDidBegin: (NSNotification *)aNote {
  NSLog(@"The component did begin");
  
}

- (void)theComponentDidFinish: (NSNotification *)aNote {
  NSLog(@"The component did finish");
  [component release];
}

@end
