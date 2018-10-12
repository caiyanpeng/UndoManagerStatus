//
//  DrawView.h
//  cai_commondModelTest
//
//  Created by Chengguangfa on 2018/10/12.
//  Copyright © 2018年 com.medosport.mo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DrawViewDelegate<NSObject>

-(void)drawViewDidChanged:(int)type;

@end

@interface DrawView : UIView
@property (weak, nonatomic) id<DrawViewDelegate> delegate;
-(void)undo;
-(void)redo;
@end
