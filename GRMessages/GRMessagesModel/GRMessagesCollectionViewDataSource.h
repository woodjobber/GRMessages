//
//  GRMessagesCollectionViewDataSource.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GRMessagesCollectionView;
@protocol GRMessagesData;
@protocol GRMessagesBubbleImageDataSource;
@protocol GRMessagesAvatarImageDataSource;

@protocol GRMessagesCollectionViewDataSource <UICollectionViewDataSource>
@required
- (NSString *)senderDisplayName;

- (NSString *)senderId;

- (id <GRMessagesData>)collectionView:(GRMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(GRMessagesCollectionView *)collectionView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath;

- (id <GRMessagesBubbleImageDataSource>)collectionView:(GRMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath;

- (id <GRMessagesAvatarImageDataSource>)collectionView:(GRMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSAttributedString *)collectionView:(GRMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath;

- (NSAttributedString *)collectionView:(GRMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath;

- (NSAttributedString *)collectionView:(GRMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath;

@end