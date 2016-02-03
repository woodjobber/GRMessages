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

@property (assign, nonatomic) UIEdgeInsets textViewFrameInsets;
@property (assign, nonatomic) CGSize avatarViewSize;
@property (weak, nonatomic, readwrite) UITapGestureRecognizer *tapGestrueRecognizer;


@end
static NSMutableSet * GRMessagesCollectionViewCellActions = nil;
@implementation GRMessagesCollectionViewCell

+ (void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        GRMessagesCollectionViewCellActions = [NSMutableSet new];
    });
}
#pragma mark- Public Methods
+ (UINib *)nib{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle bundleForClass:[self class]]];
}

+ (NSString *)cellReuseIdentifier{
    return NSStringFromClass([self class]);
}

+ (NSString *)mediaCellReuseIndentfier{
    return [NSString stringWithFormat:@"%@_GRMedia",NSStringFromClass([self class])];
}
+ (void)registerMenuAction:(SEL)action{
    [GRMessagesCollectionViewCellActions addObject:NSStringFromSelector(action)];
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
     self.backgroundColor = [UIColor whiteColor];
    
    self.cellTopLabelHeightConstraint.constant = 0.0f;
    self.messageBubbleTopLabelHeightConstraint.constant = 0.0f;
    self.cellBottomLabelHeightConstraint.constant = 0.0f;
    
    self.avatarViewSize = CGSizeZero;
    
    self.cellTopLabel.textAlignment = NSTextAlignmentCenter;
    self.cellTopLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    self.cellTopLabel.textColor = [UIColor lightGrayColor];
    
    self.messageBubbleTopLabel.font = [UIFont systemFontOfSize:12.0f];
    self.messageBubbleTopLabel.textColor = [UIColor lightGrayColor];
    
    self.cellBottomLabel.font = [UIFont systemFontOfSize:11.0f];
    self.cellBottomLabel.textColor = [UIColor lightGrayColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_handleTapGestrue:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    self.tapGestrueRecognizer = tap;
}



- (CGSize)avatarViewSize{
    return CGSizeMake(self.avatarContainerViewWidthConstraint.constant, self.avatarContainerViewHeighConstraint.constant);
}
- (UIEdgeInsets)textViewFrameInsets{
    return UIEdgeInsetsMake(self.textViewTopVericalSpaceConstraint.constant, self.textViewMarginHorizontalSpaceConstraint.constant, self.textViewBottomVerticalSpaceConstraint.constant, self.textViewMarginHorizontalSpaceConstraint.constant);
}

- (void)_updateConstraint:(NSLayoutConstraint *)constraint withConstant:(CGFloat)constant{
    if (constraint.constant == constant) {
        return;
    }
    constraint.constant = constant;
}
#pragma mark- Private Methods

- (void)_handleTapGestrue:(UITapGestureRecognizer *)tap{
    
    CGPoint pt = [tap locationInView:self];
    if (CGRectContainsPoint(self.avatarContainerView.frame, pt)) {
        if ([self.cellDelegate respondsToSelector:@selector(messagesCollectionViewCellDidTapAvatar:)]) {
            [self.cellDelegate messagesCollectionViewCellDidTapAvatar:self];
        }
    }else if (CGRectContainsPoint(self.messageBubbleContainerView.frame, pt)){
        if ([self.cellDelegate respondsToSelector:@selector(messagesCollectionViewCellDidTapMessageBubble:)]) {
            [self.cellDelegate messagesCollectionViewCellDidTapMessageBubble:self];
        }
    }else{
        if ([self.cellDelegate respondsToSelector:@selector(messagesCollectionViewCellDidTapCell:atPositon:)]) {
            [self.cellDelegate messagesCollectionViewCellDidTapCell:self atPositon:pt];
        }
    }
 
}

- (BOOL)_gestrueRecognizer:(UITapGestureRecognizer *)gestureReconginzer shouldReceiveTouch:(UITouch *)touch{
    CGPoint pt = [touch locationInView:self];
    if ([gestureReconginzer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        return CGRectContainsPoint(self.messageBubbleContainerView.frame, pt);
    }
    return YES;
}
@end
