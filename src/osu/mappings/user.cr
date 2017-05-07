module Osu
  # An Osu user
  struct User
    JSON.mapping({
      user_id:         {type: UInt32?, converter: StringConverter::UInt32},
      username:        String,
      count300:        {type: UInt32?, converter: StringConverter::UInt32},
      count100:        {type: UInt32?, converter: StringConverter::UInt32},
      count50:         {type: UInt32?, converter: StringConverter::UInt32},
      playcount:       {type: UInt32?, converter: StringConverter::UInt32},
      ranked_score:    {type: UInt64?, converter: StringConverter::UInt64},
      total_score:     {type: UInt64?, converter: StringConverter::UInt64},
      pp_rank:         {type: UInt32?, converter: StringConverter::UInt32},
      level:           {type: Float32?, converter: StringConverter::Float32},
      pp_raw:          {type: Float32?, converter: StringConverter::Float32},
      accuracy:        {type: Float32?, converter: StringConverter::Float32},
      count_rank_ss:   {type: UInt32?, converter: StringConverter::UInt32},
      count_rank_s:    {type: UInt32?, converter: StringConverter::UInt32},
      count_rank_a:    {type: UInt32?, converter: StringConverter::UInt32},
      country:         String,
      pp_country_rank: {type: UInt32?, converter: StringConverter::UInt32},
      events:          Array(Event),
    })

    # URL to this user's profile
    def profile_url
      "#{API::BASE_URL}/u/#{user_id}"
    end

    # URL to this user's avatar
    def avatar_url
      "#{API::BASE_URL}/a/#{user_id}"
    end

    # This user's ranks, represented as a Rank struct.
    def rank
      @ranks ||= Rank.new(
        @pp_rank,
        @pp_country_rank,
        @count_rank_ss,
        @count_rank_s,
        @count_rank_a
      )
    end
  end

  # A record of user's ranks
  record(
    Rank,
    pp : UInt32?,
    country : UInt32?,
    ss : UInt32?,
    s : UInt32?,
    a : UInt32?
  )

  struct Event
    JSON.mapping({
      display_html:  String,
      beatmap_id:    {type: UInt32?, converter: StringConverter::UInt32},
      beatmapset_id: {type: UInt32?, converter: StringConverter::UInt32},
      date:          {type: Time, converter: TIME_FORMAT},
      epicfactor:    {type: UInt16?, converter: StringConverter::UInt16},
    })
  end
end
