//
//  GRMessagesInputToolbar.h
//  GRMessages
//
//  Created by chengbin on 15/12/30.
//  Copyright © 2015年 chengbin. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class GRMessagesInputToolbarContentView;
@class GRMessagesInputToolbar;
@class GRMessagesGarbageView;
@class GRMessagesSlideView;
@protocol GRMessagesInputToolBarDelegate <UIToolbarDelegate>

//- (void)grmsg_InputToolbar:(GRMessagesInputToolbar *)toolbar didPressRightBarButton:(UIButton *)sender;
- (void)grmsg_InputToolbar:(GRMessagesInputToolbar *)toolbar didPressLeftBarButton:(UIButton *)sender;
- (void)grmsg_InputToolbar:(GRMessagesInputToolbar *)toolbar didPressLeftSecondBarButton:(UIButton *)sender;

@end

@interface GRMessagesInputToolbar : UIToolbar
{
    id<GRMessagesInputToolBarDelegate> __weak _delegate;
}
@property (nonatomic, strong, readonly)GRMessagesInputToolbarContentView *contentView;

@property (nonatomic, strong, readonly)GRMessagesSlideView *slideView;

@property (nonatomic, strong, readonly)GRMessagesGarbageView *garbageView;

@property (nonatomic, weak) id<GRMessagesInputToolBarDelegate>delegate;

@property (nonatomic, assign) BOOL voiceButtonEnableOnRight;

@property (nonatomic, assign) CGFloat maxinumHeight;

@property (nonatomic, assign) CGFloat mininumHeight;


- (void)toggleVoiceButtonEnabled;

- (GRMessagesInputToolbarContentView *)loadGRMessagesInputToolBarContentView;
@end


