//
//  STNewsCell.m
//  STNews
//
//  Created by readygo on 2018/1/8.
//  Copyright © 2018年 suntao. All rights reserved.
//

#import "STNewsCell.h"

@interface STNewsCell ()
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
/**
 *  回复数
 */
@property (weak, nonatomic) IBOutlet UILabel *lblReply;
/**
 *  描述
 */
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;
/**
 *  第二张图片（如果有的话）
 */
@property (weak, nonatomic) IBOutlet UIImageView *imgOther1;
/**
 *  第三张图片（如果有的话）
 */
@property (weak, nonatomic) IBOutlet UIImageView *imgOther2;

@end

@implementation STNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setNewsModel:(STNewsEntity *)NewsModel
{
    _NewsModel = NewsModel;
    
    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:NewsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"302"]];
    self.lblTitle.text = NewsModel.title;
    self.lblSubtitle.text = NewsModel.source;
    
    // 如果回复太多就改成几点几万
    CGFloat count =  [NewsModel.replyCount intValue];
    NSString *displayCount;
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    }else{
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }
    self.lblReply.text = displayCount;
    
    // 多图cell
    if (self.NewsModel.imgextra.count == 2) {
        [self.imgOther1 sd_setImageWithURL:[NSURL URLWithString:NewsModel.imgextra[0][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"302"]];
        [self.imgOther2 sd_setImageWithURL:[NSURL URLWithString:NewsModel.imgextra[1][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"302"]];
    }
    
}

#pragma mark - /************************* 类方法返回可重用ID ***************************/
+ (NSString *)idForRow:(STNewsEntity *)NewsModel
{
    if (NewsModel.hasHead && NewsModel.photosetID) {
        return @"TopImageCell";
    }else if (NewsModel.hasHead){
        return @"TopTxtCell";
    }else if (NewsModel.imgType){
        return @"BigImageCell";
    }else if (NewsModel.imgextra){
        return @"ImagesCell";
    }else{
        return @"NewsCell";
    }
}

#pragma mark - /************************* 类方法返回行高 ***************************/
+ (CGFloat)heightForRow:(STNewsEntity *)NewsModel
{
    if (NewsModel.hasHead && NewsModel.photosetID){
        return 215;
    }else if(NewsModel.hasHead) {
        return 215;
    }else if(NewsModel.imgType) {
        return 170;
    }else if (NewsModel.imgextra){
        return 130;
    }else{
        return 80;
    }
}

@end
