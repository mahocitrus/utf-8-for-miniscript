//An UTF-8 encoding for my cryptography related projects
encode = function(self) // Convert unicode(a number from string.code) to bytes.
    if self < 0 then
        return null
    else if self <= 127 then
        return [self]
    else if self <= 2047 then
        return [192 + floor(self / 64), 128 + self % 64]
    else if self <= 65535 then
        return [224 + floor(self / 4096), 128 + floor(self / 64) % 64, 128 + self % 64]
    else if self <= 1114111 then
        return [240 + floor(self / 262144), 128 + floor(self / 4096) % 64, 128 + floor(self / 64) % 64, 128 + self % 64]
    else
        return null
    end if
end function
decode = function(self) // Convert bytes(list of 8 bits unsigned integers) to string.
    i = 0
    ret = []
    while i < len(self)
        if self[i] < 0 then
            return null
        else if self[i] < 128 then
            push(ret, char(self[i]))
            i = i + 1
        else if self[i] < 224 and i < len(self) - 1 then
            push(ret, char((self[i] - 192) * 64 + self[i + 1] - 128))
            i = i + 2
        else if self[i] < 240 and i < len(self) - 2 then
            push(ret, char((self[i] - 224) * 4096 + (self[i + 1] - 128) * 64 + self[i + 2] - 128))
            i = i + 3
        else if self[i] < 248 and i < len(self) - 3 then
            push(ret, char((self[i] - 240) * 262144 + (self[i + 1] - 128) * 4096 + (self[i + 2] - 128) * 64 + self[i + 3] - 128))
            i = i + 4
        else
            return null
        end if
    end while
    return join(ret, "")
end function