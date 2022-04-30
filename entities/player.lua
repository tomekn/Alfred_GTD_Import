return class {
  init = function(self, position, velocity)
    self.position = position
    self.velocity = velocity
  end;

  to_s = function(self)
    print("Player")
  end;
}