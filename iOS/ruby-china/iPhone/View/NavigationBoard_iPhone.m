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

#import "NavigationBoard_iPhone.h"

#pragma mark -

@implementation NavigationCell_iPhone

DEF_SIGNAL( TOUCHED )

@dynamic badgeCount;

+ (CGSize)sizeInBound:(CGSize)bound forData:(NSObject *)data
{
	return CGSizeMake( bound.width, bound.width );
}

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
	_icon.frame = CGRectMakeBound( bound.width, bound.width );
	_title.frame = CGRectMake( 0.0f, _icon.bottom, bound.width, bound.height - bound.width );
	_arrow.frame = CGRectMake( bound.width - 10.0f, _icon.top, 10.0f, _icon.height );
}

- (void)load
{
	self.tappable = YES;
	self.tapSignal = self.TOUCHED;
	
	_icon = [[BeeUIImageView alloc] init];
    [self addSubview:_icon];

	_arrow = [[BeeUIImageView alloc] init];
	_arrow.hidden = YES;
    [self addSubview:_arrow];

	_title = [[BeeUILabel alloc] init];
    [self addSubview:_title];
	
	_badge = [[BeeUIImageView alloc] init];
    [self addSubview:_badge];

	_badgeCount = [[BeeUILabel alloc] init];
    [self addSubview:_badgeCount];
}

- (void)unload
{
	SAFE_RELEASE_SUBVIEW( _icon );
	SAFE_RELEASE_SUBVIEW( _arrow );
	SAFE_RELEASE_SUBVIEW( _title );
	
	SAFE_RELEASE_SUBVIEW( _badge );
	SAFE_RELEASE_SUBVIEW( _badgeCount );
}

- (void)setBadgeCount:(NSInteger)badgeCount
{
	_badge.hidden = badgeCount ? NO : YES;
	_badgeCount.hidden = badgeCount ? NO : YES;
	_badgeCount.text = [NSString stringWithFormat:@"%d", badgeCount];
}

- (void)dataDidChanged
{
	NSArray * data = (NSArray *)self.cellData;
	
	_icon.image = [UIImage imageNamed:[data objectAtIndex:1]];
	_title.text = [data objectAtIndex:2];
}

- (void)stateDidChanged
{
	_arrow.hidden = !self.selected;
}

@end

#pragma mark -

@implementation NavigationBoard_iPhone

DEF_NOTIFICATION( SWITCH_TOPIC )
DEF_NOTIFICATION( SWITCH_NODE )
DEF_NOTIFICATION( SWITCH_PROFILE )

- (void)load
{
	[super load];

    _data = [[NSMutableArray alloc] init];
	_data.APPEND( @[self.SWITCH_TOPIC,		@"topics.png",	@"Topics"] );
	_data.APPEND( @[self.SWITCH_NODE,		@"nodes.png",	@"Nodes"] );
	_data.APPEND( @[self.SWITCH_PROFILE,	@"profile.png",	@"Profile"] );
}

- (void)unload
{
    [_data removeAllObjects];
    [_data release];
    
	[super unload];
}

#pragma mark -

- (void)handleUISignal_BeeUIBoard:(BeeUISignal *)signal
{
	[super handleUISignal:signal];
	
	if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
	{
        [self hideNavigationBarAnimated:NO];
            
        _scroll = [[BeeUIScrollView alloc] init];
		_scroll.dataSource = self;
		_scroll.vertical = YES;
		[self.view addSubview:_scroll];
		
		[self observeNotification:self.SWITCH_TOPIC];
		[self observeNotification:self.SWITCH_NODE];
		[self observeNotification:self.SWITCH_PROFILE];
	}
	else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
		[self unobserveAllNotifications];
		
        SAFE_RELEASE_SUBVIEW( _scroll );
	}
	else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
	{
		_scroll.frame = self.viewBound;
	}
	else if ( [signal is:BeeUIBoard.WILL_APPEAR] )
	{
		[self hideNavigationBarAnimated:YES];
		
		[_scroll syncReloadData];
	}
}

- (void)handleUISignal_NavigationCell_iPhone:(BeeUISignal *)signal
{
	[super handleUISignal:signal];
	
	NavigationCell_iPhone * cell = signal.source;
	
	if ( [signal is:NavigationCell_iPhone.TOUCHED] )
	{
		NSArray * data = cell.cellData;

		[self postNotification:[data objectAtIndex:0]];
	}
}

#pragma mark -

- (void)handleNotification:(NSNotification *)notification
{
	[super handleNotification:notification];
	
	for ( NSArray * data in _data )
	{
		NSString * name = [_data objectAtIndex:0];
		
		if ( [name isEqualToString:notification.name] )
		{
			_selectIndex = [_data indexOfObject:data];
			break;
		}
	}

	[_scroll syncReloadData];
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
	NavigationCell_iPhone * cell = [scrollView dequeueWithContentClass:[NavigationCell_iPhone class]];
	cell.cellData = [_data objectAtIndex:index];
	cell.selected = (index == _selectIndex) ? YES : NO;
	return cell;
}

- (CGSize)scrollView:(BeeUIScrollView *)scrollView sizeForIndex:(NSInteger)index
{
	return [NavigationCell_iPhone sizeInBound:CGSizeMake(self.view.width, 0.0f) forData:nil];
}

@end
