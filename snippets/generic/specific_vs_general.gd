class_name Unit

# not specific
signal updated()

# a little specific
signal hp_updated(current: int)

# very specific
signal hp_increased(current: int, delta: int)
signal hp_decreased(current: int, delta: int)