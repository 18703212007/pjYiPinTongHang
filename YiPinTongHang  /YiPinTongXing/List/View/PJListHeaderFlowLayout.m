//
//  PJListHeaderFlowLayout.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/10.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PJListHeaderFlowLayout.h"

@interface PJListHeaderFlowLayout()

@end

@implementation PJListHeaderFlowLayout

-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}




/**
 *  重写Layout方法
 *
 *  @
 *
 *  @
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *superArray = [[super layoutAttributesForElementsInRect:rect]mutableCopy];
    
    NSMutableIndexSet *noneHeaderSetions =[NSMutableIndexSet indexSet];
    
    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
            [noneHeaderSetions addIndex:attributes.indexPath.section];
        }
    }
    [noneHeaderSetions enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        if (attributes) {
            [superArray addObject:attributes];
        }
    }];
    
    

    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            NSInteger numberOfItemInSetion = [self.collectionView numberOfItemsInSection:attributes.indexPath.section];
            
            NSIndexPath *firstItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:attributes.indexPath.section];
            
            NSIndexPath *lastItemIndexPath = [NSIndexPath indexPathForItem:MAX(0, numberOfItemInSetion-1) inSection:attributes.indexPath.section];
            
            UICollectionViewLayoutAttributes *firstItemAttributes,*lastItemAttributes;
            
            if (numberOfItemInSetion >0) {
                firstItemAttributes = [self layoutAttributesForItemAtIndexPath:firstItemIndexPath];
                lastItemAttributes = [self layoutAttributesForItemAtIndexPath:lastItemIndexPath];
            }else{
                firstItemAttributes = [UICollectionViewLayoutAttributes new];
                
                CGFloat y = CGRectGetMaxY(attributes.frame)+self.sectionInset.top;
                firstItemAttributes.frame = rect(0, y, 0, 0);
                lastItemAttributes = firstItemAttributes;
            }
            CGRect rect = attributes.frame;
            
            CGFloat offset = self.collectionView.contentOffset.y-self.navHeight;
            
            CGFloat headerY = firstItemAttributes.frame.origin.y -rect.size.height -self.sectionInset.top;
            CGFloat maxY = MAX(offset, headerY);
            
            
            CGFloat headerMissingY = CGRectGetMaxY(lastItemAttributes.frame)+self.sectionInset.bottom-rect.size.height;
            
            
            
            rect.origin.y = MIN(maxY, headerMissingY);
            
            attributes.frame = rect;
            
            attributes.zIndex = 7;
            
            
        }
    }
    
    return [superArray copy];
    
    
    
}




/**
 *  必须实现此方法,否则修改不生效
 *
 *  @param newBounds 新的Frame
 *
 *  @return BOOL
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
@end

