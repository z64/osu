module Osu
  # An Osu user
  class User
    JSON.mapping({
      user_id:         {type: UInt32, converter: UInt32Converter},
      username:        String,
      count300:        {type: UInt32, converter: UInt32Converter},
      count100:        {type: UInt32, converter: UInt32Converter},
      count50:         {type: UInt32, converter: UInt32Converter},
      playcount:       {type: UInt32, converter: UInt32Converter},
      ranked_score:    {type: UInt64, converter: UInt64Converter},
      total_score:     {type: UInt64, converter: UInt64Converter},
      pp_rank:         {type: UInt32, converter: UInt32Converter},
      level:           {type: Float32, converter: Float32Converter},
      pp_raw:          {type: Float32, converter: Float32Converter},
      accuracy:        {type: Float32, converter: Float32Converter},
      count_rank_ss:   {type: UInt32, converter: UInt32Converter},
      count_rank_s:    {type: UInt32, converter: UInt32Converter},
      count_rank_a:    {type: UInt32, converter: UInt32Converter},
      country:         String,
      pp_country_rank: {type: UInt32, converter: UInt32Converter},
    }, false)
  end
end
