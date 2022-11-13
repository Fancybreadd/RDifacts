--splits up messages--
--prefix = h$
print(scandir("Commands"))
for i, v in ipairs(scandir("Commands")) do --i dont know how to use this yet
   local filename = string.sub(v,1,-5)
   print(filename)
   --Cmd[filename] = dofile('Commands/'.. v)
end




_G ["Command"] = {}

_G['addcommand'] = function(trigger, shorttrigger, commandfunction)
   local newcommand = {}
   newcommand.trigger = prefix .. trigger
   newcommand.shorttrigger = prefix .. shorttrigger
   newcommand.commandfunction = commandfunction 
   
   table.insert(Command, newcommand)
end

--addcommand("ping2","p2",Cmd.ping2) --any mention of cmd breaks


A = function (message, content)
   if message.author.id ~= client.user.id or content then
      print(message.content)
      message.channel:send("hi!!")

      local cutup = string.sub(message.content, 0, #message.content)
      print(cutup)
   end
end


_G["MessageCheck"] = A --splits your message into several words

   
      --print("messagechecking!")
   --local tablecontent = {}
   --for i in string.gmatch (content, "([^".."%s".."]+)") do
        --table.insert(tablecontent,i)
        
      --print(i)
   --end
   --if string.sub(tablecontent[1], 1, #prefix) == prefix then -- prefix detected in first word - run this code!
      --Command = string.sub(tablecontent[1], #prefix + 1)
      --if commands[command] == nil then return end -- quick exit if there's no command found
      --commands[command].run(tablecontent[2], tablecontent[3])
   --end
--end
