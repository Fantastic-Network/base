---@alias DoorId number

---true: Locked
---false: Unlocked
---@alias DoorLockState boolean

---@alias DoorState DoorLockState

---@class Door
---@field id 				DoorId
---@field index 			number
---@field hash				number
---@field position 			vector3
---@field lockState 		DoorLockState
---@field interactionDist 	number
---@field authorizedGroup   string?

---@class DoorArchetype
---@field Coords    vector3
---@field Hash      number
---@field Lock      boolean
---@field Distance  number
---@field Perm      string