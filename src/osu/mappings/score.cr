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
      date:       String,
      rank:       {type: UInt32?, converter: StringConverter::UInt32},
      pp:         {type: Float64?, converter: StringConverter::Float64},
    })
  end
end
