//
//  Document.h
//  RaiseMan
//
//  Created by namhyun on 2015. 12. 25..
//  Copyright © 2015년 2Fworkshop. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Person;

@interface Document : NSDocument {
    NSMutableArray *employees;
    IBOutlet NSTableView *tableView;
    IBOutlet NSArrayController *employeeController;
}
-(IBAction)createEmployee:(id)sender;
-(void)setEmployees:(NSMutableArray *)a;
-(void)removeObjectFromEmployeesAtIndex:(int)index;
-(void)insertObject:(Person *)p inEmployeesAtIndex:(int)index;
@end

