//
//  YCloudVODClient.h
//  vodsdkdemo
//
//  Created by fei on 14-10-31.
//  Copyright (c) 2014年 wangfei. All rights reserved.
//

#ifndef vodsdkdemo_YCloudVODClient_h
#define vodsdkdemo_YCloudVODClient_h
#import "AFNetworking.h"

@interface YCloudVODClient : NSObject
/**
 The token for the vod api call.
 
 */
//@property (nonatomic, copy) NSString *token;

/**
 The appid about application.
 
 */
@property (nonatomic, copy) NSString *appid;
/**
 Initialize object
  token
   appid
 
 */
- (id)init:(NSString *)appid;

/**
 *  @author baohonglai, 14-12-05 18:12:30
 *
 *  上传视频文件
 *
 *  @param filePath      文件的路径
 *  @param token         用户的token
 *  @param appid         用户的appid
 *  @param progressBlock 进度条
 *  @param success       成功执行的操作
 *  @param failure       失败执行的操作
 *
 *  @return 返回带有错误码的json字符串
 */

-(NSString* )videoUpload:(NSString *) filePath
                   token:(NSString *) token
                   appid:(NSString *) appid
                  cvodid:(NSString *) cvodid
                progress:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progressBlock
                 success:(void (^)(NSURLResponse *response, id responseObject))success
                 failure:(void (^)(NSError *error))failure;


/**
 *  @author baohonglai, 14-12-15 11:12:41
 *
 *  获取文件列表
 *
 *  @param pageNum 表示用几页显示
 *  @param token   用户的token
 *  @param number  每页显示多少个id
 *
 *  @return 视频id列表的json字符串,并带有错误码
 */
-(NSString *)getFileList: (NSInteger) pageNum
                   token:(NSString*)token
                  number:(NSInteger)number;


/**
 *  @author baohonglai, 14-12-15 11:12:34
 *
 *   获取水印的pinNum值，用于设置水印
 *
 *  @param token 用户传入的token
 *
 *  @return 返回带有水印图片名和错误码的字符串
 */
-(NSString *)getWaterMarks:(NSString*)token;

/**
 *  @author baohonglai, 14-12-15 11:12:14
 *
 *  查询视频文件的详细信息
 *
 *  @param videoid 视频为唯一id值
 *  @param token   用户的token
 *
 *  @return 返回视频的详细信息及错误码
 */
- (NSString *)getVideoInfo:(NSString *) videoid
                     token:(NSString*)token;
/**
 *  @author baohonglai, 14-12-15 11:12:59
 *
 *  删除视频文件
 *
 *  @param videoId 视频的唯一id
 *  @param token   用户传入的token
 *
 *  @return 返回错误码
 */
- (NSInteger )delVideo:(NSString*)videoId
                 token:(NSString*)token;


/**
 *  @author baohonglai, 14-12-15 11:12:36
 *
 *  获取视频的播放代码
 *
 *  @param videoid 视频的唯一id
 *  @param token   用户的token
 *  @param type    播放类型，1：js代码，2：flash代码
 *
 *  @return 返回带有播放代码的字符串
 */
-(NSString *)getPlayCode:(NSString *) videoid
                   token:(NSString*)token
                    type:(NSString *) type;


/**
 *  @author baohonglai, 14-12-15 11:12:31
 *
 *   上传水印文件
 *
 *  @param file          文件的路径名
 *  @param pinNum        水印对应的图片号
 *  @param token         用户的token
 *  @param progressBlock 上传进度条
 *
 *  @return 返回错误信息
 */
-(NSInteger) watermarkUpload:(NSString *) file
                      pinNum:(NSInteger) pinNum
                       appid:(NSString *) appid
                        token:(NSString*)token
                      progress:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progressBlock;


/**
 *  @author baohonglai, 14-12-15 13:12:46
 *
 *  给视频打上水印
 *
 *  @param videoid  视频的唯一id
 *  @param pinNum   水印图片号
 *  @param token    用户的token
 *  @param position 水印的位置 左上："topleft",右上："topright",左下："bottomleft",右下："bottomright"，
 *  @param offsetw  图片宽偏移。
 *  @param offseth  图片高偏移。
 *  @param scalew   图片缩小后的宽。
 *  @param scaleh   图片缩小后的高。
 *
 *  @return 返回错误信息
 */
-(NSInteger) setWatermark:(NSString *) videoid
                   pinNum:(NSInteger) pinNum
                    token:(NSString*)token
                 position:(NSString *) position
                  offsetw:(NSInteger) offsetw
                  offseth:(NSInteger) offseth
                   scalew:(NSInteger) scalew
                   scaleh:(NSInteger) scaleh;

/*
 
 参数：
 videoId:视频文件的唯一Id
 name:   文件的别名
 
 */
/**
 *  @author baohonglai, 14-12-11 15:12:49
 *
 *  设置视频文件id的别名，也是描述信息
 *
 *  @param videoId 视频文件的唯一Id
 *  @param name    文件的别名
 *  @param token   传入的token
 *
 *  @return 返回错误码
 */
-(NSInteger) setAlias:(NSString *) videoId
                  name:(NSString *) name
                 token:(NSString*)token;

/**
 *  @author baohonglai, 14-12-15 14:12:29
 *
 *  获取已经上传的文件的个数
 *
 *  @param token 用户传入的token
 *
 *  @return 带有文件个数的返回信息
 */
-(NSString *) countOfFiles:(NSString*)token;
@end


#endif
