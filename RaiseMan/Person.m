//
//  Person.m
//  RaiseMan
//
//  Created by namhyun on 2015. 12. 25..
//  Copyright © 2015년 2Fworkshop. All rights reserved.
//

#import "Person.h"

@implementation Person

-(id)init {
    self = [super init];
    expectedRaise = 5.0;
    personName = @"New Person";
    return self;
}

-(void)setNilValueForKey:(NSString *)key {
    if ([key isEqual:@"expectedRaise"]) {
        [self setExpectedRaise:0.0];
    } else {
        [super setNilValueForKey:key];
    }
}

@synthesize personName;
@synthesize expectedRaise;
@end