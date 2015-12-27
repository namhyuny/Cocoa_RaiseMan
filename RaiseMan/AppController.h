//
//  AppController.h
//  RaiseMan
//
//  Created by namhyun on 2015. 12. 27..
//  Copyright © 2015년 2Fworkshop. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class PreferenceController;

@interface AppController : NSObject {
    PreferenceController *preferenceController;
}
-(IBAction)showPreferencePanel:(id)sender;

@end