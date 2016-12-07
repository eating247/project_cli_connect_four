class Board

  attr_reader :columns

  def initialize
    @columns = Array.new(7) { Array.new(6, '-') }
    @rows = @columns.transpose
  end

  def rows(index)
    rows = @columns.transpose
    rows[index]
  end

  def render
    puts
    puts "  1  2  3  4  5  6  7"
    5.downto(0) do |row_index|
      print "|"
      rows(row_index).each do |item|
          print " #{item} "
      end
      print "|"
      puts
    end
  end

  def process_choice(choice, piece)
    column_index = choice - 1
    row_index = @columns[choice-1].index('-')
    @columns[column_index][row_index] = piece
    [column_index, row_index, piece]
  end

  def draw?
    return false if @columns.transpose.flatten.include?('-')
  end

#ALSO returns nil instead of t/f
  def win?(move)
    binding.pry
    column_index = move[0]
    row_index = move[1]
    piece = move[2]
    test_object(rows(row_index), piece)
  end

def test_object(relevant_array, piece)
    test_object = relevant_array.join
    return true if test_object.include?(piece*4)
    false
  end

#also sometimes returns nil...should return only t/f
  def vertical_win?(column_index, piece)
    test_object(@columns[column_index], piece)
  end

#keeps returning nil for some reason..?
  def horizontal_win?(row_index, piece)
    test_object(rows(row_index), piece)
  end

#also not returning t/f
  def diagonal_win?(column_index, row_index, piece)
    test_object(upward_diagonal(column_index, row_index), piece)
    test_object(downward_diagonal(column_index, row_index), piece)
  end

  def upward_diagonal(column_index, row_index)
    generate_diagonal(column_index, row_index, 8)
  end

  def downward_diagonal(column_index, row_index)
    generate_diagonal(column_index, row_index, 6)
  end

#problem with indexes + search_start_point
  def generate_diagonal(column_index, row_index, diff)
    diagonal_array = []
    position_on_searchable = (column_index-1) + ((row_index-1)*7)
    search_start_point = position_on_searchable % 7
    diagonal_indexes = (1..42).to_a.select { |i| i % diff == search_start_point }
    diagonal_indexes.each { |i| diagonal_array << @columns.transpose.flatten[i] }
    diagonal_array
  end



end

#bb = Board.new
#bb.render