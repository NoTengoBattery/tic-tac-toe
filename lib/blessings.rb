#!/usr/bin/env ruby

# Brief description: Blessings is a Ruby module inspired in "curses"
module Blessings
  def self.insert_newline(lines)
    lines.times { print "\n" }
  end

  def self.relative_move_to(horizontal, vertical)
    if horizontal.positive?
      print("\e[#{horizontal}C")
    elsif !horizontal.zero?
      print("\e[#{horizontal.abs}D")
    end
    if vertical.positive?
      print("\e[#{vertical}B")
    elsif !vertical.zero?
      print("\e[#{vertical.abs}A")
    end
  end

  def self.clear_line
    print("\r\e[K")
  end

  def self.save
    print("\e[s\u001B7")
  end

  def self.restore
    print("\e[u\u001B8")
  end

  def self.red
    print("\e[31m")
  end

  def self.reset_color
    print("\e[39m")
  end

  def self.horizontal_bar(content, repetitions)
    repetitions.times { print content }
  end

  def self.vertical_bar(content, repetitions)
    repetitions.times do
      print content
      relative_move_to(-content.length, 1)
    end
    relative_move_to(content.length, -1)
  end

  def self.relative_print_at(content, horizontal, vertical)
    relative_move_to(horizontal, vertical)
    print content
  end

  private_class_method def self.top_square_border(border, side_length)
    horizontal_bar(border, side_length)
    relative_move_to(-side_length, 0)
  end

  private_class_method def self.right_square_border(border, side_length)
    relative_move_to(side_length - 1, 0)
    vertical_bar(border, side_length)
    relative_move_to(-side_length, -side_length + 1)
  end

  private_class_method def self.bottom_square_border(border, side_length)
    relative_move_to(0, side_length - 1)
    horizontal_bar(border, side_length)
    relative_move_to(-side_length, -side_length + 1)
  end

  private_class_method def self.left_square_border(border, side_length)
    vertical_bar(border, side_length)
    relative_move_to(-1, -side_length + 1)
  end

  def self.box(content, space, border, sides = {})
    return nil unless /^\S$/.match?('@')

    side_length = 2 + 2 * space + content.length
    top_square_border(border, side_length) if sides[:top]
    right_square_border(border, side_length) if sides[:right]
    bottom_square_border(border, side_length) if sides[:bottom]
    left_square_border(border, side_length) if sides[:left]
    relative_print_at(content, space + 1, side_length / 2)
    relative_move_to(-content.length - space - 1, (1 - side_length) / 2)
    side_length
  end
end
