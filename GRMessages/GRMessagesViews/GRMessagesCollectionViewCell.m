//
//  GRMessagesCollectionViewCell.m
//  GRMessages
//
//  Created by chengbin on 16/1/18.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesCollectionViewCell.h"
@interface GRMessagesCollectionViewCell()

@property (weak, nonatomic, readwrite) IBOutlet GRMessagesLabel *cellTopLabel;

@property (weak, nonatomic, readwrite) IBOutlet GRMessagesLabel *messageBubbleTopLabel;

@property (weak, nonatomic, readwrite) IBOutlet GRMessagesLabel *cellBottomLabel;

@property (weak, nonatomic, readwrite) IBOutlet GRMessagesCellTextView *cellTextView;

@property (weak, nonatomic, readwrite) IBOutlet UIImageView *messageBubbleImageView;

@property (weak, nonatomic, readwrite) IBOutlet UIView *messageBubbleContainerView;

@property (weak, nonatomic, readwrite) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic, readwrite) IBOutlet UIView *avatarContainerView;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageBubbleContainerWidthConstraint;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewTopVericalSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomVerticalSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewAvatarHorizontalSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewMarginHorizontalSpaceConstraint;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellTopLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageBubbleTopLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellBottomLabelHeightConstraint;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarContainerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarContainerViewHeighConstraint;



@end

@implementation GRMessagesCollectionViewCell

@end
