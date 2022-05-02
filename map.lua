Map = Class{}

function Map:init(map_path)
  local ok, _map = pcall(require, map_path)
  if not ok then error('Map could not be loaded') end

  self.map = _map

  local tileset = self.map.tilesets[1]

  self.tileset_image = love.graphics.newImage(tileset.image, {})
  self.map_quads = {}
  
  self.map_sprite_batch = love.graphics.newSpriteBatch(self.tileset_image)

  self.tile_size = tileset.tilewidth

  for i = 1, tileset.tilecount, 1 do
    local quad_x = ((i-1)*self.tile_size) % tileset.imagewidth
    local quad_y = math.floor(((i-1)/tileset.columns)) * self.tile_size

    self.map_quads[i] = love.graphics.newQuad(
      quad_x,
      quad_y,
      self.tile_size,
      self.tile_size,
      self.tileset_image:getWidth(),
      self.tileset_image:getHeight()
    )
  end
end

function Map:tiles()
  local map = self.map.layers[1]
  local width, height = map.width, map.height
  local tiles = {}
  for i, tile_id in ipairs(map.data) do
    tiles[i] = {
      tile = true,
      position = {
        x = ((i-1)*self.tile_size) % (self.tile_size*width),
        y = math.floor((i-1)/width) * self.tile_size 
      },
      quad = self.map_quads[tile_id]
    }
    print('quad x: '..tiles[i].position.x..' y: '..tiles[i].position.y)
  end
  return tiles
end