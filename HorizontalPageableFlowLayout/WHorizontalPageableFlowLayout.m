//
//  WHorizontalPageableFlowLayout.m
//
//  Created by winter on 2020/12/11.
//

#import "WHorizontalPageableFlowLayout.h"

@interface WHorizontalPageableFlowLayout()
@property (strong, nonatomic) NSMutableArray *allAttributes;
@end

@implementation WHorizontalPageableFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    [super setScrollDirection:UICollectionViewScrollDirectionHorizontal];
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.allAttributes = [NSMutableArray array];
    
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    NSUInteger totalPerPage = MAX(self.maxCountPerRow*self.rowCount, 1);
    NSUInteger lastPageIndex = count/totalPerPage;
    
    for (NSUInteger i = 0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        CGFloat x = 0;
        CGFloat y = 0;

        NSUInteger page = i/totalPerPage;
        BOOL lastPage = (page == lastPageIndex);
        NSUInteger index = i - (self.maxCountPerRow * page * self.rowCount);
        
        NSUInteger countPerRow = self.maxCountPerRow;
        if (lastPage) {
            NSUInteger lastCount = count - page * totalPerPage;
            countPerRow = ceilf(lastCount/(float)self.rowCount);
        }
        [self targetPositionWithItem:index page:page countPerRow:countPerRow resultX:&x resultY:&y];
        attributes.frame = CGRectMake(x, y, self.itemSize.width, self.itemSize.height);
        [self.allAttributes addObject:attributes];
    }
}

// 根据 item 计算目标item的位置
// x 横向偏移  y 竖向偏移
- (void)targetPositionWithItem:(NSUInteger)item
                          page:(NSUInteger)page
                   countPerRow:(NSUInteger)countPerRow
                       resultX:(CGFloat *)x
                       resultY:(CGFloat *)y
{
    NSUInteger theX = item % countPerRow;
    NSUInteger theY = item / countPerRow;
    if (x != NULL) {
        *x = (self.itemSize.width + self.minimumInteritemSpacing) * theX + self.collectionView.bounds.size.width * page;
    }
    if (y != NULL) {
        *y = (self.itemSize.height + self.minimumLineSpacing) * theY;
    }
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *original = [super layoutAttributesForElementsInRect:rect];
    NSArray *attributes =  [[NSArray alloc] initWithArray:original copyItems:YES];
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    NSMutableArray *tmp = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        for (UICollectionViewLayoutAttributes *attr2 in self.allAttributes) {
            if (attr.indexPath.item == attr2.indexPath.item) {
                [tmp addObject:attr2];
                break;
            }
        }
    }
    return [tmp mutableCopy];
}

@end
