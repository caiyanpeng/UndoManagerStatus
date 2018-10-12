//
//  DrawView.m
//  cai_commondModelTest
//
//  Created by Chengguangfa on 2018/10/12.
//  Copyright © 2018年 com.medosport.mo. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView
{
    int _a;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self becomeFirstResponder];
        _a = 0;
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)undo{
    if ([self.undoManager canUndo]) {
        [self.undoManager undo];
    }
}
-(void)redo{
    if ([self.undoManager canRedo]) {
        [self.undoManager redo];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 实现组撤销
    [self.undoManager beginUndoGrouping];
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSInvocation *add = [self addInvocation];
    NSInvocation *undo = [self undoInvocation];

    [self executeInvocation:add withUndoInvocation:undo];

//    [self add];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.undoManager endUndoGrouping];
}

-(void)executeInvocation:(NSInvocation *)invocation withUndoInvocation:(NSInvocation *)undoInvocation{
    [invocation retainArguments];
    [[self.undoManager prepareWithInvocationTarget:self] unexecuteInvocation:undoInvocation withRedoInvocation:invocation];
    
    [invocation invoke];
    
    if (self.delegate) {
        [self.delegate drawViewDidChanged:_a];
    }
}

-(void)unexecuteInvocation:(NSInvocation *)invocation withRedoInvocation:(NSInvocation *)redoInvocation{
    
    [[self.undoManager prepareWithInvocationTarget:self] executeInvocation:redoInvocation withUndoInvocation:invocation];
    
    [invocation invoke];
    
    if (self.delegate) {
        [self.delegate drawViewDidChanged:_a];
    }
}
#pragma mark --使用Invocation 实现方法--
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
    
    _a++;
    
    
    //直接使用方法
//    [[self.undoManager prepareWithInvocationTarget:self] delete];
////
//    if (self.delegate) {
//        [self.delegate drawViewDidChanged:_a];
//    }
}

-(void)delete{
    
    _a--;
     //直接使用方法
//    [[self.undoManager prepareWithInvocationTarget:self] add];
//
//    if (self.delegate) {
//        [self.delegate drawViewDidChanged:_a];
//    }
}

@end
