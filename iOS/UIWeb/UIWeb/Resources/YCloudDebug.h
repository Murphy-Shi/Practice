//
//  YCloudDebug.h
//  vodsdkdemo
//
//  Created by 包红来 on 14-12-10.
//  Copyright (c) 2014年 wangfei. All rights reserved.
//

#ifndef vodsdkdemo_YCloudDebug_h
#define vodsdkdemo_YCloudDebug_h

#ifdef DEBUG 
#   define YLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define YLog(...)
#endif

#endif
