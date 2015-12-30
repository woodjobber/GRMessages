//
//  GRMessagesInputToolbarContentView.m
//  GRMessages
//
//  Created by chengbin on 15/12/30.
//  Copyright © 2015年 chengbin. All rights reserved.
//

#import "GRMessagesInputToolbarContentView.h"
#import "GRMessagesTextView.h"
const CGFloat kGRMessagesInputToolbarContentViewHorizontalSpaceContaraintDefault = 8.0f;

@interface GRMessagesInputToolbarContentView()
@property (nonatomic, weak) IBOutlet GRMessagesTextView *textView;
@property (nonatomic, weak) IBOutlet UIView *leftBarButtonContainerView;
@property (nonatomic, weak) IBOutlet UIView *leftSecondBarButtonContainerView;
@property (nonatomic, weak) IBOutlet UIView *rightBarButtonContainerView;


@property (nonatomic, weak) IBOutlet NSLayoutConstraint *leftBarButtonContainerViewWidthContraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *leftSecondBarButtonContainerViewWidthContraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *rightBarButtonContainerViewWidthContraint;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *leftBarButtonContainerViewHeightContraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *leftSecondBarButtonContainerViewHeightContraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *rightBarButtonContainerViewHeightContraint;


@property (nonatomic, weak) IBOutlet NSLayoutConstraint *leftHorizontalSpaceContraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *rightHorizontalSpaceContraint;


@end

@implementation GRMessagesInputToolbarContentView



@end
