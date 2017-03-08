module Osu
  # An Osu user
  class User
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
  end

  class Event
    JSON.mapping({
      display_html:  String,
      beatmap_id:    {type: UInt32?, converter: StringConverter::UInt32},
      beatmapset_id: {type: UInt32?, converter: StringConverter::UInt32},
      date:          String,
      epicfactor:    {type: UInt16?, converter: StringConverter::UInt16},
    })
  end
end
