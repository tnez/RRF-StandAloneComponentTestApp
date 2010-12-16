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

- (void)createTabDelimitedSubjectFile {
  // create the string
  NSString *writeData = [[NSString alloc] initWithFormat:
  @"Subjcet ID\t%@\nStudy Day\t%@\nToday's Dose\t%@\nDrug Level\t%@\nDrug Code\t%@\nDate\t%@\n",
                         [subject subject_id],[subject session],
                         [subject drugDose],[subject drugLevel],
                         [subject drugCode],[[NSDate date] description]];
  NSLog(@"Write Data: %@",writeData);
  // generate our file name
  NSLog(@"Looking for files in dir: %@",[component tempDirectory]);
  NSString *filename = [[NSString alloc] initWithString:
                        [[component tempDirectory]
                         stringByAppendingPathComponent:@"current.info"]];
  // create the directory
  [[NSFileManager defaultManager]
   createDirectoryAtPath:[component tempDirectory] attributes:nil];
  // create the file
  BOOL success = [[NSFileManager defaultManager]
                  createFileAtPath:filename
                  contents:[writeData dataUsingEncoding:NSUTF8StringEncoding]
                  attributes:nil];
  // if we encountered an error
  if(!success) {
    NSLog(@"Error writing subject file:%@",filename);
  }
  [filename release];
  [writeData release];
}
  
- (IBAction)start: (id)sender {
  // setup the component
  NSDictionary *definition =
    [NSDictionary dictionaryWithContentsOfFile:
     [pathToDefinition stringByStandardizingPath]];
  component = [[TKComponentController loadFromDefinition:definition] retain];
  [component setSubject:subject];
  [component setSessionWindow:sessionWindow];
  // create the subject file (current.info)
  [self createTabDelimitedSubjectFile];
  // attempt to begin the component
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
