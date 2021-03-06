//
//  GSYClearCacheCell.m
//  GSY百思不得姐
//
//  Created by Song on 2017/9/19.
//  Copyright © 2017年 Song. All rights reserved.
//

#import "GSYClearCacheCell.h"
#import <SDWebImage/SDImageCache.h>

@implementation GSYClearCacheCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置cell右边的指示器（用来说明正在处理一些事情）
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
        
        // 设置cell默认的文字
        self.textLabel.text = @"清除缓存(正在计算缓存大小...)";
        
        // 在子线程计算缓存大小
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 获得缓存文件夹路径
            unsigned long long size = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"MP3"].fileSize;
            size += [SDImageCache sharedImageCache].getSize;
            
            NSString *sizeText = nil;
            if (size >= 1000 * 1000 * 1000) { // size >= 1GB  pow(10, 9) 10的9次方
                sizeText = [NSString stringWithFormat:@"%.1fGB",size / 1000.0 / 1000.0 / 1000.0];
            }else if (size >= 1000 * 1000) { // 1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.1fMB",size / 1000.0 / 1000.0];
            }else if (size >= 1000) { // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%.1fKB",size / 1000.0];
            }else { // 1KB > size
                sizeText = [NSString stringWithFormat:@"%zdB",size];
            }
            
            // 生成文字
            NSString *text = [NSString stringWithFormat:@"清除缓存(%@)",sizeText];
            
            // 回到主线程设置文字
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置文字
                self.textLabel.text = text;
                // 清空右边的指示器
                self.accessoryView = nil;
                // 设置右边箭头
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // 箭头
            });
        });
    }
    return self;
}

@end
