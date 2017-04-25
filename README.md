# osu

[Crystal](https://crystal-lang.org/) binding for the [Osu!](https://osu.ppy.sh/)
[REST API](https://github.com/ppy/osu-api/wiki)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  osu:
    github: z64/osu
```

## Usage

This library is composed of several components that can be required as needed.

- `osu/api` - Contains all possible GET endpoints with the API. The lowest level ; you must build and handle all queries yourself.
- `osu/api/*` - A collection of a few helpers in executing GET requests, like a querystring builder and enums for game modes and bitmasks
- `osu/mappings/*` - Data object mappings to instance objects received from the API and methods for interacting with cached data
- `osu/client` - A client that implements all of the above that does many high level and helpful things, like concurrent requests of user stats across multiple game modes.

```crystal
# Require the full client
require "osu/client"

# Initialize our client with our API key
client = Osu::Client.new ENV["OSU_API_KEY"]

# Concurrently request a users stats for
# two game modes using some fibers
stats = client.user(
  "skudfuddle",
  [Osu::Mode::Standard, Osu::Mode::Mania]
) #=> Array(User)

# Let's check out his ranks..
puts stats.map &.rank #=>
# [Osu::Rank(@pp=20722, @country=3054, @ss=160, @s=585, @a=572),
#  Osu::Rank(@pp=46290, @country=3770, @ss=5, @s=129, @a=111)]

# How about a beatmap?
puts client.beatmap(787430)
# (some things omitted here for brevity..)
# Osu::Beatmap(
# @id=787430,
# @beatmapset_id=357466,
# @approval=Ranked,
# @total_length=64,
# @hit_length=64,
# @version="N A S Y A'S OK DAD",
# @mode=Standard,
# @artist="ARCIEN",
# @title="Future Son",
# @creator="Mishima Yurara",
# @bpm=150,
# @tags=["edm", "electronic_dance_music", "bass", ...],
# @playcount=2271054,
# @passcount=507670,
# @max_combo=258,
# @difficultyrating=4.6679792404174805,
# )
```

## Contributors

- [z64](https://github.com/z64) Zac Nowicki - creator, maintainer
