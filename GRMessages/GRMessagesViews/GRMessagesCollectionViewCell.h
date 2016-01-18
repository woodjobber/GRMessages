//
//  GRMessagesCollectionViewCell.h
//  GRMessages
//
//  Created by chengbin on 16/1/18.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRMessagesCellTextView.h"
#import "GRMessagesLabel.h"
@class GRMessagesCollectionViewCell;

@protocol GRMessagesCollectionViewCellDelegate <NSObject>

- (void)messagesCollectionViewCellDidTapAvatar:(GRMessagesCollectionViewCell *)cell;

- (void)messagesCollectionViewCellDidTapMessageBubble:(GRMessagesCollectionViewCell *)cell;

- (void)messagesCollectionViewCellDidTapCell:(GRMessagesCollectionViewCell *)cell;

- (void)messagesCollectionViewCellDidTapCell:(GRMessagesCollectionViewCell *)cell atPositon:(CGPoint)postion;

- (void)messagesCollectionViewCell:(GRMessagesCollectionViewCell *)cell didPerformAction:(SEL)action withSender:(id)sender;
@end

@interface GRMessagesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) id<GRMessagesCollectionViewCellDelegate>cellDelegate;

@property (weak, nonatomic, readonly) GRMessagesLabel *cellTopLabel;

@property (weak, nonatomic, readonly) GRMessagesLabel *messageBubbleTopLabel;

@property (weak, nonatomic, readonly) GRMessagesLabel *cellBottomLabel;

@property (weak, nonatomic, readonly) GRMessagesCellTextView *cellTextView;

@property (weak, nonatomic, readonly) UIImageView *messageBubbleImageView;

@property (weak, nonatomic, readonly) UIView *messageBubbleContainerView;

@property (weak, nonatomic, readonly) UIImageView *avatarImageView;

@property (weak, nonatomic, readonly) UIView *avatarContainerView;

@property (weak, nonatomic) UIView *mediaView;

@property (weak, nonatomic, readonly) UITapGestureRecognizer *tapGestureRecognizer;

+ (UINib *)nib;

+ (NSString *)cellReuseIdentifier;

+ (NSString *)mediaCellReuseIndentfier;

+ (void)registerMenuAction:(SEL)action;

@end
