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

@interface api : BeeController

// topics API

	// GET http://ruby-china.org/api/topics/:id.json
	// Get topic detail
	// Params:
	//   topic
	// Example:
	//   /api/topics/1.json
	AS_MESSAGE( get_topic );

	// GET http://ruby-china.org/api/topics.json
	// Get active topics list
	// Params:
	//   page
	//   per_page
	// Example:
	//   /api/topics/index.json?page=1&per_page=15
	AS_MESSAGE( get_topics );

	// GET http://ruby-china.org/api/topics/node/:id.json
	// Get active topics of the specified node
	// Params:
	//   node
	//   size
	// Example:
	//   /api/topics/node/1.json?size=30
	AS_MESSAGE( get_topics_by_node );

	// POST http://ruby-china.org/api/topics.json
	// Post a new topic
	// (require authentication)
	// Params:
	//   title
	//   body
	//   node_id
	AS_MESSAGE( post_topic );

	// POST http://ruby-china.org/api/topics/:id/replies.json
	// Post a new reply
	// (require authentication)
	// Params:
	//   body
	// Example:
	//   /api/topics/1/replies.json
	AS_MESSAGE( reply_topic );

	// POST http://ruby-china.org/api/topics/:id/follow.json
	// Follow a topic
	// (require authentication)
	// Params:
	//   NO
	// Example:
	//   /api/topics/1/follow.json
	AS_MESSAGE( follow_topic );

	// POST http://ruby-china.org/api/topics/:id/unfollow.json
	// Unfollow a topic
	// (require authentication)
	// Params:
	//   NO
	// Example:
	//   /api/topics/1/unfollow.json
	AS_MESSAGE( unfollow_topic );

	// POST http://ruby-china.org/api/topics/:id/favorite.json
	// Add a topic to favorite
	// (require authentication)
	// Params:
	//   NO
	// Example
	//   /api/topics/1/favorite.json
	AS_MESSAGE( favorite_topic );

	// POST http://ruby-china.org/api/topics/:id/favorite.json
	// Remove a topic from favorite
	// (require authentication)
	// Params:
	//   NO
	// Example
	//   /api/topics/1/favorite.json
	AS_MESSAGE( unfavorite_topic );

// nodes API

	// GET http://ruby-china.org/api/nodes.json
	// Get a list of all nodes
	// Example
	//   /api/nodes.json
	AS_MESSAGE( get_nodes );

// users API

	// GET http://ruby-china.org/api/users/temp_access_token.json
	// Get temp_access_token, this key is use for Faye client channel
	// Example
	//   /api/users/temp_access_token?token=232332233223:1
	AS_MESSAGE( get_temp_access_token );

	// GET http://ruby-china.org/api/users/:user.json
	// Get a single user
	// Params:
	//   user
	// Example
	//   /api/users/qichunren.json
	AS_MESSAGE( get_user );

	// GET http://ruby-china.org/api/users.json
	// Get top 20 hot users
	// Example
	//   /api/users.json
	AS_MESSAGE( get_users );

	// GET http://ruby-china.org/api/users/:user/topics.json
	// List topics for a user
	// Params:
	//   user
	// Example
	//
	AS_MESSAGE( get_users_topics );

	// GET http://ruby-china.org/api/users/:user/topics/favorite.json
	// List favorite topics for a user
	// Params:
	//   user
	// Example
	//
	AS_MESSAGE( get_users_topics_favorite );

@end
