//
//  WHorizontalPageableFlowLayout.h
//
//  Created by winter on 2020/12/11.
//

#import <UIKit/UIKit.h>

@interface WHorizontalPageableFlowLayout : UICollectionViewFlowLayout
/// 一行中 cell的个数
@property (nonatomic, assign) NSUInteger maxCountPerRow;
/// 一页显示多少行
@property (nonatomic, assign) NSUInteger rowCount;
@end
