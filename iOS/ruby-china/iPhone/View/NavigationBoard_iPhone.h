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

#pragma mark -

@interface NavigationCell_iPhone : BeeUIGridCell
{
	BeeUIImageView *	_icon;
    BeeUILabel *		_title;
	BeeUIImageView *	_arrow;
	
	BeeUIImageView *	_badge;
	BeeUILabel *		_badgeCount;
}

AS_SIGNAL( TOUCHED )

@property (nonatomic, assign) NSInteger	badgeCount;

@end

#pragma mark -

@interface NavigationBoard_iPhone : BeeUIBoard
{
	NSInteger			_selectIndex;
    NSMutableArray *	_data;
    BeeUIScrollView *	_scroll;
}

AS_NOTIFICATION( SWITCH_TOPIC )
AS_NOTIFICATION( SWITCH_NODE )
AS_NOTIFICATION( SWITCH_PROFILE )

@end
