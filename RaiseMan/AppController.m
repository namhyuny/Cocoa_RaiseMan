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

-(IBAction)showPreferencePanel:(id)sender {
    if (!preferenceController) {
        preferenceController = [[PreferenceController alloc]init];
    }
    NSLog(@"showing %@", preferenceController);
    [preferenceController showWindow:self];
}

@end
