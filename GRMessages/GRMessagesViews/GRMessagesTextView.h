//
//  GRMessagesTextView.h
//  GRMessages
//
//  Created by chengbin on 15/12/30.
//  Copyright © 2015年 chengbin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GRMessagesTextView;
@protocol GRMessagesTextViewPasteDelegate <NSObject>
-(BOOL)grmsg_TextView:(GRMessagesTextView *)textView shouldPasteWithSender:(id)sender;
@end
@interface GRMessagesTextView : UITextView
@property (nonatomic, strong) UIColor *placeHolderTextColor;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, assign) BOOL displayPlaceHolder;
@property (nonatomic, weak) id<GRMessagesTextViewPasteDelegate> pasteDelegate;
-(BOOL)hasText;
@end

