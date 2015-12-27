//
//  AppController.m
//  RaiseMan
//
//  Created by namhyun on 2015. 12. 27..
//  Copyright © 2015년 2Fworkshop. All rights reserved.
//

#import "AppController.h"
#import "PreferenceController.h"

@implementation AppController

+(void)initialize {
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
    NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:[NSColor yellowColor]];
    
    [defaultValues setObject:colorAsData forKey:BNRTableBgColorKey];
    [defaultValues setObject:[NSNumber numberWithBool:YES] forKey:BNREmptyDocKey];
    
    [[NSUserDefaults standardUserDefaults]registerDefaults:defaultValues];
    NSLog(@"registered defaults: %@", defaultValues);
}

-(IBAction)showPreferencePanel:(id)sender {
    if (!preferenceController) {
        preferenceController = [[PreferenceController alloc]init];
    }
    NSLog(@"showing %@", preferenceController);
    [preferenceController showWindow:self];
}

-(BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender {
    NSLog(@"applicationShouldOpenUntitledFile:");
    return [[NSUserDefaults standardUserDefaults]boolForKey:BNREmptyDocKey];
}

@end
