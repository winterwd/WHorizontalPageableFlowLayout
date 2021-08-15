//
//  ViewController.m
//  HorizontalPageableFlowLayout
//
//  Created by winter on 2021/8/15.
//

#import "ViewController.h"
#import "WHorizontalPageableFlowLayout.h"

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

static const NSUInteger kMaxRowCount = 2;
static const NSUInteger kItemCountPerRow = 5;

@interface CollectionViewCell : UICollectionViewCell
@property(nonatomic, strong) UILabel *label;
@end

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic) NSUInteger count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.count = 15;
    
    WHorizontalPageableFlowLayout *flowLayout = [[WHorizontalPageableFlowLayout alloc] init];
    flowLayout.maxCountPerRow = kItemCountPerRow;
    flowLayout.rowCount = kMaxRowCount;
    CGFloat space = 10;
    flowLayout.minimumLineSpacing = space;
    flowLayout.minimumInteritemSpacing = space;
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-kItemCountPerRow*space)/kItemCountPerRow, 100);
    
    CGRect frame = CGRectMake(0, 220, CGRectGetWidth(self.view.frame), 210);
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled = YES;
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    [self.view addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
     return self.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    cell.label.text = [NSString stringWithFormat:@"%ld", indexPath.item+1];
    return cell;
}

@end

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        self.label.font = [UIFont systemFontOfSize:20];
        self.label.textColor = UIColor.redColor;
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        
        self.layer.borderColor = UIColor.redColor.CGColor;
        self.layer.borderWidth = 2;
    }
    return self;
}

@end
