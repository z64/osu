module Osu
  module API
    # Osu game modes
    enum Mode
      Standard
      Taiko
      Ctb
      Mania
    end

    # Score mod flags
    @[Flags]
    enum Mod
      NoFail
      Easy
      NoVideo
      Hidden
      HardRock
      SuddenDeath
      DoubleTime
      Relax
      HalfTime
      NightCore
      FlashLight
      Autoplay
      SpunOut
      Relax2
      Perfect
      Key4
      Key5
      Key6
      Key7
      Key8
      FadeIn
      Random
      LastMod
      Key9
      Key10
      Key1
      Key3
      Key2
    end
  end
end
