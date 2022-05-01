KeyMap = Class{}

function KeyMap:init()
  self.player = nil
end

function KeyMap:set_player(player)
  self.player = player
  self.commands = self:commands()
end

function KeyMap:commands()
  return {
    -- continuous keybindings are meant for actions such as player movement where the
    -- player would move as long as the key is held down.
    -- Event handlers for these use the key_status attibute to handle key up/down properly.
    -- key_status == 'key_pressed' or 'key_released'
    continuous = {
      up = function(key_status)
        beholder.trigger('movable_move', self.player, 'up', key_status)
      end,
      down = function(key_status)
        beholder.trigger('movable_move', self.player, 'down', key_status)
      end,
      left = function(key_status)
        beholder.trigger('movable_move', self.player, 'left', key_status)
      end,
      right = function(key_status)
        beholder.trigger('movable_move', self.player, 'right', key_status)
      end,
    },
    momentary = {

    },
  }
end

function KeyMap:process_key(key, key_status)
  if key_status == 'key_pressed' then
    if (self.commands['continuous'][key] ~= nil) then
        self.commands['continuous'][key]('key_pressed')
        return
    end
    if self.commands['momentary'][key] ~= nil then
        self.commands['momentary'][key]()
    end
  else
    if self.commands['continuous'][key] ~= nil then
        self.commands['continuous'][key]('key_released')
    end
  end
end