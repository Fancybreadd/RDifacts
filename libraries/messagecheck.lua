_G["MessageCheck"] = function(content) --splits your message into several words
   --print("messagechecking!")
   local tablecontent = {}
   for i in string.gmatch (content, "([^".."%s".."]+)") do
        table.insert(tablecontent,i)
        
      print(i)
   end
   
   return tablecontent
end
