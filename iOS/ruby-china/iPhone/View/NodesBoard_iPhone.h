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

#import "Bee_UIBoard.h"

#pragma mark -

@interface NodeSectionCell_iPhone : BeeUIGridCell
{
	BeeUILabel *		_title;
}
@end

#pragma mark -

@interface NodeCell_iPhone : BeeUIGridCell
{
	BeeUIImageView *	_icon;
	BeeUILabel *		_title;
	BeeUILabel *		_summary;
	BeeUILabel *		_topicsCount;
	UIView *			_line;
}

AS_SIGNAL( TOUCHED )

@end

#pragma mark -

@interface NodesBoard_iPhone : BeeUIBoard
{
    NSMutableArray *	_data;
    BeeUIScrollView *	_scroll;
}

@end
