//
//  AFHTTPClient.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/14.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,RequestMethod){
    HTTPRequestGet,
    HTTPRequestPost
};

typedef void(^PrePareExecuteBlock)();

typedef void(^successBlock)(NSURLSessionDataTask *task,id responseObject);

typedef void(^FailureBlock)(NSURLSessionDataTask *task, NSError *error);

typedef void(^ProgressBlock)(NSProgress *progress);

typedef void(^ConstructBlock)(id<AFMultipartFormData>   formData);


@interface AFHTTPClient : NSObject
@property(nonatomic,strong)AFHTTPSessionManager *manager;

+(instancetype)shareInstance;

/**
   *  HTTP请求（GET,POST,PUT,DELETE）
   *
   *  @param url     请求地址
   *  @param method  请求类型
   *  @param params  请求参数
   *  @param prepare 请求前预处理
   *  @param success 请求成功处理
   *  @param failure 请求失败处理
*/

-(void)requestWithPath:(NSString*)url
                Method:(NSInteger)method
           Paramenters:(NSDictionary*)params
        PrepareExecute:(PrePareExecuteBlock)prepare
               Success:(successBlock)success
               Failure:(FailureBlock)failure;


/**
 *  HTTP上传（POST,）
 *
 *  @param url            请求地址
 *  @param method         请求类型
 *  @param params         请求参数
 *  @param prepare        请求前预处理
 *  @param constructing   上传的内容
 *  @param success        请求成功处理
 *  @param failure        请求失败处理
 */


-(void)updateWithPath:(NSString *)url
               Method:(NSInteger)method
           parameters:(id)params
       PrepareExecute:(PrePareExecuteBlock)prepare
         constructing:(ConstructBlock)constructing
             progress:(ProgressBlock)progress
              Success:(successBlock)success
              Failure:(FailureBlock)failure;


@end
