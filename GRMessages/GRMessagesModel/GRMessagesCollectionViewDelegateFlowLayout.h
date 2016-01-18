//
//  GRMessagesCollectionViewDelegateFlowLayout.h
//  GRMessages
//
//  Created by chengbin on 16/1/18.
//  Copyright © 2016年 chengbin. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GRMessagesCollectionView;
@class GRMessagesCollectionViewFlowLayout;
@class GRMessagesLoadEarlierHeaderView;
@class GRMessagesCollectionViewCell;

@protocol GRMessagesCollectionViewFlowLayout <UICollectionViewDelegateFlowLayout>

@optional

- (CGFloat)collectionView:(GRMessagesCollectionView *)collectionView layout:(GRMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)collectionView:(GRMessagesCollectionView *)collectionView layout:(GRMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)collectionView:(GRMessagesCollectionView *)collectionView layout:(GRMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(GRMessagesCollectionView *)collectionView headerView:(GRMessagesLoadEarlierHeaderView *)headerView didTapLoadEarlierMessagaesButton:(UIButton *)sender;

- (void)collectionView:(GRMessagesCollectionView *)collectionView didTapCellAtIndexPath:(NSIndexPath *)indexPath touchPoint:(CGPoint)touchPoint;

- (void)collectionView:(GRMessagesCollectionView *)collectionView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(GRMessagesCollectionView *)collectionView didTapAvatarImageView:(UIImageView *)avatarImageView atIndexPath:(NSIndexPath *)indexPath;
@end

