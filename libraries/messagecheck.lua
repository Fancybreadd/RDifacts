_G["MessageCheck"] = function(content) --splits your message into several words
   --print("messagechecking!")
   local tablecontent = {}
   for i in string.gmatch (content, "([^".."%s".."]+)") do
        table.insert(tablecontent,i)
        
      print(i)
   end
   if string.sub(tablecontent[1], 1, #prefix) == prefix then -- prefix detected in first word - run this code!
      command = string.sub(tablecontent[1], #prefix + 1)
      --if commands[command] == nil then return end -- quick exit if there's no command found
      --commands[command].run(tablecontent[2], tablecontent[3])
   end
end
