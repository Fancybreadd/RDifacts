_G["MessageCheck"] = function (message) --splits your message into several words

   local tablecontent = {}
   for words in string.gmatch (message, "([^".."%s".."]+)") do --huh.. how does that work
        print(words)
        --table.insert(tablecontent,words)
   end
   --return tablecontent
end
