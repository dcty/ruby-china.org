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

#import "api.h"
#import "model.h"

@implementation api

DEF_MESSAGE( get_topic );
DEF_MESSAGE( get_topics );
DEF_MESSAGE( get_topics_by_node );
DEF_MESSAGE( post_topic );
DEF_MESSAGE( reply_topic );
DEF_MESSAGE( follow_topic );
DEF_MESSAGE( unfollow_topic );
DEF_MESSAGE( favorite_topic );
DEF_MESSAGE( unfavorite_topic );

DEF_MESSAGE( get_nodes );

DEF_MESSAGE( get_user );
DEF_MESSAGE( get_users );
DEF_MESSAGE( get_temp_access_token );
DEF_MESSAGE( get_users_topics );
DEF_MESSAGE( get_users_topics_favorite );

- (NSString *)baseURL
{
	return @"http://ruby-china.org/api/";
}

- (void)get_topic:(BeeMessage *)msg
{
	if ( msg.sending )
	{
		topic *		t = msg.GET_INPUT( @"topic" );
		NSString *	url = self.baseURL.APPEND( @"topics/%@.json", t.id );

		msg.HTTP_GET( url );
	}
	else if ( msg.succeed )
	{
		NSDictionary * result = msg.responseJSONDictionary;
		if ( nil == result )
		{
			msg.failed = YES;
			return;
		}
		
		topic.DB.SAVE( result );
	}
	else if ( msg.failed )
	{
	}
}

- (void)get_topics:(BeeMessage *)msg
{
	if ( msg.sending )
	{
		NSString * url = self.baseURL.APPEND( @"topics.json" );
		
		msg
		.HTTP_GET( url )
		.PARAM( @"page", msg.GET_INPUT( @"page" ) )
		.PARAM( @"per_page", msg.GET_INPUT( @"per_page" ) );
	}
	else if ( msg.succeed )
	{
		NSArray * result = msg.responseJSONArray;
		if ( nil == result )
		{
			msg.failed = YES;
			return;
		}

		topic.DB.SAVE( result );
	}
	else if ( msg.failed )
	{
	}
}

- (void)get_topics_by_node:(BeeMessage *)msg
{
	if ( msg.sending )
	{
		node *		node = msg.GET_INPUT( @"node" );
		NSString *	url = self.baseURL.APPEND( @"topics/node/%@.json", node.id );
		
		msg
		.HTTP_GET( url )
		.PARAM( @"size", msg.GET_INPUT( @"size" ) );
	}
	else if ( msg.succeed )
	{
		NSArray * result = msg.responseJSONArray;
		if ( nil == result )
		{
			msg.failed = YES;
			return;
		}

		topic.DB.SAVE( result );
	}
	else if ( msg.failed )
	{
	}	
}

- (void)post_topic:(BeeMessage *)msg
{
	if ( msg.sending )
	{
		NSString *	title = msg.GET_INPUT( @"title" );
		NSString *	body = msg.GET_INPUT( @"body" );
		NSString *	url = self.baseURL.APPEND( @"topics.json" );
		
		msg
		.HTTP_POST( url )
		.PARAM( @"title", title )
		.PARAM( @"body", body );
	}
	else if ( msg.succeed )
	{
	}
	else if ( msg.failed )
	{
	}
}

- (void)reply_topic:(BeeMessage *)msg
{
	if ( msg.sending )
	{
		topic *		t = msg.GET_INPUT( @"topic" );
		NSString *	body = msg.GET_INPUT( @"body" );
		NSString *	url = self.baseURL.APPEND( @"topics/%@/replies.json", t.id );
		
		msg
		.HTTP_POST( url )
		.PARAM( @"body", body );
	}
	else if ( msg.succeed )
	{
	}
	else if ( msg.failed )
	{
	}
}

- (void)follow_topic:(BeeMessage *)msg
{
	if ( msg.sending )
	{
		topic *		t = msg.GET_INPUT( @"topic" );
		NSString *	url = self.baseURL.APPEND( @"topics/%@/follow.json", t.id );
		
		msg.HTTP_POST( url );
	}
	else if ( msg.succeed )
	{
	}
	else if ( msg.failed )
	{
	}	
}

- (void)unfollow_topic:(BeeMessage *)msg
{
	if ( msg.sending )
	{
		topic *		t = msg.GET_INPUT( @"topic" );
		NSString *	url = self.baseURL.APPEND( @"topics/%@/unfollow.json", t.id);
		
		msg.HTTP_POST( url );
	}
	else if ( msg.succeed )
	{
	}
	else if ( msg.failed )
	{
	}
}

- (void)favorite_topic:(BeeMessage *)msg
{
	if ( msg.sending )
	{
		topic *		t = msg.GET_INPUT( @"topic" );
		NSString *	url = self.baseURL.APPEND( @"topics/%@/favorite.json", t.id );
		
		msg.HTTP_POST( url );
	}
	else if ( msg.succeed )
	{
	}
	else if ( msg.failed )
	{
	}
}

- (void)unfavorite_topic:(BeeMessage *)msg
{
	if ( msg.sending )
	{
		topic *		t = msg.GET_INPUT( @"topic" );
		NSString *	url = self.baseURL.APPEND( @"topics/%@/unfavorite.json", t.id );

		msg
		.HTTP_POST( url )
		.PARAM( @"type", @"unfavorite" );
	}
	else if ( msg.succeed )
	{
	}
	else if ( msg.failed )
	{
	}
}

- (void)get_nodes:(BeeMessage *)msg
{
	if ( msg.sending )
	{
		msg.HTTP_GET( self.baseURL.APPEND( @"nodes.json" ) );
	}
	else if ( msg.succeed )
	{
		NSArray * result = msg.responseJSONArray;
		if ( nil == result )
		{
			msg.failed = YES;
			return;
		}

		node.DB.SAVE( result );
	}
	else if ( msg.failed )
	{
	}
}

- (void)get_temp_access_token:(BeeMessage *)msg
{
	if ( msg.sending )
	{
		msg.HTTP_GET( self.baseURL.APPEND( @"users/temp_access_token.json" ) );
	}
	else if ( msg.succeed )
	{
		NSArray * result = msg.responseJSONArray;
		if ( nil == result )
		{
			msg.failed = YES;
			return;
		}
		
		user.DB.SAVE( result );
	}
	else if ( msg.failed )
	{
	}
}

- (void)get_user:(BeeMessage *)msg
{
	if ( msg.sending )
	{
		user *		u = msg.GET_INPUT( @"user" );
		NSString *	url = self.baseURL.APPEND( @"users/%@.json", u.id );

		msg.HTTP_GET( url );
	}
	else if ( msg.succeed )
	{
		NSDictionary * result = msg.responseJSONDictionary;
		if ( nil == result )
		{
			msg.failed = YES;
			return;
		}
		
		user.DB.SAVE( result );
	}
	else if ( msg.failed )
	{
	}
}

- (void)get_users:(BeeMessage *)msg
{
	if ( msg.sending )
	{
		msg.HTTP_GET( self.baseURL.APPEND( @"users.json" ) );
	}
	else if ( msg.succeed )
	{
		NSArray * result = msg.responseJSONArray;
		if ( nil == result )
		{
			msg.failed = YES;
			return;
		}
		
		user.DB.SAVE( result );
	}
	else if ( msg.failed )
	{
	}
}

- (void)get_users_topics:(BeeMessage *)msg
{
	if ( msg.sending )
	{
		user *		u = msg.GET_INPUT( @"user" );
		NSString *	url = self.baseURL.APPEND( @"users/%@/topics.json", u.id );
		
		msg.HTTP_GET( url );
	}
	else if ( msg.succeed )
	{
		NSArray * result = msg.responseJSONArray;
		if ( nil == result )
		{
			msg.failed = YES;
			return;
		}
		
		topic.DB.SAVE( result );
	}
	else if ( msg.failed )
	{
	}
}

- (void)get_users_topics_favorite:(BeeMessage *)msg
{
	if ( msg.sending )
	{
		user *		u = msg.GET_INPUT( @"user" );
		NSString *	url = self.baseURL.APPEND( @"users/%@/topics/favorite.json", u.id );
		
		msg.HTTP_GET( url );
	}
	else if ( msg.succeed )
	{
		NSArray * result = msg.responseJSONArray;
		if ( nil == result )
		{
			msg.failed = YES;
			return;
		}
		
		topic.DB.SAVE( result );
	}
	else if ( msg.failed )
	{
	}	
}

@end
