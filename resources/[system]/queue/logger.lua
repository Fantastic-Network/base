logger = { }

---@vararg any
function logger.log( ... )
    --print( '[QUEUE]', ... )
end

---@vararg any
function logger.debug( ... )
    logger.log( '[DEBUG]', ... )
end