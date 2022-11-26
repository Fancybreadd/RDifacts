--splits up messages--

print(scandir("Commands"))
for i, v in ipairs(scandir("Commands")) do --i dont know how to use this yet
   local filename = string.sub(v,1,-5)
   print(filename.."--")
   Cmd[filename] = dofile('Commands/'.. v)
end

_G ["Command"] = {}

_G['addcommand'] = function(trigger, shorttrigger, command, args) --prefix, shorthand prefix, command code
   Command[trigger] = command
   Command[shorttrigger] = Command[trigger]
end

---add commands here---
addcommand('ping','ping',Cmd.ping)
addcommand('help','help',Cmd.help)
addcommand('signup','signup',Cmd.signup)
addcommand('profile','p',Cmd.profile)
addcommand('storage','s',Cmd.storage)
addcommand('dailykey','dk',Cmd.dailykey)
addcommand('cooldown','cd',Cmd.cooldowns)
addcommand('open','o',Cmd.open)
addcommand('adventure','adv',Cmd.adventure)
addcommand('cook','c',Cmd.cook)
addcommand('collection','col',Cmd.collection)
addcommand('collectionshort','cols',Cmd.collectionshort)
addcommand('inspect','i',Cmd.inspect)
--addcommand('display','d',Cmd.display)
-----------------------
print("all commands loaded!")
-----------------------
A = function (message, content)
   if message.author.id ~= client.user.id or content then
      --print("+"..message.content.."+ \n")
      local tablecontent = {}
      --message.channel:send("hi!!")

      for i in string.gmatch (content, "([^".."%s".."]+)") do --cut up message
        table.insert(tablecontent,i) --put all the words in a message inside this table

      --print(i)
      end

      if string.sub(tablecontent[1], 1, #prefix) == prefix then --detects prefix in the first word
         --message.channel:send("yoo!!")
         --print('prefix detected')
         local Commandname = string.sub(tablecontent[1], #prefix + 1) --searches command name to compare it to the same lua file, cuts +1 after h$
         --print(Commandname)

         if tablecontent[2] then --associate extra words as args
            arg = tablecontent[2]
            if tablecontent[3] then
               arg2 = tablecontent[3]
            else arg2 = nil
            end
         else arg = nil
         end

         if Command[Commandname] == nil then return end --if theres no command found, exit
         Command[Commandname].run(message, arg, arg2)
      end
   end
end

_G["MessageCheck"] = A --splits your message into several words, check function A 

