//
//  SKPromotemoneyErweimaCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/20.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKPromotemoneyErweimaCell.h"

@interface SKPromotemoneyErweimaCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *CopyButton;
@property (weak, nonatomic) IBOutlet UILabel *Urllab;
@property (weak, nonatomic) IBOutlet UIImageView *linkImagell;

@end

@implementation SKPromotemoneyErweimaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _bgView.layer.borderWidth = 1;
    _bgView.layer.borderColor = [UIColor hexStringToColor:@"B9C0C6"].CGColor;
    _CopyButton.clipsToBounds = YES;
    _CopyButton.layer.cornerRadius = 22.5;
    // Initialization code
}
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    //设置比例
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap（位图）;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}
- (void)getcenterImagell:(NSString *)string
{
    // 1. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    
    // 2. 给滤镜添加数据
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 使用KVC的方式给filter赋值
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 3. 生成二维码
    CIImage *image = [filter outputImage];
    
    // 4. 显示二维码
    _linkImagell.image = [self createNonInterpolatedUIImageFormCIImage:image withSize:180];
}
- (IBAction)CopyClick:(UIButton *)sender {
   [self.contentView toastShow:@"复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _Urllab.text;
}
- (void)setlink:(NSString *)link image:(NSString *)imagePath
{
    _Urllab.text = link;
    [_linkImagell sd_setImageWithURL:[NSURL URLWithString:imagePath]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
