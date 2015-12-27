//
//  PreferenceController.m
//  RaiseMan
//
//  Created by namhyun on 2015. 12. 27..
//  Copyright © 2015년 2Fworkshop. All rights reserved.
//

#import "PreferenceController.h"
NSString * const BNRTableBgColorKey = @"TableBackgroundColor";
NSString * const BNREmptyDocKey = @"EmptyDocumentFlag";

@implementation PreferenceController

-(id)init {
    if (![super initWithWindowNibName:@"Preferences"]) {
        return  nil;
    }
    return self;
}

-(NSColor *)tableBgColor {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *colorAsData = [defaults objectForKey:BNRTableBgColorKey];
    return [NSKeyedUnarchiver unarchiveObjectWithData:colorAsData];
}

-(BOOL)emptyDoc {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:BNREmptyDocKey];
}

-(void)windowDidLoad {
    [colorWell setColor:[self tableBgColor]];
    [checkbox setState:[self emptyDoc]];
    NSLog(@"Nib file is loaded");
}

-(IBAction)changeBackgoundColor:(id)sender {
    NSColor *color = [colorWell color];
    NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:color];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:colorAsData forKey:BNRTableBgColorKey];
    NSLog(@"Color changed: %@", color);
}

-(IBAction)changeNewEmptyDoc:(id)sender {
    long state = [checkbox state];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:state forKey:BNREmptyDocKey];
    NSLog(@"Checkbox changed %lu", state);
}

@end
