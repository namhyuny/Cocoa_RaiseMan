//
//  PreferenceController.h
//  RaiseMan
//
//  Created by namhyun on 2015. 12. 27..
//  Copyright © 2015년 2Fworkshop. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferenceController : NSWindowController {
    IBOutlet NSColorWell *colorWell;
    IBOutlet NSButton *checkbox;
}
-(IBAction)changeBackgoundColor:(id)sender;
-(IBAction)changeNewEmptyDoc:(id)sender;
@end
