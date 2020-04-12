def source_code_1
    File.open(__FILE__) do |f|
      f.readlines.each do |line|
        puts line
      end
    end
end

def source_code_2
 eval s="puts'eval s='+s.inspect"
end

source_code_1
source_code_2
