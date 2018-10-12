//
//  ViewController.m
//  cai_commondModelTest
//
//  Created by Chengguangfa on 2018/10/11.
//  Copyright © 2018年 com.medosport.mo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *value;

@end

@implementation ViewController
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
//    [self.undoManger beginUndoGrouping];
    
    for (int i = 0; i<5; ++i) {
        

        
    }
    
    NSInvocation *add = [self addInvocation];
    NSInvocation *undo = [self undoInvocation];
    
    [self executeInvocation:add withUndoInvocation:undo];
    
//    [self.undoManger endUndoGrouping];

    

    
}
- (IBAction)undo:(id)sender {
    
    [self.undoManager undo];
    
}
- (IBAction)redo:(id)sender {
    [self.undoManager redo];
}

-(void)executeInvocation:(NSInvocation *)invocation withUndoInvocation:(NSInvocation *)undoInvocation{
//    [invocation retainArguments];
    [[self.undoManager prepareWithInvocationTarget:self] unexecuteInvocation:undoInvocation withRedoInvocation:invocation];
    
    [invocation invoke];
    
}

-(void)unexecuteInvocation:(NSInvocation *)invocation withRedoInvocation:(NSInvocation *)redoInvocation{
    
    [[self.undoManager prepareWithInvocationTarget:self] executeInvocation:redoInvocation withUndoInvocation:invocation];
    
    [invocation invoke];
    
}



-(NSInvocation *)addInvocation{
    NSMethodSignature *sign = [self methodSignatureForSelector:@selector(add)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sign];
    [invocation setTarget:self];
    [invocation setSelector:@selector(add)];
    
    return invocation;
}
-(NSInvocation *)undoInvocation{
    NSMethodSignature *sign = [self methodSignatureForSelector:@selector(delete)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sign];
    [invocation setTarget:self];
    [invocation setSelector:@selector(delete)];
    
    return invocation;
}

-(void)add{
    NSString *value = self.value.text;
    int intV = [value intValue] + 1;
    self.value.text = [NSString stringWithFormat:@"%d",intV];
}

-(void)delete{
    NSString *value = self.value.text;
    int intV = [value intValue] - 1;
    self.value.text = [NSString stringWithFormat:@"%d",intV];
}

@end
