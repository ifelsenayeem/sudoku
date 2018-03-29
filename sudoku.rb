space=20

# Pattern generator
plant=Array.new(9){Array.new(9)}

column=0
while column<=8

  row=0
  while row<=8

    flower=0
    fruit=0

    if column==0 && row==0
      seed=Random.new.rand(1..9)
      plant[column][row]=seed
    else
      
      while true

        leaf=0
        flower=flower+1

        if flower==100
          break
        end

        if fruit==20
          break
        end

        seed=Random.new.rand(1..9)

        if row>=1
          for temp_row in 0...row
            if plant[column][temp_row]==seed
              leaf=1
            end
          end
        end

        if column>=1
          for temp_column in 0...column
            if plant[temp_column][row]==seed
              leaf=1
            end
          end
        end

        root=(column%3)*10+(row%3) 

        if root==10
          if seed==plant[column-1][row] || seed==plant[column-1][row+1] || seed==plant[column-1][row+2]
            leaf=1
          end
        elsif root==11
          if seed==plant[column-1][row-1] || seed==plant[column-1][row] || seed==plant[column-1][row+1]
            leaf=1
          end
        elsif root==12
          if seed==plant[column-1][row-2] || seed==plant[column-1][row-1] || seed==plant[column-1][row]
            leaf=1
          end
        elsif root==20
          if seed==plant[column-1][row] || seed==plant[column-1][row+1] || seed==plant[column-1][row+2]
            leaf=1
          end
          if seed==plant[column-2][row] || seed==plant[column-2][row+1] || seed==plant[column-2][row+2]
            leaf=1
            fruit=fruit+1
          end
        elsif root==21
          if seed==plant[column-1][row-1] || seed==plant[column-1][row] || seed==plant[column-1][row+1]
            leaf=1
          end
          if seed==plant[column-2][row-1] || seed==plant[column-2][row] || seed==plant[column-2][row+1]
            leaf=1
            fruit=fruit+1
          end
        elsif root==22
          if seed==plant[column-1][row-2] || seed==plant[column-1][row-1] || seed==plant[column-1][row]
            leaf=1
          end
          if seed==plant[column-2][row-2] || seed==plant[column-2][row-1] || seed==plant[column-2][row]
            leaf=1
            fruit=fruit+1
          end
        end

        if leaf==0
          plant[column][row]=seed
          flower=0
          fruit=0
          break
        end

      end
    end

    if flower==100
      column=column-1
      flower=0
      break
    end

    if fruit==20
      column=column-2
      fruit=0
      break
    end

    row=row+1
  end
  column=column+1
end

tree=plant

# Random generator
pot=Array.new(9){Array.new(9)}
for column in 0...9
  for row in 0...9
    pot[column][row]=column*10+row
  end
end

rain=Array.new
stick=0
while stick<space
  seed=pot.sample.sample
  if !rain.include? seed
    rain[stick]=seed
    stick=stick+1
  end
end

for column in 0...9
  for row in 0...9
    if rain.include? (column*10+row)
      tree[column][row]=0
    end
  end
end

# Display and solve

alpha=Time.now

while true

  for column in 0...9

    if column==0
      puts
      
      print "      "
      for stick in 1..9
        print " #{stick} "
        if (stick)%3==0
          print " "
        end
      end
      puts
      puts
      
      print "     "
      for k in 0...31
        print "-"
      end
      puts
    end

    for row in 0...9
      if row==0
        print " #{column+1}   |"
      end

      if tree[column][row]==0
        print "   "
      else
        print " #{tree[column][row]} "
      end

      if (row+1)%3==0
        print "|"
      end
    end

    if (column+1)%3==0
      puts
      print "     "
      for k in 0...31
        print "-"
      end
    end

    puts

  end

  if space>0

    puts
    print "  Row number = "
    i=gets
    i=i.to_i
    print "  Column number = "
    j=gets
    j=j.to_i
    print "  Value = "
    v=gets
    v=v.to_i

    if tree[i-1][j-1]==0 && v!=0
      tree[i-1][j-1]=v
      space=space-1
    end

  else
    
    leaf=0
    for column in 0...9
      sum=0
      for row in 0...9
        sum=sum+tree[column][row]
      end
      
      if sum!=45
        leaf=1
        break
      end
    end

    for column in 0...9
      sum=0
      for row in 0...9
        sum=sum+tree[row][column]
      end

      if sum!=45
        leaf=1
        break
      end
    end

    puts
    if leaf==0
      puts "  Congratulations, You solved it!"
    else
      puts "  Not a proper solution."
    end
    puts
    break
  end
end

beta=Time.now
delta=beta-alpha

delta=Time.at(delta).utc.strftime("%H:%M:%S")
puts "  Time taken to slove - #{delta}"
puts
