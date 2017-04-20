//
//  ListModel.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma mark -  -
@interface ListModel : NSObject

@property(nonatomic,strong)NSString *catsName;
@property(nonatomic,strong)NSString *catsPic;
///catsID
@property(nonatomic,strong)NSString *catsId;

@end


#pragma mark - tableView -
@interface TableModel : NSObject


@property(nonatomic,strong) NSString *catsName;
@property(nonatomic,strong) NSString *catsId;

@end
#pragma mark -  -
@interface CollectionModel : NSObject


@property(nonatomic,strong) NSString *catsName;
@property(nonatomic,strong) NSString *catsId;

@end



