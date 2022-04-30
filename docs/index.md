# Love Game Engine

the goal of this engine is to provide a quick, opinionated starting point for projects.

Features:
  * ECS provided by tiny-ecs
  * Events using the observer pattern (beholder.lua)
  * Utility modules from the Hump library (class, vector, gamestate)
    - https://hump.readthedocs.io/en/latest/class.html
    - https://hump.readthedocs.io/en/latest/vector.html
    - https://hump.readthedocs.io/en/latest/gamestate.html


Philosophy:
  Leverage the ECS + Event sourcing combo to make it simple to create games which feature systemic gameplay elements.

  Let's say we have 3 entity types - player, critter, and bullet

  If we want the player to shoot a bullet, we would emit a `player_shoot` event when the player presses `space`

  The game should listen to these events, and it should add a `bullet` to the world.
  

  The bullet class should check for collisions, and if one occurs, a `bullet_hit_critter` event would be emitted, and the critter class would be listening to these and respond accordingly.