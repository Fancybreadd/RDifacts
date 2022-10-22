_G["MessageCheck"] = function(content) --splits your message into several words
   print("messagechecking!")
   local tablecontent = {}
   for i in string.gmatch (content, "([^".."%s".."]+)") do --huh.. how does that work
        table.insert(tablecontent,i)
   end
   print(i)
   return tablecontent
end
