#!/usr/bin/env ruby
###############################################################################
## Rail Fence Cipher Tool by Resheph - For the fun of it.
## The Rail Fence Cipher is a simple Transposition cipher,
## meaning letters keep the value but is moved around in a zigzag like manner.
## It is also known under the name Zigzag Cipher.
## This version only create two rails so it is quite simple.
###############################################################################
# Input:		SOMETEXT
# $buffirst:	S M T X
# $bufsecond:	 O E E T
# Output:       SMTXOEET	($buffirst += $bufsecond)

# Global Varianles
$buffirst = ""					# Buffer for first rail
$bufsecond = ""					# Buffer for second rail

# Functions
def usage()						# Helpscreen
	puts "Rail Fence Cipher Tool v0.1"
	puts "USAGE: ./railfence.rb [filename]"
end

def encrypt(filename)			# Encryption function
	File.open(filename, 'r') do |file|	# Open the file from ARGV for reading
		_shifter = 1					# Set the shifter to 1. We use this to toggle between the two rails by testing if it is odd or even
		file.each_char do |char|		# Read the file one byte at a time
			# This puts one char in buffirst then one char in bufsecond then one in buffirst then one in bufsecond and so on based on if shifter is odd or even
			if (_shifter.odd?) then $buffirst = "#{$buffirst}#{char.to_s}" else $bufsecond = "#{$bufsecond}#{char.to_s}" end		# Alternately put on char from the fil in buffers
			_shifter += 1				# Count up the shifter by 1. This will alternate it between even and odd.
		end
	end									# Will close the file automatically. This happens when the file is opened as part of a block
end

# Main
if ARGV.size != 1 then					# Verify exactly one argument has been given. That should be a filename or we will crash.
	usage()								# Print the helpscreen if we didnt get exactly one argunemt
else
	encrypt(ARGV[0])					# Ge got one argumelt. Calle encrypt() with the filename as an argument
end

puts "#{$buffirst.strip.upcase}#{$bufsecond.strip.upcase}"		# Print the two rails to the stdout in all uppercase
