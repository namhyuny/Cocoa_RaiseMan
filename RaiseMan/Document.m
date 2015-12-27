//
//  Document.m
//  RaiseMan
//
//  Created by namhyun on 2015. 12. 25..
//  Copyright © 2015년 2Fworkshop. All rights reserved.
//

#import "Document.h"
#import "Person.h"
#import "PreferenceController.h"

@interface Document ()

@end

@implementation Document

-(id)init {
    self = [super init];
    employees = [[NSMutableArray alloc]init];
    return self;
}

-(void)insertObject:(Person *)p inEmployeesAtIndex:(int)index {
    NSLog(@"adding %@ to %@", p, employees);
    NSUndoManager *undo = [self undoManager];
    [[undo prepareWithInvocationTarget:self]removeObjectFromEmployeesAtIndex:index];
    if (![undo isUndoing]) {
        [undo setActionName:@"Insert Person"];
    }
    [self startObservingPerson:p];
    [employees insertObject:p atIndex:index];
}

-(void)removeObjectFromEmployeesAtIndex:(int)index {
    Person *p = [employees objectAtIndex:index];
    NSLog(@"removing %@ from %@", p, employees);
    NSUndoManager *undo = [self undoManager];
    [[undo prepareWithInvocationTarget:self] insertObject:p inEmployeesAtIndex:index];
    if (![undo isUndoing]) {
        [undo setActionName:@"Delete Person"];
    }
    [self stopObservingPerson:p];
    [employees removeObjectAtIndex:index];
}

-(void)startObservingPerson:(Person *)person {
    [person addObserver:self forKeyPath:@"personName" options:NSKeyValueObservingOptionOld context:NULL];
    [person addObserver:self forKeyPath:@"expectedRaise" options:NSKeyValueObservingOptionOld context:NULL];
}

-(void)stopObservingPerson:(Person *)person {
    [person removeObserver:self forKeyPath:@"personName"];
    [person removeObserver:self forKeyPath:@"expectedRaise"];
}

-(void)setEmployees:(NSMutableArray *)a {
    if (a == employees) {
        return;
    }
    for (Person *person in employees) {
        [self stopObservingPerson:person];
    }
    employees = a;
    for (Person *person in employees) {
        [self startObservingPerson:person];
    }
}

-(void)changeKeyPath:(NSString *)keyPath ofObject:(id)obj toValue:(id)newValue {
    [obj setValue:newValue forKeyPath:keyPath];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSUndoManager *undo = [self undoManager];
    id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
    
    if (oldValue == [NSNull null]) {
        oldValue = nil;
    }
    NSLog(@"oldVlaue = %@", oldValue);
    [[undo prepareWithInvocationTarget:self]changeKeyPath:keyPath ofObject:object toValue:oldValue];
    [undo setActionName:@"Edit"];
}

-(IBAction)createEmployee:(id)sender {
    NSWindow *w = [tableView window];
    
    BOOL editingEnded = [w makeFirstResponder:w];
    if (!editingEnded) {
        NSLog(@"Unable to end editing");
        return;
    }
    NSUndoManager *undo = [self undoManager];
    
    if ([undo groupingLevel]) {
        [undo endUndoGrouping];
        [undo beginUndoGrouping];
    }
    Person *p = [employeeController newObject];
    [employeeController addObject:p];
    [employeeController rearrangeObjects];
    NSArray *a = [employeeController arrangedObjects];
    
    long row = [a indexOfObjectIdenticalTo:p];
    NSLog(@"starting edit of %@ in row %ld", p, row);
    
    [tableView editColumn:0 row:row withEvent:nil select:YES];
}

/*
- (instancetype)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}
*/


//-----------Don't TOUCH!

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *colorAsData;
    colorAsData = [defaults objectForKey:BNRTableBgColorKey];
    [tableView setBackgroundColor:[NSKeyedUnarchiver unarchiveObjectWithData:colorAsData]];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace {
    return YES;
}

- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    
    //편집 종료
    [[tableView window]endEditingFor:nil];
    
    //emloyeess 배열로 부터 NSData 객체를 생성
    return [NSKeyedArchiver archivedDataWithRootObject:employees];
    
    /*
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return nil;
    */
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    
    NSLog(@"About to read data of type %@", typeName);
    NSMutableArray *newArray = nil;
    @try {
        newArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *exception) {
        if (outError) {
            NSDictionary *d = [NSDictionary dictionaryWithObject:@"The data is corrupted" forKey:NSLocalizedFailureReasonErrorKey];
            *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:d];
        }
        return NO;
    }
    @finally {
        [self setEmployees:newArray];
        return YES;
    }
    
    /*
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return YES;
    */
}


@end
