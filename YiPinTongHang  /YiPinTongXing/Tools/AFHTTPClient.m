//
//  AFHTTPClient.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/14.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "AFHTTPClient.h"

static AFHTTPClient  *instance = nil;
@interface AFHTTPClient()

@property(nonatomic,assign) BOOL isConnect;

@end

@implementation AFHTTPClient

-(instancetype)init{
    self = [super init];
    if (self) {
        self.manager = [AFHTTPSessionManager manager];
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", nil];
        [self openNetMonitoring];
        
    }
    return self;
}



-(void)openNetMonitoring{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.isConnect = NO;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.isConnect = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.isConnect = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.isConnect = YES;
                break;
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    self.isConnect = YES;
}



+(instancetype)shareInstance
{
    return  [[self alloc]init];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [super allocWithZone:zone];
        }
    });
    return instance;
    
}



-(void)requestWithPath:(NSString *)url
                Method:(NSInteger)method
           Paramenters:(NSDictionary *)params
        PrepareExecute:(PrePareExecuteBlock)prepare
               Success:(successBlock)success
               Failure:(FailureBlock)failure{
    
    
    if ([self isConnectionAvailable]) {
        if (prepare) {
            prepare();
        }
        switch (method) {
            case HTTPRequestGet:
                [self.manager GET:url parameters:params progress:nil success:success failure:failure];
                break;
                case HTTPRequestPost:
                [self.manager POST:url parameters:params progress:nil success:success failure:failure];
                
                break;
                
            default:
                break;
        }
    }else{
        [self showExceptionDialog];
    }
    
}


-(void)updateWithPath:(NSString *)url
               Method:(NSInteger)method
           parameters:(id)params
       PrepareExecute:(PrePareExecuteBlock)prepare
         constructing:(ConstructBlock)constructing
             progress:(ProgressBlock)progress
              Success:(successBlock)success
              Failure:(FailureBlock)failure
{
    
    if ([self isConnectionAvailable]) {
        if (prepare) {
            prepare();
        }
        if (method == HTTPRequestPost) {
        
            [self.manager POST:url parameters:params constructingBodyWithBlock:constructing progress:progress success:success failure:failure];
            }
    }else{
        [self showExceptionDialog];
    }
    
}


-(BOOL)isConnectionAvailable{
    
    
    return self.isConnect;
}
    
    
    
    
-(void)showExceptionDialog{
   [[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常,请检查网络链接" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
}
    
    
    
    
    
    



@end
