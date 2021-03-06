-- Skill Database
do
  AllSkills = {
  -- Homunculus Skills
    -- Lif
    [8001] = {
      Name = "Healing Hands",
      CastFunction = "actor",
      Range = 15,
      MaxLevel = 5,
      SPCost = function(level) return 10 + level*3 end,
    },
    [8002] = {
      Name = "Urgent Escape",
      CastFunction = "self",
      MaxLevel = 5,
      SPCost = function(level) return 15 + level*5 end,
      CastDelay = 35 * 1000,
      Duration = function(level) return (45 - level*5) * 1000 end,
      Condition = function(_G)
        -- Use only if owner is moving, or we're moving somewhere
        if
          _G.RAIL.Owner.Motion[0] == _G.MOTION_MOVE or
          _G.RAIL.Target.Chase ~= nil
        then
          return true
        end

        return false
      end,
    },
    [8003] = {
      Name = "Brain Surgery",
      MaxLevel = 5,
    },
    [8004] = {
      Name = "Mental Charge",
      CastFunction = "self",
      MaxLevel = 3,
      SPCost = 100,
      CastDelay = function(level) return (5 + level*5) * 60 * 1000 end,
      Duration = function(level) return (-1 + level*2) * 60 * 1000 end,
      Condition = function(_G)
        -- Use only if we are going to engage something
        if _G.RAIL.Target.Attack ~= nil then
          return true
        end

        return false
      end,
    },
    -- Amistr
    [8005] = {
      Name = "Castling",
      CastFunction = "self",
      MaxLevel = 5,
      SPCost = 10,
    },
    [8006] = {
      Name = "Amistr Bulwark",
      CastFunction = "self",
      MaxLevel = 5,
      SPCost = function(level) return 15 + level*5 end,
      Duration = function(level) return (45 - level*5) * 1000 end,
      Condition = "defending",
    },
    [8007] = {
      Name = "Adamantium Skin",
      MaxLevel = 5,
    },
    [8008] = {
      Name = "Blood Lust",
      CastFunction = "self",
      MaxLevel = 3,
      CastDelay = function(level) return level*300 * 1000 end,
      Duration = function(level)
        if level < 3 then
          return level*60 * 1000
        else
          return 300 * 1000
        end
      end,
    },
    -- Filir
    [8009] = {
      Name = "Moonlight",
      CastFunction = "actor",
      --Range = 15,
      MaxLevel = 5,
      SPCost = function(level) return 4 * level end,
      CastDelay = 500,
      --Condition = "attacking",
    },
    [8010] = {
      Name = "Flitting",
      CastFunction = "self",
      MaxLevel = 5,
      SPCost = function(level) return 20 + level*10 end,
      CastDelay = function(level)
        -- Flitting's cast delay seems to be properly implemented with renewal
        if RAIL.Renewal then
          if level < 5 then
            return (50 + level * 10) * 1000
          else
            return 120 * 1000
          end
        else
          return 0
        end
      end,
      Duration = function(level)
        if RAIL.Renewal then
          return (65 - level * 5) * 1000
        else
          -- Flitting's cast delay seems to be only for recast, so
          -- we tell RAIL that the duration is calculation for cast delay.
          -- (RAIL only cares about when it should be recast.)
          if level < 5 then
            return (50 + level*10) * 1000
          else
            return 120 * 1000
          end
        end
      end,
      Condition = "attacking",
    },
    [8011] = {
      Name = "Accelerated Flight",
      CastFunction = "self",
      MaxLevel = 5,
      CastDelay = function(level)
        if level < 5 then
          return (50 + level*10) * 1000
        else
          return 120 * 1000
        end
      end,
      Condition = "defending_self",
    },
    [8012] = {
      Name = "S.B.R.44",
      CastFunction = "actor",
      MaxLevel = 3,
      SPCost = 1,
    },
    -- Vanilmirth
    [8013] = {
      Name = "Caprice",
      CastFunction = "actor",
      Range = 15,
      MaxLevel = 5,
      SPCost = function(level) return 20 + level*2 end,
      CastDelay = function(level) return (0.8 + level*0.2) * 1000 end,
    },
    [8014] = {
      Name = "Chaotic Blessings",
      CastFunction = "self",
      Range = 15,
      MaxLevel = 5,
      SPCost = 40,
    },
    [8015] = {
      Name = "Instruction Change",
      MaxLevel = 5,
    },
    [8016] = {
      Name = "Self-Destruction",
      CastFunction = "actor",
      MaxLevel = 3,
      SPCost = 15,
    },

  -- Mercenary Skills
    -- Fencer specific
    [8201] = {
      Name = "Bash",
      CastFunction = "actor",
      MaxLevel = 10,
      SPCost = function(level)
        if level <= 5 then
          return 8
        else
          return 15
        end
      end,
    },
    [8202] = {
      Name = "Magnum Break",
      CastFunction = "self",
      Range = 0,
      SplashRange = 2,  -- 0 = 1; 1 = 3x3; 2 = 5x5; 3 = 7x7; ...
      MaxLevel = 10,
      SPCost = 30,
      HPCost = function(level)
        -- This doesn't seem to cost HP from mercenaries;
        --return 21 - math.ceil(level/2)
        return 0
      end,
      CastDelay = 2 * 1000,
    },
    [8203] = {
      Name = "Bowling Bash",
      CastFunction = "actor",
      SplashRange = 1,  -- 0 = 1; 1 = 3x3; 2 = 5x5; 3 = 7x7; ...
      MaxLevel = 10,
      SPCost = function(level) return 12 + level end,
    },
    [8204] = {
      Name = "Parry",
      CastFunction = "self",
      MaxLevel = 10,
      SPCost = 50,
      Duration = function(level) return (10 + level*5) * 1000 end,
      Condition = "defending_self",
    },
    [8205] = {
      Name = "Shield Reflect",
      CastFunction = "self",
      MaxLevel = 10,
      SPCost = function(level) return 30 + level*5 end,
      CastDelay = 1 * 1000,
      Duration = 300 * 1000,
      Condition = "defending_self",
    },
    [8206] = {
      Name = "Frenzy",
      CastFunction = "self",
      MaxLevel = 1,
      SPCost = 200,

      -- TODO: special duration (lasts until HP < 100)
    },

    -- Archer specific
    [8207] = {
      Name = "Double Strafe",
      CastFunction = "actor",
      MaxLevel = 10,
      SPCost = 12,
      CastDelay = 0.2 * 1000,
    },
    [8208] = {
      Name = "Arrow Shower",
      CastFunction = "ground",
      Range = 10,
      SplashRange = function(level)
        if RAIL.Renewal and level <= 5 then
          -- 1-tile distance from the center (3x3)
          return 1
        end

        -- 2-tile radius after center tile (5x5)
        return 2
      end,
      MaxLevel = 10,
      SPCost = 15,
      CastDelay = 1 * 1000,
    },
    [8209] = {
      Name = "Skid Trap",
      CastFunction = "ground",
      MaxLevel = 5,
      SPCost = 10,
    },
    [8210] = {
      Name = "Land Mine",
      CastFunction = "ground",
      MaxLevel = 5,
      SPCost = 10,
    },
    [8211] = {
      Name = "Sandman",
      CastFunction = "ground",
      SplashRange = 1,    -- 1-tile radius from center (3x3)
      MaxLevel = 5,
      SPCost = 12,
    },
    [8212] = {
      Name = "Freezing Trap",
      CastFunction = "ground",
      SplashRange = 1,    -- 1-tile radius from center (3x3)
      MaxLevel = 5,
      SPCost = 10,
    },
    [8213] = {
      Name = "Remove Trap",
      -- TODO: are traps actors? no.
      -- TODO: How is this targeted?
      CastFunction = function(self,target) end,
      MaxLevel = 1,
      SPCost = 5,
    },
    [8214] = {
      Name = "Arrow Repel",
      CastFunction = "actor",
      MaxLevel = 1,
      SPCost = 15,
      CastTime = 1.5 * 1000,
      CastDelay = 0.2 * 1000,
    },
    [8215] = {
      Name = "Focused Arrow Strike",
      CastFunction = "actor",
      -- TODO: Implement behavior to count enemies in between self and target
      SplashRange = 0,    -- Only splashes onto the target tile (1x1)
      MaxLevel = 5,
      SPCost = function(level) return 15 + level*3 end,
      CastTime = 2 * 1000,
      CastDelay = 1.5 * 1000,
    },

    -- Lancer specific
    [8216] = {
      Name = "Pierce",
      CastFunction = "actor",
      MaxLevel = 10,
      SPCost = 7,
    },
    [8217] = {
      Name = "Brandish Spear",
      CastFunction = "actor",
      -- TODO: Implement Range and SplashRange for this...
      MaxLevel = 10,
      SPCost = 12,
      CastTime = 1 * 1000,
      CastDelay = 1 * 1000,
    },
    [8218] = {
      Name = "Clashing Spiral",
      CastFunction = "actor",
      MaxLevel = 5,
      SPCost = function(level) return 15 + level*3 end,
      CastTime = function(level)
        if level < 5 then
          return (0.1 + level*0.2) * 1000
        else
          return 1 * 1000
        end
      end,
      CastDelay = function(level) return (1 + level*0.2) * 1000 end,
    },
    [8219] = {
      Name = "Defending Aura",
      CastFunction = "self",
      MaxLevel = 5,
      SPCost = 30,
      CastDelay = 1 * 1000,
      Duration = 180 * 1000,
      Condition = function(_G)
        -- TODO: Check if we're being attacked from range

        return false
      end,
    },
    [8220] = {
      Name = "Guard",
      CastFunction = "self",
      MaxLevel = 10,
      SPCost = function(level) return 10 + level*2 end,
      Duration = 300 * 1000,
      Condition = "defending_self",
    },
    [8221] = {
      Name = "Sacrifice",
      CastFunction = "actor",
      Range = function(level) return 6 + level end,
      MaxLevel = 5,
      SPCost = 25,
      CastTime = 3 * 1000,
      CastDelay = 3 * 1000,
      Duration = function(level) return (15 + level*15) * 1000 end,
      MaxTargets = function(level) return level end,
    },

    -- Mercenary inspecific
    [8222] = {
      Name = "Magnificat",
      CastFunction = "self",
      MaxLevel = 5,
      SPCost = 40,
      CastTime = 4 * 1000,
      CastDelay = 2 * 1000,
      Duration = function(level) return (15 + level*15) * 1000 end,
      Condition = function(_G)
        -- Check if the owner is at full SP
        if _G.RAIL.Owner.SP[0] >= _G.RAIL.Owner:GetMaxSP() then
          -- No point to Magnificat
          return false
        end

        -- Check if we're being attacked
        if _G.RAIL.Self.TargetOf:GetN() > 0 then
          -- It'll likely be interrupted, don't cast yet
          return false
        end

        -- Check if our owner is moving
        if _G.RAIL.Owner.Motion[0] == _G.MOTION_MOVE then
          -- We might need to chase to stay on screen; don't cast
          return false
        end

        return true
      end,
    },
    [8223] = {
      Name = "Weapon Quicken",
      CastFunction = "self",
      MaxLevel = 10,
      SPCost = function(level)
        if level < 3 or level >=5 then
          return 10 + level*4
        else
          return 20 + level*2
        end
      end,
      Duration = function(level) return (level*30) * 1000 end,
      Condition = "attacking",
    },
    [8224] = {
      Name = "Sight",
      CastFunction = "self",
      Range = 3,
      MaxLevel = 1,
      SPCost = 10,
      Duration = 10 * 1000,
      Condition = function(_G,actor)
        -- Only use this against targets that are hiding
        return actor.Hide
      end,
    },
    [8225] = {
      Name = "Crash",
      -- 3 hits x 100% + 10%/level attack; 6%/level chance to stun
      CastFunction = "actor",
      MaxLevel = 5,
      SPCost = 10,
      CastTime = 1 * 1000,
      CastDelay = 2 * 1000,
    },
    [8226] = {
      Name = "Regain",
      -- Sleep and stun recovery
      CastFunction = "actor",
      MaxLevel = 1,
      SPCost = 10,
    },
    [8227] = {
      Name = "Tender",
      -- Frozen and stone recovery
      CastFunction = "actor",
      MaxLevel = 1,
      SPCost = 10,
    },
    [8228] = {
      Name = "Benediction",
      -- Curse and blind recovery
      CastFunction = "actor",
      MaxLevel = 1,
      SPCost = 10,
    },
    [8229] = {
      Name = "Recuperate",
      -- Poison and silence recovery
      CastFunction = "actor",
      MaxLevel = 1,
      SPCost = 10,
    },
    [8230] = {
      Name = "Mental Cure",
      -- Hallucination and chaos recovery
      CastFunction = "actor",
      MaxLevel = 1,
      SPCost = 10,
    },
    [8231] = {
      Name = "Compress",
      -- Bleeding recovery
      CastFunction = "actor",
      MaxLevel = 1,
      SPCost = 10,
    },
    [8232] = {
      Name = "Provoke",
      CastFunction = "actor",
      MaxLevel = 10,
      SPCost = function(level) return 3 + level*1 end,
      CastDelay = 500,
      Duration = 30 * 1000,
      Condition = function(_G,actor)
        -- Separate decision based on the target being an actor
        if actor:IsEnemy() then
          -- Target like a debuff
          return true
        else
          -- Target like a buff

          -- TODO: Test this more fully
          do
            -- Disabled for now.
            return false
          end
          
          -- Check if the actor's HP is checked
          if actor.HP then
            -- Check if the actor's HP is below 30%
            if _G.math.floor(actor.HP[0] / actor:GetMaxHP() * 100) < 30 then
              -- Don't provoke
              return false
            end
          end

          local list = _G.History.GetConstList(actor.Motion)
          local now = GetTick()
          local i = list.last
          local attacks = 0
          while i > list.first do
            -- Get the motion table
            local motion = list[i]

            -- Check if it's too old (5 seconds old)
            if now - motion[2] > 5000 then
              break
            end
            
            -- Check if the motion is MOTION_ATTACK or MOTION_ATTACK2
            if motion[1] == _G.MOTION_ATTACK or motion[2] == _G.MOTION_ATTACK2 then
              attacks = attacks + 1
            end
            
            -- Decrement i
            i = i - 1
          end

          -- If there were 3 or more attacks in 5 seconds, allow buff-provoke
          if attacks >= 3 then
            return true
          end

          -- Not attacking fast enough, don't provoke
          return false
        end
      end,
    },
    [8233] = {
      Name = "Berserk",
      -- Auto-provoke self; not Frenzy; passive
      MaxLevel = 1,
    },
    [8234] = {
      Name = "Decrease AGI",
      CastFunction = "actor",
      MaxLevel = 10,
      SPCost = function(level) return 13 + level*2 end,
      CastTime = 1 * 1000,
      CastDelay = 1 * 1000,
      Duration = function(level) return (20 + level*10) * 1000 end,
    },
    [8235] = {
      Name = "Scapegoat",
      CastFunction = "self",
      MaxLevel = 1,
      SPCost = 5,
      CastTime = 3 * 1000,
    },
    [8236] = {
      Name = "Lex Divina",
      CastFunction = "actor",
      MaxLevel = 10,
      SPCost = function(level)
        if level < 6 then
          return 20
        else
          return 20 - level*2
        end
      end,
      CastDelay = 3 * 1000,
      Duration = function(level)
        if level < 6 then
          return (25 + level*5) * 1000
        else
          return 60 * 1000
        end
      end,
    },
    [8237] = {
      Name = "Sense",
      CastFunction = "actor",
      MaxLevel = 1,
      SPCost = 10,
    },
  }

  -- Standard cast functions
  local CastFunctions = {
    ["self"] = function(self)
      -- Log the skill usage.
      RAIL.LogT(60,"Casting {1}.",self)

      -- Set the skill state
      RAIL.SkillState:WaitFor(self,RAIL.Self)

      -- Use the skill
      SkillObject(RAIL.Self.ID,self.Level,self.ID,RAIL.Self.ID)
    end,
    ["actor"] = function(self,actor)
      -- Convert actor to an Actors object
      actor = Actors[actor]

      -- Log the skill usage against actor
      RAIL.LogT(60,"Casting {1} against {2}.",self,actor)

      -- Set the skill state
      RAIL.SkillState:WaitFor(self,actor)

      -- Use the skill
      SkillObject(RAIL.Self.ID,self.Level,self.ID,actor.ID)
    end,
    ["ground"] = function(self,x,y)
      -- Ensure we've got coordinates
      if RAIL.IsActor(x) then
        -- Set the skill state
        RAIL.SkillState:WaitFor(self,x)

        -- Log it
        RAIL.LogT(60,"Casting {1} against {2}.",self,x)

        -- Get the ground location
        y = x.Y[0]
        x = x.X[0]
      else
        -- Set the skill state
        RAIL.SkillState:WaitFor(self,x,y)

        -- Log it
        RAIL.LogT(60,"Casting {1} on ({2},{3}).",self,x,y)
      end

      -- Use the skill
      SkillGround(RAIL.Self.ID,self.Level,self.ID,x,y)
    end,
  }

  -- Standard Cast Conditions
  local CastConditions = {
    ["attacking"] = function(_G)
      -- Check if we're attacking
      local target = _G.RAIL.Target.Attack
      if target and target.Active then
        return true
      end

      return false
    end,
    ["defending"] = function(_G)
      -- Check if owner is being attacked
      for i=1,_G.RAIL.Owner.TargetOf:GetN() do
        if _G.RAIL.Owner.TargetOf[i]:IsEnemy() then
          return true
        end
      end

      -- Check if the AI is being attacked
      for i=1,_G.RAIL.Self.TargetOf:GetN() do
        if _G.RAIL.Self.TargetOf[i]:IsEnemy() then
          return true
        end
      end

      return false
    end,
    ["defending_self"] = function(_G)
      -- Check if we're being attacked
      for i=1,_G.RAIL.Self.TargetOf:GetN() do
        if _G.RAIL.Self.TargetOf[i]:IsEnemy() then
          return true
        end
      end

      return false
    end,
  }

  local function_or_number = function(f,arg,default)
    if type(f) == "function" then
      return f(arg)
    elseif type(f) == "number" then
      return f
    end
    if not default then
      return 0
    end
    return default
  end

  local function_or_string = function(f,table,default)
    if type(f) == "function" then
      return f
    elseif type(f) == "string" and table[f] then
      return table[f]
    else
      return default
    end
  end

  -- Build a RAIL-usable skill table
  RAIL.Event["AI CYCLE"]:Register(-41,
                                  "AllSkills rebuild",
                                  1,
                                  function(self)
    local AllSkills_rebuild = { }
    for id,parameters in AllSkills do
      -- Create a skill table
      local name = parameters.Name
      local skill = {
        GetName = function(self) return tostring(name) end,
      }

      -- Select the cast and condition functions
      local cast_func = function_or_string(parameters.CastFunction,CastFunctions,function(self,...)
        -- Log
        RAIL.LogT(0,"Unknown cast type for skill {1}.",self)
      end)
      local condition_func = function_or_string(parameters.Condition,CastConditions,function(_G)
        -- Unspecified condition; just use the skill
        return true
      end)
      
      -- Determine the target type
      local target_type = parameters.CastFunction
      if type(target_type) ~= "string" then
        target_type = "unknown"
      end

      -- Build the skill-level tables
      for i=1,parameters.MaxLevel do
        -- Build the table
        skill[i] = {
          GetName = function(self)
            return StringBuffer.New()
              :Append(skill:GetName())
              :Append(" (level ")
              :Append(self.Level)
              :Append(")")
            :Get()
          end,
          ID = id,
          Level = i,
          TargetType = target_type,
          Cast = cast_func,
          Range = function_or_number(parameters.Range,i,GetV(V_SKILLATTACKRANGE,RAIL.Self.ID,id)),
          SplashRange = function_or_number(parameters.SplashRange,i,0),
          SPCost = function_or_number(parameters.SPCost,i),
          HPCost = function_or_number(parameters.HPCost,i),
          CastTime = function_or_number(parameters.CastTime,i),
          CastDelay = function_or_number(parameters.CastDelay,i),
          Duration = function_or_number(parameters.Duration,i),
          Condition = condition_func,
          MaxTargets = function_or_number(parameters.MaxTargets,i),
        }
        -- Set the metatable
        setmetatable(skill[i],{
          __tostring = function(self)
            return self:GetName()
          end,
        })
      end

      -- Skills that have a max level of 1 don't need to specify level
      if parameters.MaxLevel == 1 then
        skill[1].GetName = skill.GetName
      end

      -- Default the skill to using the highest level
      setmetatable(skill,{
        __index = skill[parameters.MaxLevel],
        __tostring = function(self)
          return self:GetName()
        end,
      })

      -- Add the skill to the skill-table rebuild
      AllSkills_rebuild[id] = skill
    end

    -- Replace the skills table
    AllSkills = AllSkills_rebuild
  end)
end

-- Skill Mappings
do
  local GetSkillList
  if RAIL.Mercenary then
    GetSkillList = function(id)
      if id == ARCHER01 then
        return {
          Attack = AllSkills[8207][2],      -- double strafe
          --AllSkills[8233][1],             -- berserk (passive)
        }
      elseif id == ARCHER02 then
        return {
          AreaOfEffect  = AllSkills[8208][2],   -- arrow shower
          Reveal        = AllSkills[8224][1],   -- sight
        }
      elseif id == ARCHER03 then
        return {
          Pushback  = AllSkills[8214][1],   -- arrow repel
          Buff      = AllSkills[8223][1],   -- weapon quicken
        }
      elseif id == ARCHER04 then
        return {
          Buff      = AllSkills[8222][1],   -- magnificat
                      AllSkills[8237][1],   -- sense
          Recover   = AllSkills[8227][1],   -- tender
        }
      elseif id == ARCHER05 then
        return {
          Attack        = AllSkills[8207][5], -- double strafe
                          AllSkills[8213][1], -- remove trap
          Debuff        = AllSkills[8232][1], -- provoke
          PartySupport  = AllSkills[8232][1], -- provoke
        }
      elseif id == ARCHER06 then
        return {
          Attack    = AllSkills[8207][7],   -- double strafe
          Pushback  = AllSkills[8209][3],   -- skid trap
          Debuff    = AllSkills[8234][1],   -- decrease agi
        }
      elseif id == ARCHER07 then
        return {
          AreaOfEffect  = AllSkills[8208][10],  -- arrow shower
                          AllSkills[8212][2],   -- freezing trap
          Recover       = AllSkills[8230][1],   -- mental cure
        }
      elseif id == ARCHER08 then
        return {
                          AllSkills[8211][5],   -- sandman
          Buff          = AllSkills[8223][2],   -- weapon quicken
          Debuff        = AllSkills[8232][3],   -- provoke
          PartySupport  = AllSkills[8232][3],   -- provoke
        }
      elseif id == ARCHER09 then
        return {
          Attack    = AllSkills[8207][10],  -- double strafe
          Attack2   = AllSkills[8210][5],   -- land mine
          Pushback  = AllSkills[8214][1],   -- arrow repel
        }
      elseif id == ARCHER10 then
        return {
          Pushback      = AllSkills[8214][1],   -- arrow repel
          --AllSkills[8223][1],                 -- berserk (passive)
          AreaOfEffect  = AllSkills[8215][1],   -- focused arrow strike
          Buff          = AllSkills[8223][5],   -- weapon quicken
        }
      elseif id == LANCER01 then
        return {
          Attack  = AllSkills[8216][1],     -- pierce
          Recover = AllSkills[8226][1],     -- regain
        }
      elseif id == LANCER02 then
        return {
          AreaOfEffect  = AllSkills[8217][2],   -- brandish spear
          Debuff        = AllSkills[8236][1],   -- lex divina
        }
      elseif id == LANCER03 then
        return {
          Attack        = AllSkills[8216][2],   -- pierce
          Recover       = AllSkills[8229][1],   -- recuperate
          PartySupport  = AllSkills[8221][1],   -- sacrifice
        }
      elseif id == LANCER04 then
        return {
          Attack  = AllSkills[8225][1],   -- crash
          Buff    = AllSkills[8219][1],   -- defending aura
        }
      elseif id == LANCER05 then
        return {
          Buff    = AllSkills[8220][3],   -- guard
          Attack  = AllSkills[8216][5],   -- pierce
        }
      elseif id == LANCER06 then
        return {
          AreaOfEffect  = AllSkills[8217][5],   -- brandish spear
          Buff          = AllSkills[8223][2],   -- weapon quicken
        }
      elseif id == LANCER07 then
        return {
          --AllSkills[8223][1],               -- berserk (passive)
          PartySupport = AllSkills[8221][1],  -- sacrifice
        }
      elseif id == LANCER08 then
        return {
          Attack        = AllSkills[8216][10],  -- pierce
          Debuff        = AllSkills[8232][5],   -- provoke
          PartySupport  = AllSkills[8232][5],   -- provoke
          Emergency     = AllSkills[8235][1],   -- scapegoat
        }
      elseif id == LANCER09 then
        return {
          AreaOfEffect  = AllSkills[8217][10],  -- brandish spear
          Buff          = AllSkills[8219][3],   -- defending aura
          Buff2         = AllSkills[8220][7],   -- guard
        }
      elseif id == LANCER10 then
        return {
          Attack        = AllSkills[8218][5],   -- clashing spiral
          Buff          = AllSkills[8220][10],  -- guard
          PartySupport  = AllSkills[8221][3],   -- sacrifice
          Buff2         = AllSkills[8223][5],   -- weapon quicken
        }
      elseif id == SWORDMAN01 then
        return {
          Attack  = AllSkills[8201][1],     -- bash
          Debuff  = AllSkills[8234][1],     -- decrease agi
        }
      elseif id == SWORDMAN02 then
        return {
          AreaOfEffect  = AllSkills[8202][3],   -- magnum break
          Debuff        = AllSkills[8232][5],   -- provoke
          PartySupport  = AllSkills[8232][5],   -- provoke
        }
      elseif id == SWORDMAN03 then
        return {
          Recover   = AllSkills[8228][1],   -- benediction
          Buff      = AllSkills[8223][1],   -- weapon quicken
        }
      elseif id == SWORDMAN04 then
        return {
          Attack        = AllSkills[8225][1],   -- crash
          AreaOfEffect  = AllSkills[8202][5],   -- magnum break
        }
      elseif id == SWORDMAN05 then
        return {
          Attack  = AllSkills[8201][5],   -- bash
          Recover = AllSkills[8228][1],   -- benediction
          Attack2 = AllSkills[8225][4],   -- crash
        }
      elseif id == SWORDMAN06 then
        return {
          Debuff  = AllSkills[8234][3],   -- decrease agi
                    AllSkills[8237][1],   -- sense
          Buff    = AllSkills[8223][5],   -- weapon quicken
        }
      elseif id == SWORDMAN07 then
        return {
          Attack    = AllSkills[8201][10],  -- bash
          --AllSkills[8223][1],             -- berserk (passive)
          Emergency = AllSkills[8235][1],   -- scapegoat
        }
      elseif id == SWORDMAN08 then
        return {
          AreaOfEffect  = AllSkills[8203][5],   -- bowling bash
          Recover       = AllSkills[8231][1],   -- compress
          Buff          = AllSkills[8204][4],   -- parry
          Buff2         = AllSkills[8223][10],  -- weapon quicken
        }
      elseif id == SWORDMAN09 then
        return {
          Buff          = AllSkills[8205][5],   -- shield reflect
          Attack        = AllSkills[8225][3],   -- crash
          AreaOfEffect  = AllSkills[8203][8],   -- bowling bash
        }
      elseif id == SWORDMAN10 then
        return {
          Attack        = AllSkills[8201][10],  -- bash
          AreaOfEffect  = AllSkills[8203][10],  -- bowling bash
                          AllSkills[8206][1],   -- frenzy
          Buff          = AllSkills[8223][10],  -- weapon quicken
        }
      end

      return {}
    end
  else
    GetSkillList = function(id)
      if id == LIF or id == LIF2 then
        return {
          HealOwner = AllSkills[8001],    -- healing hands
          Buff      = AllSkills[8002],    -- urgent escape
          --AllSkills[8003],              -- brain surgery (passive)
        }
      elseif id == LIF_H or id == LIF_H2 then
        local ret = GetSkillList(LIF)
          ret.Buff2 = AllSkills[8004]     -- mental charge
        return ret
      elseif id == AMISTR or id == AMISTR2 or id == AMISTR_H or id == AMISTR_H2 then
        return {
          Defense = AllSkills[8005],      -- castling
          Buff    = AllSkills[8006],      -- amistr bulwark
          --AllSkills[8007],              -- adamantium skin (passive)
                    AllSkills[8008],      -- blood lust
        }
      elseif id == FILIR or id == FILIR2 or id == FILIR_H or id == FILIR_H2 then
        return {
          Attack  = AllSkills[8009],    -- moonlight
          Buff    = AllSkills[8010],    -- flitting
          Buff2   = AllSkills[8011],    -- accelerated flight
                    AllSkills[8012],    -- sbr 44
        }
      elseif id == VANILMIRTH or id == VANILMIRTH2 or id == VANILMIRTH_H or id == VANILMIRTH_H2 then
        return {
          Attack      = AllSkills[8013],    -- caprice
          HealSelf    = AllSkills[8014],    -- chaotic blessings (heal homu  AI)
          HealOwner   = AllSkills[8014],    -- chaotic blessings (heal owner AI)
          --AllSkills[8015],                -- instruction change (passive)
                        AllSkills[8016],    -- self destruct
        }
      end
      return {}
    end
  end
  
  RAIL.Event["AI CYCLE"]:Register(-40,              -- Priority
                                  "Init Skills",    -- Handler name
                                  1,                -- Max runs
                                  function()
    -- Get our attack range
    RAIL.Self.Skills = GetSkillList(RAIL.Self.AI_Type)
    
    -- Extra info about skills
    local buf = StringBuffer:New()

    for skill_type,skill in pairs(RAIL.Self.Skills) do
      -- Collect skill type and name
      buf:Append(skill)
      if type(skill_type) == "string" then
        buf:Append(" as AI's \""):Append(skill_type):Append("\"")
      end
      buf:Append("; ")
      
    end
    RAIL.LogT(40," --> Skills: {1}",buf:Append(" "):Get())
  end)
end

-- Workaround for RO not updating Amistr's position when castling
if not RAIL.Mercenary then
  RAIL.Event["AI CYCLE"]:Register(-41,              -- Priority
                                  "Amistr Check",   -- Handler name
                                  1,                -- Max runs
                                  function(self)
    -- Check if the homunculus type is Amistr
    if string.upper(string.sub(HomuTypes[RAIL.Self.AI_Type],1,1)) == "A" then
      -- Register an event to run every cycle and check for Castling cast
      RAIL.Event["AI CYCLE"]:Register(1,                  -- Priority
                                      "Castling Check",   -- Handler name
                                      -1,                 -- Max runs (infinite)
                                      function(self)
        -- Get the alchemist's current position
        local o_x,o_y = GetV(V_POSITION,RAIL.Owner.ID)
        
        -- Check if the owner's position is amistr's position last cycle
        if
          o_x == RAIL.Self.X[0] and
          o_y == RAIL.Self.Y[0] and
          o_x ~= RAIL.Owner.X[0] and
          o_y ~= RAIL.Owner.Y[0]
        then
          -- Castling was probably cast, do the work around
          
          -- The Amistr will be at the owner's old position according to the server
          local s_x,s_y = RAIL.Owner.X[0],RAIL.Owner.Y[0]

          -- Move back and forth to force a sync of position between client
          -- server
          local x_mod = o_x - s_x
          x_mod = x_mod / math.abs(x_mod)

          local y_mod = o_y - s_y
          y_mod = y_mod / math.abs(y_mod)

          Move(RAIL.Self.ID,s_x + x_mod, s_y + y_mod)
          RAIL.Target.Chase = { s_x, s_y }
        end
      end)
    end
  end)
end

