
module Printable

  def print_column_numbers
    print (" " * 5).on_red + (" " * 3).on_blue
    (0..8).each do |i|
      print "         #{i}".bold.on_blue
    end
    puts (" " * 10).on_blue + (" " * 5).on_red
  end

  def print_empty_colors
    puts (" " * 5).on_red + 
      (" " * 7).on_blue + 
      (" " * 90) + 
      (" " * 6).on_blue + 
      (" " * 5).on_red
  end

  def print_footer
    puts (" " * 5).on_red + (" " * 103).on_blue + (" " * 5).on_red
    print_column_numbers
    print_two_empty_rows
    print_two_empty_rows_red
  end

  def print_header
    puts "\n\n"
    print_two_empty_rows_red
    puts (" " * 35).on_red + 
      "M   I   N   E   S   W   E   E   P   E   R  !".on_red.bold + 
      (" " * 34).on_red
    print_two_empty_rows_red
    print_two_empty_rows
    print_column_numbers
    puts (" " * 5).on_red + (" " * 103).on_blue + (" "  * 5).on_red
    print_empty_colors
  end

  def print_line(line, i)
    print (" " * 5).on_red + "     #{i} ".bold.on_blue
    line.each do |tile|
      print "  #{tile}  "
    end
    puts " #{i}    ".bold.on_blue + (" " * 5).on_red
    print_empty_colors
  end

  def print_two_empty_rows
    puts (" " * 5).on_red + (" " * 103).on_blue + (" " * 5).on_red
    puts (" " * 5).on_red + (" " * 103).on_blue + (" " * 5).on_red
  end

  def print_two_empty_rows_red
    puts (" " * 113).on_red
    puts (" " * 113).on_red
  end
end