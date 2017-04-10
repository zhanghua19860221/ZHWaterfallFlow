//
//  PictureCell.m
//  WaterFile
//
//  Created by MS on 15/8/23.
//  Copyright (c) 2015年 zhanghua. All rights reserved.
//

#import "PictureCell.h"
#import "UIImageView+WebCache.h"
@interface PictureCell()
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation PictureCell

-(void)addSourceTocell:(PictureModel*)model
{

    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text=[NSString stringWithFormat:@"%@",model.title];
    self.titleLabel.textColor=[UIColor whiteColor];

}



- (void)awakeFromNib {
    // Initialization code
}

@end
