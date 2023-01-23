--splits up messages--

for i, v in ipairs(scandir("Commands")) do
   local filename = string.sub(v,1,-5)
   print(filename.."--")
   Cmd[filename] = dofile('Commands/'.. v)
end

_G ["Command"] = {}

_G['addcommand'] = function(trigger, shorttrigger, command, args) --prefix, shorthand prefix, command code
   Command[trigger] = command
   Command[shorttrigger] = Command[trigger]
end
--note, you have to put both full and shortcut names or else the command wouldnt work
--S = rewrites and saves data
--o = multiarg/friend pingable
---add commands here---
addcommand('signup','signup',Cmd.signup)
addcommand('ping','ping',Cmd.ping)
addcommand('help','help',Cmd.help)
addcommand('profile','p',Cmd.profile) --S --o
addcommand('storage','s',Cmd.storage)
addcommand('dailykey','dk',Cmd.dailykey) --S
addcommand('giftkey','gk',Cmd.giftkey) --S --o
addcommand('open','o',Cmd.open) --S
addcommand('adventure','adv',Cmd.adventure) --S
addcommand('cook','c',Cmd.cook) --S
addcommand('cooldown','cd',Cmd.cooldown)
addcommand('collection','col',Cmd.collection)
addcommand('collectionshort','cols',Cmd.collectionshort) --o
addcommand('inspect','i',Cmd.inspect) --o
addcommand('display','d',Cmd.display) --S --o 
addcommand('credits','credits',Cmd.credits)
-----------------------
print("all commands loaded!")
-----------------------
A = function (message, content)
   if message.author.id ~= client.user.id or content then
      --print("+"..message.content.."+ \n")
      local tablecontent = {}
      --message.channel:send("hi!!")

      if string.sub(content, 1, #prefix) == prefix then --detects prefix in the first word
         --message.channel:send("yoo!!")
         --print('prefix detected')

         for i in string.gmatch (content, "([^".."%s".."]+)") do --cut up message
            table.insert(tablecontent,i) --put all the words in a message inside this table

          --print(i)
          end

         local Commandname = string.sub(tablecontent[1], #prefix + 1) --searches command name to compare it to the same lua file, cuts +1 after h$
         --print(Commandname)
         table.remove(tablecontent, 1)


         if Command[Commandname] == nil then return end --if theres no command found, exit
         Command[Commandname].run(message, table.unpack(tablecontent))
      end
   end
end

_G["MessageCheck"] = A --splits your message into several words, check function A 

