//
//  HJConfig.h
//  vodsdkdemo
//
//  Created by 包红来 on 14-12-5.
//  Copyright (c) 2014年 wangfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJConfig : NSObject
extern  NSString * const DefaultVODAccessURL;
extern  NSString * const DefaultHOST;

extern NSString * const BS2ClientDefaultBaseURLString ;

extern NSString * const BS2StandardRegion ;
extern NSString * const BS2DownloadURL ;
extern NSString * const BS2UploadURL ;

extern NSInteger const _try_times;
extern NSUInteger const _BLOCK_SIZE ;
extern NSUInteger const _LITTLE_FILE_SIZE;
extern long long const _MAX_FILE_SIZE ; // 支持的最大的文件
extern NSString * const DefaultLivingAccessURL;
@end
