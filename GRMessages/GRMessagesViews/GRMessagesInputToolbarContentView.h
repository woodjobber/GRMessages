//
//  GRMessagesInputToolbarContentView.h
//  GRMessages
//
//  Created by chengbin on 15/12/30.
//  Copyright © 2015年 chengbin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GRMessagesTextView;
FOUNDATION_EXPORT const CGFloat kGRMessagesInputToolbarContentViewHorizontalSpaceContaraintDefault;

@interface GRMessagesInputToolbarContentView : UIView

//Container View

@property (nonatomic, weak, readonly) GRMessagesTextView *textView;

@property (nonatomic, weak, readonly) UIView *leftBarButtonContainerView;
@property (nonatomic, weak, readonly) UIView *leftSecondBarButtonContainerView;
@property (nonatomic, weak, readonly) UIView *rightBarButtonContainerView;

//Button

@property (nonatomic, weak, readwrite) UIButton *leftBarButtonItem;
@property (nonatomic, weak, readwrite) UIButton *leftSecondBarButtonItem;
@property (nonatomic, weak, readwrite) UIButton *rightBarButtonItem;

//Padding Horizontal

@property (nonatomic, assign) CGFloat leftContainerPadding;
@property (nonatomic, assign) CGFloat rightContainerPadding;
@property (nonatomic, assign) CGFloat leftSecondContainerPadding;

//Padding Vertical

@property (nonatomic, assign) CGFloat leftContainerBottomPadding;
@property (nonatomic, assign) CGFloat leftSecondContainerBottomPadding;
@property (nonatomic, assign) CGFloat textViewBottomPadding;
@property (nonatomic, assign) CGFloat textViewTopPadding;
@property (nonatomic, assign) CGFloat rightContainerBottomPadding;

//Width

@property (nonatomic, assign) CGFloat leftBarButtonItemWidth;
@property (nonatomic, assign) CGFloat leftSecondBarButtonItemWidth;
@property (nonatomic, assign) CGFloat rightBarButtonItemWidth;

//Height

@property (nonatomic, assign) CGFloat leftBarButtonItemHeight;
@property (nonatomic, assign) CGFloat leftSecondBarButtonItemHeight;
@property (nonatomic, assign) CGFloat rightBarButtonItemHeight;


//BackgroundColor

@property (nonatomic, weak) UIColor *leftBarButtonItemBackgroundColor;
@property (nonatomic, weak) UIColor *leftSecondBarButtonItemBackgroundColor;
@property (nonatomic, weak) UIColor *textViewBackgroundColor;
@property (nonatomic, weak) UIColor *rightBarButtonItemBackgroundColor;

@end
