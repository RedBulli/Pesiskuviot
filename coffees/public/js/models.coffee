define(['./backbone-sync.js', 'backbone'],
  (sync, Backbone) ->
    Backbone.sync = sync
    class Models

    class Models.Player extends Backbone.Model
      setPosition: (position) ->
        @set('x', position.x)
        @set('y', position.y)
        @save()

    class Models.Players extends Backbone.Collection
      model: Models.Player
      getPlayer: (position) ->
        closest_player = null
        closest_distance = 100000
        for player in @models
          distance = @getDistance(player.get('x'), position.x, player.get('y'), position.y)
          if distance < closest_distance
            closest_player = player
            closest_distance = distance
          if distance <= 1
            return player
        return null
      getDistance: (x1, x2, y1, y2) ->
        return Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))

    Models
)