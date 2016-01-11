//
//  GRMessagesInputToolbar.m
//  GRMessages
//
//  Created by chengbin on 15/12/30.
//  Copyright © 2015年 chengbin. All rights reserved.
//

#import "GRMessagesInputToolbar.h"
#import "GRMessagesInputToolbarContentView.h"
#import "UIView+InputToolbarContentViewLayoutEdge.h"
#import "GRMessagesTextView.h"
#import "GRMessagesInputToolbarButtonFactroy.h"
#import "GRMessagesGarbageView.h"
#import "GRMessagesTextView.h"

static void *kGRMessagesInputToolbarKeyObserverContent = &kGRMessagesInputToolbarKeyObserverContent;
@interface GRMessagesInputToolbar ()
@property (nonatomic, assign) BOOL isObserving;
@end
@implementation GRMessagesInputToolbar
@synthesize delegate =_delegate;

#pragma mark - Initialization
- (void)awakeFromNib{
    [super awakeFromNib];
    [self buildView];
}
- (void)buildView{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.voiceButtonEnableOnRight = YES;
    self.isObserving = NO;
    self.mininumHeight = 44.0f;
    self.maxinumHeight = 120.0f;
    
    _contentView = ({
         GRMessagesInputToolbarContentView * inputToolbarContentView = [self loadGRMessagesInputToolBarContentView];
         inputToolbarContentView.frame = self.frame;
        [self addSubview:inputToolbarContentView];
        [self grmsg_insertSubView:inputToolbarContentView];
        [self setNeedsUpdateConstraints];
        inputToolbarContentView;
    });
    
    [self _addObservers];
    
    self.contentView.leftBarButtonItem = [GRMessagesInputToolbarButtonFactroy defaultAccessoryButtonItem];
    self.contentView.leftSecondBarButtonItem = [GRMessagesInputToolbarButtonFactroy defaultSecondAccessoryButtonItem];
    self.contentView.rightBarButtonItem = [GRMessagesInputToolbarButtonFactroy defaultVoiceButtonItem];

    [self toggleVoiceButtonEnabled];
}
-(void)dealloc{
    [self _removeObservers];
    _contentView = nil;
}

#pragma mark - Puplic Methods
-(void)toggleVoiceButtonEnabled{
    BOOL hasText = [self.contentView.textView hasText];
    if (self.voiceButtonEnableOnRight) {
        self.contentView.rightBarButtonItem.enabled = hasText;
    }else{
        self.contentView.leftBarButtonItem.enabled = hasText;
        self.contentView.leftSecondBarButtonItem.enabled = hasText;
    }
}

-(GRMessagesInputToolbarContentView *)loadGRMessagesInputToolBarContentView{
    NSArray *nibs =[[NSBundle bundleForClass:[GRMessagesInputToolbarContentView class]]loadNibNamed:NSStringFromClass([GRMessagesInputToolbarContentView class]) owner:nil options:nil];
    return nibs.count>0?[nibs firstObject]:nil;
}
#pragma mark Setters
-(void)setMininumHeight:(CGFloat)mininumHeight{
    NSParameterAssert(mininumHeight>0.0f);
    _mininumHeight = mininumHeight;
}

#pragma mark -
#pragma mark --- Private Methods
#pragma mark Key-value Observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (context == kGRMessagesInputToolbarKeyObserverContent) {
        if (object == self.contentView) {
            
            if ([keyPath isEqualToString:NSStringFromSelector(@selector(leftBarButtonItem))]) {
                [self.contentView.leftBarButtonItem removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
                [self.contentView.leftBarButtonItem addTarget:self action:@selector(_leftBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            }else if ([keyPath isEqualToString:NSStringFromSelector(@selector(leftSecondBarButtonItem))]){
                [self.contentView.leftSecondBarButtonItem removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
                [self.contentView.leftSecondBarButtonItem addTarget:self action:@selector(_leftSecondBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            }else if ([keyPath isEqualToString:NSStringFromSelector(@selector(rightBarButtonItem))]){
                
                [self.contentView.rightBarButtonItem removeTarget:self action:NULL forControlEvents:UIControlEventTouchDown];
                [self.contentView.rightBarButtonItem removeTarget:self action:NULL forControlEvents:UIControlEventTouchDragInside|UIControlEventTouchDragOutside];
                [self.contentView.rightBarButtonItem removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchCancel | UIControlEventTouchUpOutside];
                
                [self.contentView.rightBarButtonItem addTarget:self action:@selector(_beginRecord:forEvent:) forControlEvents:UIControlEventTouchDown];
                [self.contentView.rightBarButtonItem addTarget:self action:@selector(mayCancelRecord:forEvent:) forControlEvents:UIControlEventTouchDragInside|UIControlEventTouchDragOutside];
                [self.contentView.rightBarButtonItem addTarget:self action:@selector(_fininshRecord:forEvent:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchCancel | UIControlEventTouchUpOutside];
                
            }
            [self toggleVoiceButtonEnabled];
        }
    }
}

-(void)_addObservers{
    if (_isObserving) {
        return;
    }
    [self.contentView addObserver:self forKeyPath:NSStringFromSelector(@selector(leftBarButtonItem)) options:NSKeyValueObservingOptionNew context:kGRMessagesInputToolbarKeyObserverContent];
    [self.contentView addObserver:self forKeyPath:NSStringFromSelector(@selector(leftSecondBarButtonItem)) options:NSKeyValueObservingOptionNew context:kGRMessagesInputToolbarKeyObserverContent];
    [self.contentView addObserver:self forKeyPath:NSStringFromSelector(@selector(rightBarButtonItem)) options:NSKeyValueObservingOptionNew context:kGRMessagesInputToolbarKeyObserverContent];
    self.isObserving = YES;
}
-(void)_removeObservers{
    if (!self.isObserving) {
        return;
    }
     [_contentView removeObserver:self forKeyPath:NSStringFromSelector(@selector(leftBarButtonItem)) context:kGRMessagesInputToolbarKeyObserverContent];
     [_contentView removeObserver:self forKeyPath:NSStringFromSelector(@selector(leftSecondBarButtonItem)) context:kGRMessagesInputToolbarKeyObserverContent];
     [_contentView removeObserver:self forKeyPath:NSStringFromSelector(@selector(rightBarButtonItem)) context:kGRMessagesInputToolbarKeyObserverContent];
    self.isObserving = NO;
}
#pragma mark Actions

-(void)_leftBarButtonPressed:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(grmsg_InputToolbar:didPressLeftBarButton:)]) {
        [self.delegate grmsg_InputToolbar:self didPressLeftBarButton:sender];
    }
}
-(void)_leftSecondBarButtonPressed:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(grmsg_InputToolbar:didPressLeftSecondBarButton:)]) {
        [self.delegate grmsg_InputToolbar:self didPressLeftSecondBarButton:sender];
    }
}
-(void)_beginRecord:(UIButton *)sender forEvent:(UIEvent *)event{
    
}
-(void)_mayCancelRecord:(UIButton *)sender forEvent:(UIEvent *)event{

}

-(void)_finishedRecord:(UIButton *)sender forEvent:(UIEvent *)event{
 
}
@end
