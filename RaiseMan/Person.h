//
//  Person.h
//  RaiseMan
//
//  Created by namhyun on 2015. 12. 25..
//  Copyright © 2015년 2Fworkshop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject {
    NSString *personName;
    float expectedRaise;
}
@property (readwrite, copy) NSString *personName;
@property (readwrite) float expectedRaise;
@end