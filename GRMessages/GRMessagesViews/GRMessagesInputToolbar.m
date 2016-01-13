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
#import "FBShimmeringView.h"
#import "GRMessagesMacro.h"
#import "GRMessagesSlideView.h"


static void *kGRMessagesInputToolbarKeyObserverContent = &kGRMessagesInputToolbarKeyObserverContent;
static const CGFloat kFloatCancelRecordingOffsetX      = 100.0f;
static const CGFloat kFloatGarbageBeginY               = 45.0f;
static const CGFloat kFloatGarbageAnimationTime        = 0.3f;
static const CGFloat kFloatRecordImageDownTime         = 0.5f;
static const CGFloat kFloatRecordImageRotateTime       = 0.17f;
static const CGFloat kFloatRecordImageUpTime           = 0.5f;

@interface GRMessagesInputToolbar ()
@property (nonatomic, assign) BOOL isObserving;
@property (nonatomic, assign) CGPoint trackTouchPoint;
@property (nonatomic, assign) CGPoint firstTouchPoint;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) GRMessagesGarbageView *garbageImageView;
@property (nonatomic, assign) BOOL canCancelAniamtion;
@property (nonatomic, assign) BOOL isCanceling;
@property (nonatomic, strong) NSTimer *countTimer;
@property (nonatomic, assign) NSUInteger currentSeconds;
@property (nonatomic, strong) FBShimmeringView *slideShimmeringView;
@property (nonatomic, strong) UIButton *recordBtn;
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
                [self.contentView.rightBarButtonItem addTarget:self action:@selector(_mayCancelRecord:forEvent:) forControlEvents:UIControlEventTouchDragInside|UIControlEventTouchDragOutside];
                [self.contentView.rightBarButtonItem addTarget:self action:@selector(_fininshedRecord:forEvent:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchCancel | UIControlEventTouchUpOutside];
                
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
    self.contentView.leftBarButtonItem.hidden = YES;
    self.contentView.leftSecondBarButtonItem.hidden = YES;
    self.contentView.textView.hidden = YES;
    UITouch *touch = [[event touchesForView:sender] anyObject];
    self.trackTouchPoint = [touch locationInView:self];
    self.firstTouchPoint = self.trackTouchPoint;
    self.isCanceling = NO;
    [self showSlideView];
    [self showRecordImageView];
    if ([self.delegate respondsToSelector:@selector(grmsg_InputToolbarShouldBeginRecord:)]) {
        [self.delegate grmsg_InputToolbarShouldBeginRecord:self];
    }
    
}
-(void)_mayCancelRecord:(UIButton *)sender forEvent:(UIEvent *)event{
    UITouch *touch = [[event touchesForView:sender] anyObject];
    CGPoint curPoint = [touch locationInView:self];
    if (curPoint.x < self.contentView.rightBarButtonItem.frame.origin.x) {
        [(GRMessagesSlideView *)self.slideShimmeringView.contentView updateLocation:(curPoint.x - self.trackTouchPoint.x)];
    }
    self.trackTouchPoint = curPoint;
    if ((self.firstTouchPoint.x - self.trackTouchPoint.x)>kFloatCancelRecordingOffsetX) {
        self.isCanceling = YES;
        [sender cancelTrackingWithEvent:event];
        [self cancelRecord];
    }
}

-(void)_fininshedRecord:(UIButton *)sender forEvent:(UIEvent *)event{
    if (self.isCanceling) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(grmsg_InputToolbarShouldFinishedRecord:)]) {
        [self.delegate grmsg_InputToolbarShouldFinishedRecord:self];
    }
    [self endRecord];
     self.recordBtn.hidden = YES;
}

- (void)showSlideView{
    self.slideShimmeringView.hidden = NO;
    CGRect frame = self.slideShimmeringView.frame;
    CGRect orgFrame = {CGPointMake(CGRectGetMaxX(self.contentView.rightBarButtonItem.frame),CGRectGetMinY(frame)), frame.size};
    self.slideShimmeringView.frame = orgFrame;
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        self.slideShimmeringView.frame = frame;
    } completion:NULL];
}
- (void)showRecordImageView{
    self.recordBtn.alpha = 1.0f;
    self.recordBtn.hidden = NO;
    CGRect frame = self.recordBtn.frame;
    CGRect orgFrame = CGRectMake(CGRectGetMinX(self.contentView.rightBarButtonItem.frame), frame.origin.y, frame.size.width, frame.size.height);
    self.recordBtn.frame = orgFrame;
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        self.recordBtn.frame = frame;
    } completion:NULL];

}
- (void)showRecordImageViewGradient{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [basicAnimation setRepeatCount:INFINITY];
    [basicAnimation setDuration:1.0f];
    basicAnimation.autoreverses = YES;
    basicAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    basicAnimation.toValue = [NSNumber numberWithFloat:0.1f];
    [self.recordBtn.layer addAnimation:basicAnimation forKey:nil];
}

- (FBShimmeringView *)slideShimmeringView{
    if (!_slideShimmeringView) {
        CGFloat x = (kSCREENWIDTH - 140.0f)/2;
        _slideShimmeringView = [[FBShimmeringView alloc]initWithFrame:CGRectMake(x, self.contentView.textView.frame.origin.y, 140.0f, self.contentView.textView.frame.size.height)];
        GRMessagesSlideView *contentView = [[GRMessagesSlideView alloc]initWithFrame:_slideShimmeringView.bounds];
        _slideShimmeringView.contentView = contentView;
        [self addSubview:_slideShimmeringView];
        _slideShimmeringView.shimmeringDirection = FBShimmerDirectionLeft;
        _slideShimmeringView.shimmeringSpeed = 60.0f;
        _slideShimmeringView.shimmeringHighlightWidth = 0.29f;
        _slideShimmeringView.shimmering = YES;
    }
    return _slideShimmeringView;
}
- (void)cancelRecord{
    if ([self.delegate respondsToSelector:@selector(grmsg_InputToolbarShouldCancelRecord:)]) {
        [self.delegate grmsg_InputToolbarShouldCancelRecord:self];
    }
    [self.recordBtn.layer removeAllAnimations];
    self.slideShimmeringView.hidden = YES;
    [self.recordBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    CGRect orgFrame = self.recordBtn.frame;
    if (!self.canCancelAniamtion) {
        [self endRecord];
        return;
    }
    [UIView animateWithDuration:kFloatRecordImageUpTime delay:.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.recordBtn.frame;
        frame.origin.y -= (1.5 * self.recordBtn.frame.size.height);
        self.recordBtn.frame =frame;
    } completion:^(BOOL finished) {
        if (finished) {
            [self showGarbage];
            [UIView animateWithDuration:kFloatRecordImageRotateTime delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                CGAffineTransform transform = CGAffineTransformMakeRotation(- 1* M_PI);
                self.recordBtn.transform = transform;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:kFloatRecordImageDownTime delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.recordBtn.frame = orgFrame;
                    self.recordBtn.alpha = 0.1f;
                } completion:^(BOOL finished) {
                    self.recordBtn.hidden = YES;
                    [self dismissGarbage];
                }];
            }];
        }
    }];
}
- (void)endRecord{
    self.contentView.textView.hidden = NO;
    self.isCanceling = NO;
    self.canCancelAniamtion = NO;
    [self invalidateCountTimer];
    if (_recordBtn) {
        [self.recordBtn.layer removeAllAnimations];
        [self.recordBtn removeFromSuperview];
         self.recordBtn = nil;
    }
    if (_slideShimmeringView) {
        [self.slideShimmeringView removeFromSuperview];
        self.slideShimmeringView = nil;
    }
    if (_timeLabel) {
        [self.timeLabel removeFromSuperview];
        self.timeLabel = nil;
    }
    
    if (_garbageImageView) {
        [self.garbageImageView removeFromSuperview];
        self.garbageImageView = nil;
    }
    
    
    CGRect frame = self.contentView.leftBarButtonItem.frame;
    CGFloat offset = self.contentView.textView.frame.origin.x - frame.origin.x;
    frame.origin.x -= 100;
    [self.contentView.leftBarButtonItem setFrame:frame];
    self.contentView.leftBarButtonItem.hidden = NO;
    [self updateConstraintsIfNeeded];
    CGRect frame2 = self.contentView.leftBarButtonItem.frame;
    frame2.origin.x -= 100;
    [self.contentView.leftSecondBarButtonItem setFrame:frame2];
    self.contentView.leftSecondBarButtonItem.hidden = NO;
    
    CGFloat textFieldMaxX = CGRectGetMaxX(self.contentView.textView.frame);
    self.contentView.textView.hidden = NO;
    frame = self.contentView.frame;
    frame.origin.x = self.contentView.leftBarButtonItem.frame.origin.x + offset;
    frame.size.width = textFieldMaxX - frame.origin.x;
    self.contentView.textView.frame = frame;
    
    [UIView animateWithDuration:0.3f animations:^{
        CGRect nframe = self.contentView.leftBarButtonItem.frame;
        nframe.origin.x += 100;
        self.contentView.leftBarButtonItem.frame = nframe;
        CGRect lframe = self.contentView.leftSecondBarButtonItem.frame;
        lframe.origin.x += 100;
        [self.contentView.leftSecondBarButtonItem setFrame:lframe];
        nframe = self.contentView.textView.frame;
        nframe.origin.x = self.contentView.leftBarButtonItem.frame.origin.x + offset;
        nframe.size.width = textFieldMaxX - nframe.origin.x;
        [self.contentView.textView setFrame:nframe];
    }];
}
- (void)invalidateCountTimer{
    self.currentSeconds = 0;
    [_countTimer invalidate];
    self.countTimer = nil;
}
-(NSTimer *)countTimer{
    if (!_countTimer) {
        _countTimer = [NSTimer timerWithTimeInterval:1.0F target:self selector:@selector(updateRecordTimer:) userInfo:nil repeats:YES];
    }
    return _countTimer;
}
-(void)updateRecordTimer:(NSTimer *)timer{
    self.currentSeconds++;
    NSUInteger sec = self.currentSeconds % 60;
    NSString *secondStr = nil;
    if (sec < 10) {
        secondStr = [NSString stringWithFormat:@"0%lu",(unsigned long)sec];
    }else{
        secondStr = [NSString stringWithFormat:@"%lu",(unsigned long)sec];
    }
    NSString *mins = [NSString stringWithFormat:@"%lu",self.currentSeconds/(unsigned long)60];
    self.timeLabel.text = [NSString stringWithFormat:@"%@:%@",mins,secondStr];
}
- (void)startCountTimer{
    self.currentSeconds = 0;
    [[NSRunLoop currentRunLoop]addTimer:self.countTimer forMode:NSRunLoopCommonModes];
    [self.countTimer fire];
}
- (void)didBeginRecord{
    self.canCancelAniamtion = YES;
    [self startCountTimer];
    [self showRecordImageViewGradient];
}
-(UIButton *)recordBtn{
    if (!_recordBtn) {
        _recordBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_recordBtn setImage:[UIImage grmsg_defaultRegularMicRecImage] forState:UIControlStateNormal];
        [_recordBtn setTintColor:[UIColor redColor]];
        [_recordBtn setFrame:self.contentView.leftBarButtonItem.frame];
        [self addSubview:_recordBtn];
    }
    return _recordBtn;
}

-(void)dismissGarbage{
  [UIView animateWithDuration:kFloatGarbageAnimationTime delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
      self.garbageImageView.headerView.transform = CGAffineTransformIdentity;
      CGRect frame = self.garbageImageView.frame;
      frame.origin.y = kFloatGarbageBeginY;
      self.garbageImageView.frame = frame;
  } completion:^(BOOL finished) {
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.01f * NSEC_PER_SEC)),dispatch_get_main_queue(),^{
          [self endRecord];
      });
  }];
}
-(void)showGarbage{
    [self garbageImageView];
    [UIView animateWithDuration:kFloatGarbageAnimationTime delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGAffineTransform transform = CGAffineTransformMakeRotation(- 1*M_PI_2);
        self.garbageImageView.headerView.transform = transform;
        CGRect frame = self.garbageImageView.frame;
        frame.origin.y = (self.bounds.size.height - frame.size.height) / 2.0f;
        self.garbageImageView.frame = frame;
    } completion:NULL];
}
-(GRMessagesGarbageView *)garbageImageView{
    if (!_garbageImageView) {
        GRMessagesGarbageView *garbageView = [[GRMessagesGarbageView alloc]init];
        CGRect frame = garbageView.frame;
        frame.origin = CGPointMake(_recordBtn.center.x - frame.size.width /2.0f, kFloatGarbageBeginY);
        [garbageView setFrame:frame];
        [self addSubview:garbageView];
        _garbageImageView = garbageView;
    }
    return _garbageImageView;
}
@end
