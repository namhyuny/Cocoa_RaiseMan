//
//  PreferenceController.h
//  RaiseMan
//
//  Created by namhyun on 2015. 12. 27..
//  Copyright © 2015년 2Fworkshop. All rights reserved.
//

#import <Cocoa/Cocoa.h>
extern NSString * const BNRTableBgColorKey;
extern NSString * const BNREmptyDocKey;
extern NSString * const BNRColorChangedNotification;

@interface PreferenceController : NSWindowController {
    IBOutlet NSColorWell *colorWell;
    IBOutlet NSButton *checkbox;
}

-(NSColor *)tableBgColor;
-(BOOL)emptyDoc;

-(IBAction)changeBackgoundColor:(id)sender;
-(IBAction)changeNewEmptyDoc:(id)sender;
@end
