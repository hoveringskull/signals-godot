

# PULL style signal expects listeners to fetch their own data
signal ammo_updated()

# PUSH style signal provides all data needed
signal ammo_updated(ammo_spent: int, ammo_remaining: int)