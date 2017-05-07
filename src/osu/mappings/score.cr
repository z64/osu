module Osu
  struct Score
    JSON.mapping({
      beatmap_id: {type: UInt32?, converter: StringConverter::UInt32},
      score:      {type: UInt64, converter: StringConverter::UInt64},
      count300:   {type: UInt32?, converter: StringConverter::UInt32},
      count100:   {type: UInt32?, converter: StringConverter::UInt32},
      count50:    {type: UInt32?, converter: StringConverter::UInt32},
      count_miss: {key: "countmiss", type: UInt32?, converter: StringConverter::UInt32},
      max_combo:  {key: "maxcombo", type: UInt32?, converter: StringConverter::UInt32},
      count_katu: {key: "countkatu", type: UInt32?, converter: StringConverter::UInt32},
      count_geki: {key: "countgeki", type: UInt32?, converter: StringConverter::UInt32},
      perfect:    {type: Bool, converter: PerfectConverter},
      mods:       {key: "enabled_mods", type: API::Mod, converter: ModConverter},
      user_id:    {type: UInt32?, converter: StringConverter::UInt32},
      date:       {type: Time, converter: TIME_FORMAT},
      rank:       {type: UInt32?, converter: StringConverter::UInt32},
      pp:         {type: Float64?, converter: StringConverter::Float64},
    })
  end

  # URL to this score's beatmap
  def beatmap_url
    "#{API::BASE_URL}/b/#{beatmap_id}"
  end

  # URL to the profile of the scorer
  def profile_url
    "#{API::BASE_URL}/b/#{user_id}"
  end
end
