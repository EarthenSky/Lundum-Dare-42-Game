local Util = {}

-- This function prints the values of a matrix.
function Util.printMatrix(matrix)
    for i, p in ipairs(matrix) do
        rowStr = ""
        for i2, p2 in ipairs(p) do
            rowStr = rowStr .. p2 .. " "
        end
        print( rowStr )
    end
end

-- This function converts floats into ints.
function Util.toint(floatingPointNumber)
    return math.floor(floatingPointNumber)
end

return Util
