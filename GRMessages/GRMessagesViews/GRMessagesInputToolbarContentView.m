//
//  GRMessagesInputToolbarContentView.m
//  GRMessages
//
//  Created by chengbin on 15/12/30.
//  Copyright © 2015年 chengbin. All rights reserved.
//

#import "GRMessagesInputToolbarContentView.h"
#import "GRMessagesTextView.h"
#import "UIView+InputToolbarContentViewLayoutEdge.h"

const CGFloat kGRMessagesInputToolbarContentViewHorizontalSpaceContaraintDefault = 8.0f;

@interface GRMessagesInputToolbarContentView()

@property (nonatomic, weak, readwrite) IBOutlet GRMessagesTextView *textView;
@property (nonatomic, weak, readwrite) IBOutlet UIView *leftBarButtonContainerView;
@property (nonatomic, weak, readwrite) IBOutlet UIView *leftSecondBarButtonContainerView;
@property (nonatomic, weak, readwrite) IBOutlet UIView *rightBarButtonContainerView;


@property (nonatomic, weak, readwrite) IBOutlet NSLayoutConstraint *leftBarButtonContainerViewWidthContraint;
@property (nonatomic, weak, readwrite) IBOutlet NSLayoutConstraint *leftSecondBarButtonContainerViewWidthContraint;
@property (nonatomic, weak, readwrite) IBOutlet NSLayoutConstraint *rightBarButtonContainerViewWidthContraint;

@property (nonatomic, weak, readwrite) IBOutlet NSLayoutConstraint *leftBarButtonContainerViewHeightContraint;
@property (nonatomic, weak, readwrite) IBOutlet NSLayoutConstraint *leftSecondBarButtonContainerViewHeightContraint;
@property (nonatomic, weak, readwrite) IBOutlet NSLayoutConstraint *rightBarButtonContainerViewHeightContraint;


@property (nonatomic, weak, readwrite) IBOutlet NSLayoutConstraint *leftHorizontalSpaceContraint;
@property (nonatomic, weak, readwrite) IBOutlet NSLayoutConstraint *rightHorizontalSpaceContraint;


@property (nonatomic, weak, readwrite) IBOutlet NSLayoutConstraint *leftVerticalSpaceBottomContraint;
@property (nonatomic, weak, readwrite) IBOutlet NSLayoutConstraint *leftSecondVerticalSpaceBottomContraint;
@property (nonatomic, weak, readwrite) IBOutlet NSLayoutConstraint *textViewVerticalSpaceBottomContranit;
@property (nonatomic, weak, readwrite) IBOutlet NSLayoutConstraint *textViewVerticalSpaceTopContranit;
@property (nonatomic, weak, readwrite) IBOutlet NSLayoutConstraint *rightVerticalSpaceBottomContraint;


@end

@implementation GRMessagesInputToolbarContentView
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.backgroundColor = [UIColor clearColor];
    _leftHorizontalSpaceContraint.constant = kGRMessagesInputToolbarContentViewHorizontalSpaceContaraintDefault;
    _rightHorizontalSpaceContraint.constant = kGRMessagesInputToolbarContentViewHorizontalSpaceContaraintDefault;
 
}
-(void)dealloc{
    _textView = nil;
    _leftBarButtonContainerView = nil;
    _leftSecondBarButtonContainerView = nil;
    _rightBarButtonContainerView = nil;
    
    _leftBarButtonItem = nil;
    _leftSecondBarButtonItem = nil;
    _rightBarButtonItem = nil;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -- Private Methods
-(void)_addSubview:(UIButton *)item ToView:(UIView *)containerView WithConstraint:(NSLayoutConstraint *)constraint AndSpace:(CGFloat)space{
  
        if (CGRectEqualToRect(item.frame, CGRectZero)) {
            item.frame = containerView.frame;
        }
         containerView.hidden = NO;
        if (constraint) {
            constraint.constant = space;
        }
    
        self.leftBarButtonItemWidth = CGRectGetWidth(item.frame);
        [item setTranslatesAutoresizingMaskIntoConstraints:NO];
        [containerView addSubview:item];
        [containerView bringSubviewToFront:item];
        [containerView grmsg_insertSubView:item constant:0.0f];
        
        [containerView setNeedsUpdateConstraints];
        [containerView updateConstraintsIfNeeded];

}

#pragma mark -- Setters
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)setLeftBarButtonItem:(UIButton *)leftBarButtonItem{
    if (_leftBarButtonItem) {
        [_leftBarButtonItem removeFromSuperview];
    }
    if (!leftBarButtonItem) {
        _leftBarButtonItem = nil;
        _leftBarButtonContainerView.hidden = YES;
        _leftHorizontalSpaceContraint.constant = 0.0f;
        self.leftBarButtonItemWidth = 0.0f;
        return;
    }
    [self _addSubview:leftBarButtonItem ToView:_leftBarButtonContainerView WithConstraint:_leftHorizontalSpaceContraint AndSpace:kGRMessagesInputToolbarContentViewHorizontalSpaceContaraintDefault];
    _leftBarButtonItem = leftBarButtonItem;
}
-(void)setLeftSecondBarButtonItem:(UIButton *)leftSecondBarButtonItem{
    if (_leftSecondBarButtonItem) {
        [_leftSecondBarButtonItem removeFromSuperview];
    }
    if (!leftSecondBarButtonItem) {
        _leftSecondBarButtonContainerView.hidden = YES;
        _leftSecondBarButtonItem = nil;
        self.leftSecondBarButtonItemWidth = 0.0f;
        return;
    }
    [self _addSubview:leftSecondBarButtonItem ToView:_leftSecondBarButtonContainerView WithConstraint:nil AndSpace:0];
    _leftSecondBarButtonItem = leftSecondBarButtonItem;
}

-(void)setRightBarButtonItem:(UIButton *)rightBarButtonItem{
    
    if (_rightBarButtonItem) {
        [_rightBarButtonItem removeFromSuperview];
    }
    if (!rightBarButtonItem) {
        _rightBarButtonItem.hidden = YES;
        _rightBarButtonItem = nil;
        _rightHorizontalSpaceContraint.constant = 0.0f;
        self.rightBarButtonItemWidth = 0.0f;
        return;
    }
    [self _addSubview:rightBarButtonItem ToView:_rightBarButtonContainerView WithConstraint:_rightHorizontalSpaceContraint AndSpace:kGRMessagesInputToolbarContentViewHorizontalSpaceContaraintDefault];
    _rightBarButtonItem = rightBarButtonItem;
    
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setLeftBarButtonItemBackgroundColor:(UIColor *)leftBarButtonItemBackgroundColor{
    self.leftBarButtonContainerView.backgroundColor = leftBarButtonItemBackgroundColor;
    self.leftBarButtonItem.backgroundColor = leftBarButtonItemBackgroundColor;
}
-(void)setLeftSecondBarButtonItemBackgroundColor:(UIColor *)leftSecondBarButtonItemBackgroundColor{
    self.leftSecondBarButtonContainerView.backgroundColor = leftSecondBarButtonItemBackgroundColor;
    self.leftSecondBarButtonItem.backgroundColor = leftSecondBarButtonItemBackgroundColor;
}
-(void)setTextViewBackgroundColor:(UIColor *)textViewBackgroundColor{
    self.textView.backgroundColor = textViewBackgroundColor;
    
}

-(void)setRightBarButtonItemBackgroundColor:(UIColor *)rightBarButtonItemBackgroundColor{
    self.rightBarButtonContainerView.backgroundColor = rightBarButtonItemBackgroundColor;
    self.rightBarButtonItem.backgroundColor= rightBarButtonItemBackgroundColor;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)setLeftBarButtonItemWidth:(CGFloat)leftBarButtonItemWidth{
    
    self.leftBarButtonContainerViewWidthContraint.constant = leftBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)setLeftSecondBarButtonItemWidth:(CGFloat)leftSecondBarButtonItemWidth{
    
    self.leftSecondBarButtonContainerViewWidthContraint.constant = leftSecondBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)setRightBarButtonItemWidth:(CGFloat)rightBarButtonItemWidth{
    self.rightBarButtonContainerViewWidthContraint.constant = rightBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)setLeftBarButtonItemHeight:(CGFloat)leftBarButtonItemHeight{
    self.leftBarButtonContainerViewHeightContraint.constant = leftBarButtonItemHeight;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)setLeftSecondBarButtonItemHeight:(CGFloat)leftSecondBarButtonItemHeight{
    self.leftSecondBarButtonContainerViewHeightContraint.constant = leftSecondBarButtonItemHeight;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)setRightBarButtonItemHeight:(CGFloat)rightBarButtonItemHeight{
    
    self.rightBarButtonContainerViewHeightContraint.constant =rightBarButtonItemHeight;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)setLeftContainerPadding:(CGFloat)leftContainerPadding{
    self.leftHorizontalSpaceContraint.constant = leftContainerPadding;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)setLeftSecondContainerPadding:(CGFloat)leftSecondContainerPadding{
    self.leftSecondBarButtonContainerViewWidthContraint.constant = leftSecondContainerPadding;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)setRightContainerPadding:(CGFloat)rightContainerPadding{
    self.rightHorizontalSpaceContraint.constant = rightContainerPadding;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setLeftContainerBottomPadding:(CGFloat)leftContainerBottomPadding{
    self.leftVerticalSpaceBottomContraint.constant = leftContainerBottomPadding;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)setLeftSecondContainerBottomPadding:(CGFloat)leftSecondContainerBottomPadding{
    self.leftSecondVerticalSpaceBottomContraint.constant = leftSecondContainerBottomPadding;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)setTextViewBottomPadding:(CGFloat)textViewBottomPadding{
    self.textViewVerticalSpaceBottomContranit.constant = textViewBottomPadding;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)setTextViewTopPadding:(CGFloat)textViewTopPadding{
    self.textViewVerticalSpaceTopContranit.constant = textViewTopPadding;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)setRightContainerBottomPadding:(CGFloat)rightContainerBottomPadding{
    [self.textViewVerticalSpaceTopContranit setConstant:rightContainerBottomPadding];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -- Getters
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(UIColor *)leftBarButtonItemBackgroundColor{
    return self.leftBarButtonContainerView.backgroundColor;
}
-(UIColor *)leftSecondBarButtonItemBackgroundColor{
    return self.leftSecondBarButtonContainerView.backgroundColor;
}
-(UIColor *)textViewBackgroundColor{
    return self.textView.backgroundColor;
}
-(UIColor *)rightBarButtonItemBackgroundColor{
    return self.rightBarButtonContainerView.backgroundColor;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(CGFloat)leftBarButtonItemHeight{
    return self.leftBarButtonContainerViewHeightContraint.constant;
}
-(CGFloat)leftSecondBarButtonItemHeight{
    return self.leftSecondBarButtonContainerViewHeightContraint.constant;
}
-(CGFloat)rightBarButtonItemHeight{
    return self.rightBarButtonContainerViewHeightContraint.constant;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(CGFloat)leftBarButtonItemWidth{
    return self.leftBarButtonContainerViewWidthContraint.constant;
}
-(CGFloat)leftSecondBarButtonItemWidth{
    return self.leftSecondBarButtonContainerViewWidthContraint.constant;
}
-(CGFloat)rightBarButtonItemWidth{
    return self.rightBarButtonContainerViewWidthContraint.constant;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(CGFloat)leftContainerPadding{
    return self.leftHorizontalSpaceContraint.constant;
}
-(CGFloat)leftSecondContainerPadding{
    return self.leftSecondBarButtonContainerViewWidthContraint.constant;
}
-(CGFloat)rightContainerPadding{
    return self.rightHorizontalSpaceContraint.constant;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(CGFloat)leftContainerBottomPadding{
    return self.leftVerticalSpaceBottomContraint.constant;
}
-(CGFloat)leftSecondContainerBottomPadding{
    return self.leftSecondVerticalSpaceBottomContraint.constant;
}
-(CGFloat)textViewBottomPadding{
    return self.textViewVerticalSpaceBottomContranit.constant;
}
-(CGFloat)textViewTopPadding{
    return self.textViewVerticalSpaceTopContranit.constant;
}
-(CGFloat)rightContainerBottomPadding{
    return self.rightVerticalSpaceBottomContraint.constant;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -- overrides view
-(void)setNeedsDisplay{
    [super setNeedsDisplay];
    [self.textView setNeedsDisplay];
}
@end
