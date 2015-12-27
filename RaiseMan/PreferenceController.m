//
//  PreferenceController.m
//  RaiseMan
//
//  Created by namhyun on 2015. 12. 27..
//  Copyright © 2015년 2Fworkshop. All rights reserved.
//

#import "PreferenceController.h"

@implementation PreferenceController

-(id)init {
    if (![super initWithWindowNibName:@"Preferences"]) {
        return  nil;
    }
    return self;
}

-(void)windowDidLoad {
    NSLog(@"Nib file is loaded");
}

-(IBAction)changeBackgoundColor:(id)sender {
    NSColor *color = [colorWell color];
    NSLog(@"Color changed: %@", color);
}

-(IBAction)changeNewEmptyDoc:(id)sender {
    long state = [checkbox state];
    NSLog(@"Checkbox changed %lu", state);
}

@end
