//
//				   __                          __
//				  /\ \                        /\ \      __
//	 _ __   __  __\ \ \____  __  __        ___\ \ \___ /\_\    ___      __
//	/\  __\/\ \/\ \\ \  __ \/\ \/\ \      / ___\ \  _  \/\ \ /  _  \  / __ \
//	\ \ \/ \ \ \_\ \\ \ \_\ \ \ \_\ \    /\ \__/\ \ \ \ \ \ \/\ \/\ \/\ \_\ \_
//	 \ \_\  \ \____/ \ \_ __/\ \____ \   \ \____\\ \_\ \_\ \_\ \_\ \_\ \__/ \_\
//	  \/_/   \/___/   \/___/  \/___/_ \   \/____/ \/_/\/_/\/_/\/_/\/_/\/__/\/_/
//								 /\___/
//								 \/__/
//
//	Powered by BeeFramework
//	https://github.com/gavinkwoe/BeeFramework
//

#import "NodesBoard_iPhone.h"
#import "NavigationBoard_iPhone.h"
#import "model.h"
#import "api.h"

#pragma mark -

@implementation NodeSectionCell_iPhone

+ (CGSize)sizeInBound:(CGSize)bound forData:(NSObject *)data
{
	return CGSizeMake( bound.width, 44.0f );
}

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
	_title.frame = CGSizeMakeBound( bound );
}

- (void)load
{
	_title = [[BeeUILabel alloc] init];
    [self addSubview:_title];
}

- (void)unload
{
	SAFE_RELEASE_SUBVIEW( _title );
}

- (void)dataDidChanged
{
	node * n = (node *)self.cellData;
	
	_title.text = n.section_name;
}

@end

#pragma mark -

@implementation NodeCell_iPhone

DEF_SIGNAL( TOUCHED )

+ (CGSize)sizeInBound:(CGSize)bound forData:(NSObject *)data
{
	return CGSizeMake( bound.width, 60.0f );
}

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
	_icon.frame = CGRectMakeBound( bound.height, bound.height );
	
	_topicsCount.frame = CGRectMake( bound.width - 80.0f, 0.0f, 80.0f, bound.height / 2.0f );
	_topicsCount.frame = CGRectInset( _topicsCount.frame, 4.0f, 4.0f );
	_topicsCount.frame = CGRectOffset( _topicsCount.frame, 0.0f, 4.0f );
	
	_title.frame = CGRectMake( _icon.right, 0.0f, bound.width - _icon.width - _topicsCount.width, bound.height / 2.0f );
	_title.frame = CGRectOffset( _title.frame, 0.0f, 4.0f );
	
	_summary.frame = CGRectMake( _icon.right, _title.bottom, bound.width - _icon.width, bound.height / 2.0f );
	_summary.frame = CGRectOffset( _summary.frame, 0.0f, -6.0f );
	
	_line.frame = CGRectMake( 0.0f, bound.height - 1.0f, bound.width, 1.0f );
}

- (void)load
{
	self.tappable = YES;
	self.tapSignal = self.TOUCHED;
	
	_icon = [[BeeUIImageView alloc] init];
    [self addSubview:_icon];
	
	_summary = [[BeeUILabel alloc] init];
	_summary.font = [UIFont systemFontOfSize:14.0f];
	_summary.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
	_summary.textAlignment = UITextAlignmentLeft;
	_summary.textColor = [UIColor whiteColor];
	_summary.backgroundColor = [UIColor clearColor];
	_summary.lineBreakMode = UILineBreakModeTailTruncation;
    [self addSubview:_summary];

	_title = [[BeeUILabel alloc] init];
	_title.font = [UIFont boldSystemFontOfSize:18.0f];
	_title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
	_title.textAlignment = UITextAlignmentLeft;
	_title.textColor = [UIColor whiteColor];
	_title.backgroundColor = [UIColor clearColor];
	_title.lineBreakMode = UILineBreakModeTailTruncation;
    [self addSubview:_title];

	_topicsCount = [[BeeUILabel alloc] init];
	_topicsCount.font = [UIFont boldSystemFontOfSize:13.0f];
	_topicsCount.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
	_topicsCount.textAlignment = UITextAlignmentRight;
	_topicsCount.textColor = [UIColor whiteColor];
	_topicsCount.backgroundColor = [UIColor clearColor];
	_topicsCount.lineBreakMode = UILineBreakModeTailTruncation;
    [self addSubview:_topicsCount];
	
	_line = [[UIView alloc] init];
	_line.backgroundColor = RGB( 60, 142, 224 );
	[self addSubview:_line];
}

- (void)unload
{
	SAFE_RELEASE_SUBVIEW( _line );
	SAFE_RELEASE_SUBVIEW( _icon );
	SAFE_RELEASE_SUBVIEW( _summary );
	SAFE_RELEASE_SUBVIEW( _title );
	SAFE_RELEASE_SUBVIEW( _topicsCount );
}

- (void)dataDidChanged
{
	node * n = (node *)self.cellData;
	
	_title.text = n.name;
	_summary.text = n.summary;
	_topicsCount.text = [NSString stringWithFormat:@"%@ topics", n.topics_count];
}

@end

#pragma mark -

@implementation NodesBoard_iPhone

- (void)load
{
	[super load];
	
    _data = [[NSMutableArray alloc] init];
}

- (void)unload
{
    [_data removeAllObjects];
    [_data release];
    
	[super unload];
}

#pragma mark -

- (void)reloadData:(BOOL)fromData
{
	if ( fromData )
	{
		[_data addObjectsFromArray:node.DB.ORDER_ASC_BY( @"section_id" ).ORDER_ASC_BY( @"sort" ).GET_RECORDS()];
	}
	
	[_scroll asyncReloadData];
}

#pragma mark -

- (void)handleUISignal_BeeUIBoard:(BeeUISignal *)signal
{
	[super handleUISignal:signal];
	
	if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
	{
        [self showNavigationBarAnimated:NO];
		[self setTitleString:@"RubyChina - Nodes"];
		
		self.view.backgroundColor = RGB( 38, 129, 220 );
		
        _scroll = [[BeeUIScrollView alloc] init];
		_scroll.dataSource = self;
		_scroll.vertical = YES;
		[self.view addSubview:_scroll];
		
		[self observeNotification:NavigationBoard_iPhone.SWITCH_NODE];
	}
	else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
		[self unobserveAllNotifications];
		
        SAFE_RELEASE_SUBVIEW( _scroll );
	}
	else if ( [signal is:BeeUIBoard.LOAD_DATAS] )
	{
		[self reloadData:YES];
	}
	else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
	{
		_scroll.frame = self.viewBound;
	}
	else if ( [signal is:BeeUIBoard.WILL_APPEAR] )
	{
		[self showNavigationBarAnimated:YES];
		[self reloadData:NO];
		
		self.MSG( api.get_nodes );
	}
}

- (void)handleUISignal_NodeCell_iPhone:(BeeUISignal *)signal
{
	[super handleUISignal:signal];
	
	NodeCell_iPhone * cell = signal.source;
	
	if ( [signal is:NodeCell_iPhone.TOUCHED] )
	{
		node * node = cell.cellData;

		// TODO: show topics of this node
	}
}

#pragma mark -

- (void)handleNotification:(NSNotification *)notification
{
	[super handleNotification:notification];
	
	if ( [notification is:NavigationBoard_iPhone.SWITCH_NODE] )
	{
		[self reloadData:YES];
	}
}

#pragma mark -

- (void)handleMessage:(BeeMessage *)msg
{
	[super handleMessage:msg];
	
	if ( [msg is:api.get_nodes] )
	{
		if ( msg.sending )
		{
			
		}
		else if ( msg.succeed )
		{
			[self reloadData:YES];
		}
	}
}

#pragma mark -

- (NSInteger)numberOfLinesInScrollView:(BeeUIScrollView *)scrollView
{
	return 1;
}

- (NSInteger)numberOfViewsInScrollView:(BeeUIScrollView *)scrollView
{
	return _data.count;
}

- (UIView *)scrollView:(BeeUIScrollView *)scrollView viewForIndex:(NSInteger)index scale:(CGFloat)scale
{
	NodeCell_iPhone * cell = [scrollView dequeueWithContentClass:[NodeCell_iPhone class]];
	cell.cellData = [_data objectAtIndex:index];
	return cell;
}

- (CGSize)scrollView:(BeeUIScrollView *)scrollView sizeForIndex:(NSInteger)index
{
	return [NodeCell_iPhone sizeInBound:CGSizeMake(self.viewWidth, 0.0f) forData:nil];
}

@end
