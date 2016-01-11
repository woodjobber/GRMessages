//
//  GRMessagesInputToolbarButtonFactroy.m
//  GRMessages
//
//  Created by chengbin on 16/1/11.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesInputToolbarButtonFactroy.h"

#import "UIImage+GRMessages.h"
#import "UIColor+GRMessages.h"
#import "NSBundle+GRMessages.h"

@implementation GRMessagesInputToolbarButtonFactroy

+(UIButton *)defaultAccessoryButtonItem{
    UIImage *accessoryImage = [UIImage grmsg_defaultAccessoryImage];
    UIImage *normalImage = [accessoryImage grmsg_imageMaskdWithColor:[UIColor lightGrayColor]];
    
    UIImage *highlightedImage = [accessoryImage grmsg_imageMaskdWithColor:[UIColor darkGrayColor]];
    UIButton *accessoryButton = [[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0f,accessoryImage.size.width, 32.0f)];
    [accessoryButton setImage:normalImage forState:UIControlStateNormal];
    [accessoryButton setImage:highlightedImage forState:UIControlStateHighlighted];
    accessoryButton.contentMode = UIViewContentModeScaleAspectFit;
    accessoryButton.backgroundColor = [UIColor clearColor];
    accessoryButton.tintColor = [UIColor lightGrayColor];
    return accessoryButton;
}

+(UIButton *)defaultSecondAccessoryButtonItem{
    UIImage *accessoryImage = [UIImage grmsg_defaultRegularEmotionUpImage];
    UIImage *normalImage = [accessoryImage grmsg_imageMaskdWithColor:[UIColor lightGrayColor]];
    
    UIImage *highlightedImage = [accessoryImage grmsg_imageMaskdWithColor:[UIColor darkGrayColor]];
    UIButton *accessoryButton = [[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0f,accessoryImage.size.width, 32.0f)];
    [accessoryButton setImage:normalImage forState:UIControlStateNormal];
    [accessoryButton setImage:highlightedImage forState:UIControlStateHighlighted];
    accessoryButton.contentMode = UIViewContentModeScaleAspectFit;
    accessoryButton.backgroundColor = [UIColor clearColor];
    accessoryButton.tintColor = [UIColor lightGrayColor];
    return accessoryButton;
}
+(UIButton *)defaultVoiceButtonItem{
    UIImage *voiceImage = [UIImage grmsg_defaultRegularMicRecImage];
    UIImage *normalImage = [voiceImage grmsg_imageMaskdWithColor:[UIColor lightGrayColor]];
    UIImage *voiceRedImage = [UIImage grmsg_defaultRegularMicRecRedImage];
    UIButton *voiceButton = [[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0f,voiceImage.size.width, 32.0f)];
    [voiceButton setImage:normalImage forState:UIControlStateNormal];
    [voiceButton setImage:voiceRedImage forState:UIControlStateSelected];
    voiceButton.contentMode = UIViewContentModeScaleAspectFit;
    voiceButton.backgroundColor = [UIColor clearColor];
    voiceButton.tintColor = [UIColor lightGrayColor];
    return voiceButton;
}
@end
